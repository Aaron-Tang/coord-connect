class RenameCoursesColumns < ActiveRecord::Migration[5.0]
  def change
  	rename_column :courses, :projected, :projected_course_enrollment
  	rename_column :courses, :students_per_Ta, :students_per_TA
  end
end
