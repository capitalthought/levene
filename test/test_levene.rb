require 'helper'

describe Levene do

  it "should be enabled if the right ENV vars are in place" do
    old_user, old_pass = ENV["SALESFORCE_DEV_USER"], ENV["SALESFORCE_DEV_PASS"]
    ENV["SALESFORCE_DEV_USER"] = "foo"
    ENV["SALESFORCE_DEV_PASS"] = "bar"
    Levene.enabled?.must_be_true
    ENV["SALESFORCE_DEV_USER"], ENV["SALESFORCE_DEV_PASS"] = old_user, old_pass
  end

  it "should not be enabled if ENV vars are missing" do
    old_user, old_pass = ENV["SALESFORCE_DEV_USER"], ENV["SALESFORCE_DEV_PASS"]
    ENV["SALESFORCE_DEV_USER"] = nil
    ENV["SALESFORCE_DEV_PASS"] = nil
    Levene.enabled?.must_be_false
    ENV["SALESFORCE_DEV_USER"], ENV["SALESFORCE_DEV_PASS"] = old_user, old_pass
    
  end
end
    
