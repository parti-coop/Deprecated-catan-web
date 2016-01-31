require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest
  test 'like' do
    sign_in users(:two)

    refute opinions(:opinion1).liked_by?(users(:two))
    post opinion_likes_path(opinion_id: opinions(:opinion1).id)

    assert opinions(:opinion1).liked_by?(users(:two))
    delete by_me_opinion_likes_path(opinion_id: opinions(:opinion1).id)
  end

  test 'should not like by writer' do
    sign_in users(:one)

    refute opinions(:opinion1).liked_by?(users(:one))
    post opinion_likes_path(opinion_id: opinions(:opinion1).id)
    refute opinions(:opinion1).liked_by?(users(:one))
  end
end
