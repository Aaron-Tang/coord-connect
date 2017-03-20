require_relative "../rails_helper"
require_relative "../spec_helper"

RSpec.describe AppliedApplicantsController, type: :controller do

	describe "GET index" do
	    it "returns all courses" do
	      applied_applicant = AppliedApplicant.create!(
	      	applicantion_id: 1, 
	      	status: "P"
	      	)
	      get :index
	      expect(response.body).to include("P")
	    end
	end

  it "creates an assignment" do
    post :create, { applications: {course_code: "CSC108", utorid: "testuser"} }

    assignment = AppliedApplicant.all.first

    expect(assignment.utorid).to eq("testuser")
    expect(assignment.course_code).to eq("CSC108")
    expect(assignment.status).to eq("Assigned")
  end

  it "returns a list of assignments by course code" do
    AppliedApplicant.create!(
      course_code: "CSC108",
      utorid: "testuser",
      status: "Assigned"
    )

    AppliedApplicant.create!(
      course_code: "CSC207",
      utorid: "testuser2",
      status: "Assigned"
    )
    get :for_course, params: {course_code: "CSC108"}

    expect(response.body).to include("testuser")
    expect(response.body).to_not include("testuser2")
  end

  it "allows you to make bulk assignments" do

    post :bulk_create, { 
      assignments: 
        [{course_code: "CSC108", utorid: "testuser"},
         {course_code: "CSC108", utorid: "testuser2"}]
    }

    expect(AppliedApplicant.all.length).to eq(2)
  end

	describe "PATCH" do
	    it "update application status" do
	      @applied_applicant = AppliedApplicant.create!(
	      	applicantion_id: 1, 
	      	status: "P"
	      	)

				
		put :update, id: @applied_applicant, applications: {:status => 'R'}
		@applied_applicant.reload
	      expect(response.body).to include("R")
	    end
	end	  

end
