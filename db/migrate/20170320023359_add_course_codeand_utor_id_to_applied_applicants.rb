class AddCourseCodeandUtorIdToAppliedApplicants < ActiveRecord::Migration[5.0]
  def change
    add_column :applied_applicants, :utorid, :string
    add_column :applied_applicants, :course_code, :string
  end
end
