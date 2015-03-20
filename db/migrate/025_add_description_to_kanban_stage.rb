class AddDescriptionToKanbanStage < ActiveRecord::Migration
  def change
    add_column :kanban_stages, :description, :text
  end
end
