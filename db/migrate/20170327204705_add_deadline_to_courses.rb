class AddDeadlineToCourses < ActiveRecord::Migration[5.0]
  def change
  	add_column :courses, :deadline, :datetime
  end
end
