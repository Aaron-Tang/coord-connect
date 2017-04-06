require_relative "../rails_helper"
require_relative "../spec_helper"
require 'json'

RSpec.describe ApplicantSortingService do
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
      status: "Assigned",
      preferences: 5,
      submitted_at: DateTime.new(2017, 3, 21),
      taken_in_past: false
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
      preferences: 3,
      submitted_at: DateTime.new(2017, 3, 22),
      taken_in_past: true

    }

    @applicants = generate_json_objects([user1_json, user2_json])
  end

  it "sorts by family_name" do
    sort_by = "family_name"

    a = ApplicantSortingService.new(@applicants, sort_by).order
    user = a[0]

    expect(a).to_not be_empty
    expect(user["id"] == 1)
  end

  it "sorts by given_name" do
    sort_by = "given_name"

    a = ApplicantSortingService.new(@applicants, sort_by).order
    user = a[0]

    expect(a).to_not be_empty
    expect(user["id"] == 2)
  end

  it "sorts by remaining_teaching_hours descending" do
    sort_by = "remaining_teaching_hours"
    a = ApplicantSortingService.new(@applicants, sort_by).order
    user1 = a[0]
    user2 = a[1]

    expect(a).to_not be_empty
    expect(user1["id"] == 2)
    expect(user2["id"] == 1)
  end

  it "sorts by year descending" do
    sort_by = "year"
    a = ApplicantSortingService.new(@applicants, sort_by).order
    user1 = a[0]
    user2 = a[1]

    expect(a).to_not be_empty
    expect(user1["id"] == 2)
    expect(user2["id"] == 1)
  end

  it "sorts by submitted_at" do
    sort_by = "submitted_at"
    a = ApplicantSortingService.new(@applicants, sort_by).order
    user1 = a[0]
    user2 = a[1]

    expect(a).to_not be_empty
    expect(user1["id"] == 1)
    expect(user2["id"] == 2)
  end

  it "sorts by preferences" do
    sort_by = "preferences"
    a = ApplicantSortingService.new(@applicants, sort_by).order
    user1 = a[0]
    user2 = a[1]

    expect(a).to_not be_empty
    expect(user1["id"] == 1)
    expect(user2["id"] == 2)
  end

  private

  def generate_json_objects(applicant_list)
    applicant_list.map do |applicant|
      JSON.parse(JSON.generate(applicant))
    end
  end

end
