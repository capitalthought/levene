require 'helper'

describe Salesforce::Models::Base do

  it "should be abstract" do
    Salesforce::Models::Base.abstract?.must_be_true
  end
end
