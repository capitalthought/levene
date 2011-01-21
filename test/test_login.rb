require 'helper'

describe Levene::Connection do
  before do
    @connection = Levene::Connection.new
  end

  it "must respond to #login" do
    @connection.must_respond_to :login
  end

  it "must respond to #binding" do
    @connection.must_respond_to :binding
  end

  describe "with valid user credentials" do
    before do
      @username = ENV["SALESFORCE_DEV_USER"]
      @password = ENV["SALESFORCE_DEV_PASS"]
    end

    it "should return a truthy value for a successful login" do
      assert @connection.login(@username, @password), "Successful login should return something truthy"
    end

    it "should report is has a ssession after a successful login" do
      @connection.login(@username, @password)
      @connection.has_session?.must_be_true
    end
  end

  describe "with invalid user credentials" do
    before do
      @username= "foo"
      @password = "bar"
    end
    
    it "should return false for an unsuccessful login" do
      assert !@connection.login(@username, @password), "Unsuccessful login should return someing falsy"
    end

    it "should not have a session after an unsuccessful login" do
      @connection.login(@username, @password)
      assert @connection.has_session?.must_be_false
    end
  end


  describe "a logged in connection" do
    before do
      @connection.login(ENV["SALESFORCE_DEV_USER"], ENV["SALESFORCE_DEV_PASS"])
    end

    it "should yield a levene binding from start" do
      @connection.start do |binding|
        binding.must_be_kind_of RForce::Binding
        @connection.has_session?.must_be_true
      end
    end

    it "should not have an active binding after the block finished" do
      @connection.start {|binding| }
      @connection.has_session?.must_be_false 
    end
  end
end
