class ApplicantQueryService
  def initialize(applicants_json, query)
    @applicants = applicants_json
    @query = query
  end

  def query
    if @query[:department]
      @applicants = @applicants.select { |a| a["department"] == @query[:department] }
    end

    if @query[:previous_ta_experience]
      @applicants = @applicants.select { |a| "#{a['previous_ta_experience']}" == @query[:previous_ta_experience] }
    end

    if @query[:program]
      @applicants = @applicants.select { |a| a["program"] == @query[:program] }
    end

    if @query[:year]
      @applicants = @applicants.select { |a| "#{a['year']}" == @query[:year] }
    end

    if @query[:work_status]
      @applicants = @applicants.select { |a| "#{a['work_status']}" == @query[:work_status] }
    end

    if @query[:previously_declined]
      @applicants = @applicants.select { |a| "#{a['previously_declined']}" == @query[:previously_declined] }
    end

    if @query[:remaining_teaching_hours]
      @applicants = @applicants.select { |a| a["remaining_teaching_hours"] > 0 }
    end

    @applicants
  end
end
