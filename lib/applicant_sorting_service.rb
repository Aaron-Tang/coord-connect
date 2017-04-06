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

    if @sort_by == "remaining_teaching_hours"
      @applicants = @applicants.sort_by do |applicant|
        -applicant["remaining_teaching_hours"]
      end
    end

    if @sort_by == "year"
      @applicants = @applicants.sort_by do |applicant|
        -applicant["year"]
      end
    end

    if @sort_by == "submitted_at"
      @applicants = @applicants.sort_by do |applicant|
        applicant["submitted_at"]
      end
    end

    if @sort_by == "preferences"
      @applicants = @applicants.sort_by do |applicant|
        -applicant["preferences"]
      end
    end

    @applicants
  end
end
