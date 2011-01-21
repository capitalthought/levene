require 'rubygems'
require 'minitest/autorun'
require 'salesforce'

class Object
  def must_be_true
    must_equal true
  end

  def must_be_false
    must_equal false
  end
end
