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

    if @sort_by == "family_name"
      @applicants = @applicants.sort_by do |applicant|
        applicant["family_name"]
      end
    end

    @applicants
  end
end
