require 'test_helper'

class OpinionsTest < ActionDispatch::IntegrationTest
  test 'new' do
    sign_in users(:one)
    post position_opinions_path(position_id: positions(:position1).id, opinion: { body: 'desc'})

    assert_equal users(:one), assigns(:opinion).user
    assert_equal 'desc', assigns(:opinion).body
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
