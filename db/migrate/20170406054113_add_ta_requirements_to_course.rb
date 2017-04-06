class AddTaRequirementsToCourse < ActiveRecord::Migration[5.0]
  def change
  	add_column :courses, :required_TAs, :int, default: 0
  end
end

