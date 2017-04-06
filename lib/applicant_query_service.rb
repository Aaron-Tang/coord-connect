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

    if @query[:preferences]
      @applicants = @applicants.select { |a| a["preferences"] == @query[:preferences]}
    end

    if @query[:submitted_at]
      @applicants = @applicants.select { |a| a["submitted_at"] <= @query[:submitted_at]}
    end

    if @query[:taken_in_past]
      @applicants = @applicants.select { |a| a["taken_in_past"] == @query[:taken_in_past]}
    end

    if @query[:given_name]
      @applicants = @applicants.select { |a|
        !(/#{@query[:given_name]}/.match(a["given_name"]).nil?)
      }
    end

    if @query[:family_name]
      @applicants = @applicants.select { |a|
        !(/#{@query[:family_name]}/.match(a["family_name"]).nil?)
      }
    end    

    if @query[:utorid]
      @applicants = @applicants.select { |a|
        !(/#{@query[:utorid]}/.match(a["utorid"]).nil?)
      }    
    end

    @applicants
  end
end
