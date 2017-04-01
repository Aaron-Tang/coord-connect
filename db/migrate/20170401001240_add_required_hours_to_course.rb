class AddRequiredHoursToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :required_hours, :int, default: 0
  end
end
