require 'helper'

describe Levene::Models::Lead do
  before do
    @lead = Levene::Models::Lead.new
  end

  it "should conform to ActiveModel::Naming" do
    @lead.class.model_name.must_equal "Levene::Models::Lead"
    @lead.class.model_name.human.must_equal "Lead"
  end

  it "should not be abstract" do
    @lead.class.abstract?.must_be_false
  end

  it "should have a list of columns" do
    @lead.class.columns.count.must_be :>, 0
  end

  it "should have a connection attribute" do
    @lead.class.must_respond_to :connection
  end

  it "should respond to #save" do
    @lead.must_respond_to :save
  end

end
