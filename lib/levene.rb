require 'rforce'
require 'active_support'

module Levene
  autoload :Connection, "levene/connection.rb"
  module Models
    autoload :Base, "levene/models/base.rb"
    autoload :Account, "levene/models/account.rb"
    autoload :Campaign, "levene/models/campaign.rb"
    autoload :CampaignMember, "levene/models/campaign_member.rb"
    autoload :Contact, "levene/models/contact.rb"
    autoload :Lead, "levene/models/lead.rb"
    autoload :Opportunity, "levene/models/opportunity.rb"

  end
  module Extensions
    autoload :Binding, "levene/extensions/binding.rb"
  end

  def self.enabled?
    !ENV["SALESFORCE_DEV_USER"].nil? && !ENV["SALESFORCE_DEV_PASS"].nil?
  end
end

RForce::Binding.send(:include, Levene::Extensions::Binding)
