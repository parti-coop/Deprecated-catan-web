require 'test_helper'

class PositionsTest < ActionDispatch::IntegrationTest
  test 'create' do
    sign_in users(:one)
    post positions_path(position: { body: 'desc' }, issue_title: issues(:issue1).title)

    assert_equal users(:one), assigns(:position).user
    assert_equal 'desc', assigns(:position).body
    assert_equal issues(:issue1), assigns(:position).issue
  end

  test 'create with new issue' do
    sign_in users(:one)
    post positions_path(position: { body: 'desc' }, issue_title: 'new issue')

    assert_equal users(:one), assigns(:position).user
    assert_equal 'desc', assigns(:position).body
    assert_equal 'new issue', assigns(:position).issue.title
  end

  test 'activity' do
    sign_in users(:one)
    post positions_path(position: { body: 'desc' }, issue_title: issues(:issue1).title)

    activity = Activity.by(users(:one)).first
    assert_equal assigns(:position), activity.position
    assert_equal assigns(:position), activity.trackable
    assert_equal users(:one), activity.user
    assert_equal 'create_position', activity.key
  end

  test 'edit by owner' do
    sign_in users(:one)

    body = positions(:position1).body + 'xx'
    put position_path(id: positions(:position1).id, position: { body: body }, issue_title: positions(:position1).issue.title)

    assert_equal body, assigns(:position).body
    assert_equal positions(:position1).issue, assigns(:position).issue
  end

  test 'edit with new issue' do
    sign_in users(:one)

    put position_path(id: positions(:position1).id, position: { body: 'test' }, issue_title: '나이슈')

    assert_equal '나이슈', assigns(:position).issue.title
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
