require 'test_helper'

class SupportTest < ActionDispatch::IntegrationTest
  test 'create' do
    sign_in users(:one)
    post supports_path(support: { leader_id: users(:two).id })

    assert_equal users(:two), assigns(:support).leader
    assert_equal users(:one), assigns(:support).supporter
    assert assigns(:support).persisted?
  end

  test 'block to support myself' do
    sign_in users(:one)
    post supports_path(support: { leader_id: users(:one).id })

    refute assigns(:support).persisted?
  end

  test 'cancel' do
    sign_in users(:one)
    post supports_path(support: { leader_id: users(:two).id })

    delete cancel_supports_path(leader_id: users(:two).id)
    refute Support.exists?(leader: users(:two), supporter: users(:one))
  end
end
