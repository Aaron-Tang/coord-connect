require_relative "../rails_helper"
require_relative "../spec_helper"

RSpec.describe OfferController, type: :controller do

	describe "GET index" do
	    it "returns all courses" do
	      offer = Offer.create!(
	      	application_id: 1, 
	      	status: "P"
	      	)
	      get :index
	      expect(response.body).to include("P")
	    end
	end

  it "returns offers given utorid and course_code" do
    course_id = Course.create!(course_code: "CSC108").id
    Offer.create!(
      course_code: "CSC108",
      utorid: "someid1",
      status: "Assigned"
    )
    Offer.create!(
      course_code: "CSC207",
      utorid: "someid1",
      status: "Assigned"
    )
    get :get_offer_for_application, params: {utorid: "someid1", course_id: course_id}
    expect(response.body).to include("someid1")
    expect(response.body).to_not include("csc207")
  end 

  it "creates an assignment" do
    post :create, { applications: {course_code: "CSC108", utorid: "testuser"} }

    assignment = Offer.all.first

    expect(assignment.utorid).to eq("testuser")
    expect(assignment.course_code).to eq("CSC108")
    expect(assignment.status).to eq("Assigned")
  end

  it "returns a list of assignments by course id" do
    course_id = Course.create!(course_code: "CSC108").id
    Offer.create!(
      course_code: "CSC108",
      utorid: "testuser",
      status: "Assigned"
    )
    Offer.create!(
      course_code: "CSC207",
      utorid: "testuser2",
      status: "Assigned"
    )

    p Offer.all

    get :for_course, params: {course_id: course_id, status: "Assigned"}

    expect(response.body).to include("testuser")
    expect(response.body).to_not include("testuser2")
  end

  it "allows you to make bulk assignments" do
    c = Course.create!(course_code: "CSC108")


    post :bulk_create, { 
      assignments: 
        [{course_id: c.id, utorid: "testuser"},
         {course_id: c.id, utorid: "testuser2"}]
    }

    expect(Offer.all.length).to eq(2)
  end

  it "allows you to update an assignment by providing the utorid and course_id" do
    Offer.create!(course_code: "CSC108", utorid: "testuser", status: "Assigned")

    put :update_assignment, params: {assignment: {utorid: "testuser", course_code: "CSC108", status: "Unassigned"}}

    updated_offer = Offer.all.first

    expect(updated_offer.status).to eq("Unassigned")
  end

	describe "PATCH" do
	    it "update application status" do
	      @offer = Offer.create!(
	      	application_id: 1, 
	      	status: "P"
	      	)

				
		put :update, id: @offer, applications: {:status => 'R'}
		@offer.reload
	      expect(response.body).to include("R")
	    end
	end	  


end
