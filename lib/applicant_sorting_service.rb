class ApplicantSortingService
  def initialize(applicants_json, sort_by)
    @applicants = applicants_json
    @sort_by = sort_by
  end

  def order
    if @sort_by == "given_name"
      @applicants = @applicants.sort_by do |applicant|
        applicant["given_name"]
      end
    end

    @applicants
  end
end
