require 'helper'

describe Levene::Models::Base do

  it "should be abstract" do
    Levene::Models::Base.abstract?.must_be_true
  end
end
