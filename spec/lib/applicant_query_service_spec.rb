require_relative "../rails_helper"
require_relative "../spec_helper"
require 'json'

RSpec.describe ApplicantQueryService do
  before(:all) do
    # TODO: fill the other attributes of the applicant here
    user1_json = {
      id: 1,
      utorid: 'someid1',
      student_number: 123456789,
      family_name: "McLovin",
      given_name: "Skeeter",
      program: "UG",
      year: 3,
      previous_ta_experience: false,
      work_status: true,
      work_status_explain: "hhehehhe",
      department: "ECE",
      department_explanation: "i like engineering",
      date_of_application: "2017-03-21T00:00:00.000Z",
      phone_number: "4169671111",
      previously_declined: false,
      remaining_teaching_hours: 0,
      status: "Assigned"
    }

    user2_json = {
      id: 2,
      utorid: 'someid2',
      student_number: 99990213,
      family_name: "Cartman",
      given_name: "Eric",
      program: "PHD",
      year: 5,
      previous_ta_experience: true,
      work_status: false,
      work_status_explain: "hhehehhe",
      department: "CS",
      department_explanation: "i hate engineering",
      date_of_application: "2017-05-21T00:00:00.000Z",
      phone_number: "4169671111",
      previously_declined: false,
      remaining_teaching_hours: 40,
    }

    @applicants = generate_json_objects([user1_json, user2_json])
  end

  it "queries by program" do
    query = {program: "UG"}

    a = ApplicantQueryService.new(@applicants, query).query
    user = a[0]

    expect(a).to_not be_empty
    expect(user["id"] == 1)
  end

  it "queries by previous_ta_experience" do
    query = {previous_ta_experience: 'true'}

    a = ApplicantQueryService.new(@applicants, query).query
    user = a[0]

    expect(a).to_not be_empty
    expect(user["id"]).to eq(2)
  end

  private

  def generate_json_objects(applicant_list)
    applicant_list.map do |applicant|
      JSON.parse(JSON.generate(applicant))
    end
  end

end
