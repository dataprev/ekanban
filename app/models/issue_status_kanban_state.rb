class IssueStatusKanbanState < ActiveRecord::Base
  unloadable

  belongs_to  :kanban_state
  belongs_to  :issue_status

  has_many :kanban_pane, :through => :kanban_state

  def self.state_id(issue_status_id,tracker_id)
    rec = IssueStatusKanbanState.find(:all, :conditions => ["#{KanbanState.table_name}.tracker_id=? and issue_status_id = ?", tracker_id,issue_status_id], :include => :kanban_state)
    return rec.first.kanban_state_id if !rec.first.nil?
  end

  def self.state_id_new(issue_status_id,tracker_id,issue_id)
    issue = Issue.find(issue_id)
    pos = issue.kanban_card.kanban_pane.position
    rec = IssueStatusKanbanState.find(:all, :conditions => ["#{KanbanState.table_name}.tracker_id=? and #{KanbanPane.table_name}.position > ? and issue_status_id = ?", tracker_id,pos,issue_status_id], :include => [:kanban_state, :kanban_pane], :order => "#{KanbanPane.table_name}.position")
    return rec.first.kanban_state_id if !rec.first.nil?
  end

  def self.status_id(kanban_state_id)
  	rec = IssueStatusKanbanState.where('kanban_state_id=?', kanban_state_id)
  	return rec.first.issue_status_id if !rec.first.nil?
  end
end
