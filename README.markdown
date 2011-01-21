# Levene

* https://github.com/robrasmussen/levene


## DESCRIPTION

A light wrapper around RForce to make working with Salesforce a little
easier.

## USAGE

Levene allows you to easily create models that map to their Salesforce
API counterpart:

    class Contact < Levene::Models::Base
    end

Levene depends on a few environment variables being defined:

SALESFORCE_DEV_USER: The Salesforce account you're using
SALESFORCE_DEV_PASS: Your Salesforce password + security token

(If you don't have a Salesforce dev account or an account with API
access, you'll have to take care of that first.)


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
Salesforce in the background. *It is not thread-safe*.


