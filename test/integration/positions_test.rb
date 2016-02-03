require 'test_helper'

class PositionsTest < ActionDispatch::IntegrationTest
  test 'create' do
    sign_in users(:one)
    post positions_path(position: { body: 'desc'})

    assert_equal users(:one), assigns(:position).user
    assert_equal 'desc', assigns(:position).body
  end

  test 'activity' do
    sign_in users(:one)
    post positions_path(position: { body: 'desc'})

    activity = Activity.by(users(:one)).first
    assert_equal assigns(:position), activity.position
    assert_equal assigns(:position), activity.trackable
    assert_equal users(:one), activity.user
    assert_equal 'create_position', activity.key
  end

  test 'edit by owner' do
    sign_in users(:one)

    body = positions(:position1).body + 'xx'
    put position_path(id: positions(:position1).id, position: { body: body })

    assert_equal body, assigns(:position).body
  end

  test 'should not edit by visitor' do
    sign_in users(:two)

    origin_body = positions(:position1).body
    put position_path(id: positions(:position1).id, position: { body: 'diff' })

    assert_equal origin_body, assigns(:position).body
  end

  test 'destroy' do
    sign_in users(:one)
    delete position_path(id: positions(:position1).id)

    refute Position.exists?(positions(:position1).id)
  end

  test 'should not destroy by visitor' do
    sign_in users(:two)
    delete position_path(id: positions(:position1).id)

    assert Position.exists?(positions(:position1).id)
  end
end
