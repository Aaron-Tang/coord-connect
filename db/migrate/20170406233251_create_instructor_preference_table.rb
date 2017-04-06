class CreateInstructorPreferenceTable < ActiveRecord::Migration[5.0]
  def change
    create_table :instructor_preference_tables do |t|
    	t.string 	:course_id
    	t.string 	:user_id
    	t.boolean 	:preference
    end
  end
end
