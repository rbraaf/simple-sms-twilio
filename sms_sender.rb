require 'twilio-ruby'
require 'yaml'
require './sms'

Sms.add_contact
puts "##########################################################"
Sms.message_contact
