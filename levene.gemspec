# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{levene}
  s.version = "0.0.1.20110120183512"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robert Rasmussen"]
  s.date = %q{2011-01-20}
  s.description = %q{Levene allows you to easily create models that map to their Salesforce
API counterpart:

    class Contact < Levene::Models::Base
    end

Creating a subclass of Levene::Models::Base will cause the fields of the
relevant Salesforce object to be looked up, and will create accessors
and ActiveModel validations based on the field definititions.

    contact = Contact.new
    contact.valid? #=> false
    contact.errors.full_messages #=> ["Last name can't be blank"] 
    contact.first_name = "Ricky"
    contact.last_name = "Roma"
    contact.description = "The guy is a closer."
    contact.save #=> true
    contact.id #=> "00AA000006636drIAA"


This is not a replacement for the ActiveRecord connection adapter for
Salesforce. Levene is mostly for people who need to push data up to 
Salesforce in the background. *It is not thread-safe*.}
  s.email = ["rob.rasmussen@gmail.com"]
  s.extra_rdoc_files = ["Manifest.txt", "README.markdown"]
  s.files = ["Manifest.txt", "README.markdown", "Rakefile", "levene.gemspec", "lib/levene.rb", "lib/levene/version.rb", "lib/levene/connection.rb", "lib/levene/models/lead.rb", "test/helper.rb", "test/test_login.rb", "test/test_lead_model.rb"]
  s.homepage = %q{A light wrapper around RForce to make working with Salesforce a little}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{levene}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Levene allows you to easily create models that map to their Salesforce API counterpart:  class Contact < Levene::Models::Base end  Creating a subclass of Levene::Models::Base will cause the fields of the relevant Salesforce object to be looked up, and will create accessors and ActiveModel validations based on the field definititions}
  s.test_files = ["test/test_lead_model.rb", "test/test_login.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0.3"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.3"])
      s.add_runtime_dependency(%q<rforce>, ["~> 0.6.0"])
      s.add_development_dependency(%q<minitest>, [">= 1.6.0"])
      s.add_development_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.8.0"])
    else
      s.add_dependency(%q<activemodel>, [">= 3.0.3"])
      s.add_dependency(%q<activesupport>, [">= 3.0.3"])
      s.add_dependency(%q<rforce>, ["~> 0.6.0"])
      s.add_dependency(%q<minitest>, [">= 1.6.0"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_dependency(%q<hoe>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 3.0.3"])
    s.add_dependency(%q<activesupport>, [">= 3.0.3"])
    s.add_dependency(%q<rforce>, ["~> 0.6.0"])
    s.add_dependency(%q<minitest>, [">= 1.6.0"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
    s.add_dependency(%q<hoe>, [">= 2.8.0"])
  end
end
