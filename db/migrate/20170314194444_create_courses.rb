class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
    	t.string 	:course_code
    	t.string 	:description
    	t.string 	:term
    	t.string 	:projected
    	t.integer 	:students_per_Ta
    	t.string	:instructor_id
    	t.string	:requirements
		t.timestamps
    end

    
  end
end
