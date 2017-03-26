require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  test 'responds to .filterrific_find' do
    assert_respond_to(Course, :filterrific_find)
  end
end
