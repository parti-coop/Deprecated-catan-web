require 'test_helper'

class IssuesTest < ActionDispatch::IntegrationTest
  test 'create' do
    sign_in users(:one)
    post issues_path(issue: { title:'test title', description: 'test description' })

    assert_equal users(:one), assigns(:issue).user
    assert_equal 'test description', assigns(:issue).description
    assert_equal 'test title', assigns(:issue).title
  end
end