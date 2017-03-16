class CreateAppliedApplicants < ActiveRecord::Migration[5.0]
  def change
    create_table :applied_applicants do |t|
    	t.integer	:applicantion_id
    	t.string	:status
      t.timestamps
    end
  end
end
