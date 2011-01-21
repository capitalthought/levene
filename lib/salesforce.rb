require 'rforce'
require 'active_support'

module Salesforce
  autoload :Connection, "salesforce/connection.rb"
  module Models
    autoload :Base, "salesforce/models/base.rb"
    autoload :Account, "salesforce/models/account.rb"
    autoload :Campaign, "salesforce/models/campaign.rb"
    autoload :CampaignMember, "salesforce/models/campaign_member.rb"
    autoload :Contact, "salesforce/models/contact.rb"
    autoload :Lead, "salesforce/models/lead.rb"
    autoload :Opportunity, "salesforce/models/opportunity.rb"

  end
  module Extensions
    autoload :Binding, "salesforce/extensions/binding.rb"
  end
end

RForce::Binding.send(:include, Salesforce::Extensions::Binding)
