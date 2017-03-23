class RenameAppliedApplicants < ActiveRecord::Migration[5.0]
  def change
  	rename_table :applied_applicants, :offers
  end
end
