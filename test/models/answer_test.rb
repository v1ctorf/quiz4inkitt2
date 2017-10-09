require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  
  test "should not save answer without option" do
    answer = Answer.new
    assert_not answer.save, "Saved the answer without an option"
  end
end

# see how an error gets reported, here's a test containing an error:
# http://guides.rubyonrails.org/v4.2/testing.html