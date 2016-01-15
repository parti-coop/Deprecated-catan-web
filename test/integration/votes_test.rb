require 'test_helper'

class VotesTest < ActionDispatch::IntegrationTest
  test 'new' do
    sign_in users(:one)
    post position_votes_path(position_id: positions(:position1).id, vote: { choice: :agree })

    assert_equal users(:one), assigns(:vote).user
    assert_equal 'agree', assigns(:vote).choice
  end

  test 'no duplication with same choice' do
    previous_count = positions(:position1).votes.count

    sign_in users(:two)
    post position_votes_path(position_id: positions(:position1).id, vote: { choice: :agree })

    assert_equal previous_count, positions(:position1).votes.count
  end

  test 'change choice' do
    assert positions(:position1).agreed? users(:two)

    sign_in users(:two)
    post position_votes_path(position_id: positions(:position1).id, vote: { choice: :disagree })

    refute positions(:position1).reload.agreed? users(:two)
  end
end
