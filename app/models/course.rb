class Course < ApplicationRecord
	filterrific :default_filter_params => { :sorted_by => 'created_at_asc' },
	              :available_filters => %w[
	                sorted_by
	                search_query
	              ]

	has_many :offers

	self.per_page = 10

	scope :search_query, lambda { |query|
	    return nil  if query.blank?
	    terms = query.downcase.split(/\s+/)

	    terms = terms.map { |e|
	      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
	    }

	    num_or_conditions = 1
	    where(
	      terms.map {
	        or_clauses = [
	          "courses.course_code LIKE ?"
	        ].join(' OR ')
	        "(#{ or_clauses })"
	      }.join(' AND '),
	      *terms.map { |e| [e] * num_or_conditions }.flatten
	    )
	}

	scope :sorted_by, lambda { |sort_option|
    	# extract the sort direction from the param value.
	    direction = (sort_option =~ /asc$/) ? 'asc' : 'desc'
	    case sort_option.to_s
	    when /^created_at_/
	      order("courses.created_at #{ direction }")
	    else
	      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	    end
	}

	def self.options_for_sorted_by
		[
			['Course Code (Ascending)', 'course_code_asc']
		]
	end	
end
