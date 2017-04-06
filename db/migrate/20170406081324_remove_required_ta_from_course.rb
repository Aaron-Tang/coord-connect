class RemoveRequiredTaFromCourse < ActiveRecord::Migration[5.0]
  def change
  	remove_column :courses, :required_TAs, :int, default: 0
  end
end
