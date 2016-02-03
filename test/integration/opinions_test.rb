require 'test_helper'

class OpinionsTest < ActionDispatch::IntegrationTest
  test 'create' do
    sign_in users(:two)
    assert positions(:position1).agreed?(users(:two))
    post position_opinions_path(position_id: positions(:position1).id, opinion: { body: 'desc' })

    assert_equal users(:two), assigns(:opinion).user
    assert_equal 'desc', assigns(:opinion).body
    assert_equal 'agree', assigns(:opinion).choice
  end

  test 'activity' do
    sign_in users(:two)
    post position_opinions_path(position_id: positions(:position1).id, opinion: { body: 'desc' })

    activity = Activity.by(users(:two)).first
    assert_equal assigns(:position), activity.position
    assert_equal assigns(:opinion), activity.trackable
    assert_equal users(:two), activity.user
    assert_equal 'create_opinion', activity.key
  end

  test 'respond' do
    sign_in users(:two)
    assert positions(:position1).agreed?(users(:two))
    post position_opinions_path(position_id: positions(:position1).id, opinion: { body: 'desc', source_id: opinions(:opinion1).id })
    assert_equal opinions(:opinion1), assigns(:opinion).source
  end

  test 'edit by owner' do
    sign_in users(:one)

    body = opinions(:opinion1).body + 'xx'
    put opinion_path(id: opinions(:opinion1).id, opinion: { body: body })

    assert_equal body, assigns(:opinion).body
  end

  test 'should not edit by visitor' do
    sign_in users(:two)

    origin_body = opinions(:opinion1).body
    put opinion_path(id: opinions(:opinion1).id, opinion: { body: 'diff' })

    assert_equal origin_body, assigns(:opinion).body
  end

  test 'destroy' do
    sign_in users(:one)
    delete opinion_path(id: opinions(:opinion1).id)

    refute Opinion.exists?(opinions(:opinion1).id)
  end

  test 'should not destroy by visitor' do
    assert Opinion.exists?(opinions(:opinion1).id)

    sign_in users(:two)
    delete opinion_path(id: opinions(:opinion1).id)

    assert Opinion.exists?(opinions(:opinion1).id)
  end

  test 'create by voted user' do
    assert positions(:position1).agreed? users(:two)

    sign_in users(:two)
    post position_opinions_path(position_id: positions(:position1).id, opinion: { body: 'desc'})

    assert_equal 'agree', assigns(:opinion).choice
  end
end
