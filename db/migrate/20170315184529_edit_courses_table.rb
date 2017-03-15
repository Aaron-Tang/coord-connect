class EditCoursesTable < ActiveRecord::Migration[5.0]
  def change
  	remove_column :courses, :projected_course_enrollment
  	add_column :courses, :projected_course_enrollment, :integer
  end
end
