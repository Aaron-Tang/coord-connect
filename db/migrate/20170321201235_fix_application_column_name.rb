class FixApplicationColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :applied_applicants, :applicantion_id, :application_id
  end
end
