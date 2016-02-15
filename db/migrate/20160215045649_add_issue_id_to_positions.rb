class AddIssueIdToPositions < ActiveRecord::Migration
  def change
    add_reference :positions, :issue, index: true
    change_column_null :positions, :issue_id, false
  end
end
