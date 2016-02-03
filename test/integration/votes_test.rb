require 'test_helper'

class VotesTest < ActionDispatch::IntegrationTest
  test 'create' do
    sign_in users(:one)
    post position_votes_path(position_id: positions(:position1).id, vote: { choice: :agree })

    assert_equal users(:one), assigns(:vote).user
    assert_equal 'agree', assigns(:vote).choice
  end

  test 'activity' do
    sign_in users(:one)
    post position_votes_path(position_id: positions(:position1).id, vote: { choice: :agree })

    activity = Activity.by(users(:one)).first
    assert_equal assigns(:position), activity.position
    assert_equal assigns(:vote), activity.trackable
    assert_equal users(:one), activity.user
    assert_equal 'vote', activity.key
    previous = activity.created_at

    Timecop.freeze(14.days.from_now) do
      post position_votes_path(position_id: positions(:position1).id, vote: { choice: :disagree })
      refute_equal previous, Activity.by(users(:one)).reload.first.created_at
    end
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
