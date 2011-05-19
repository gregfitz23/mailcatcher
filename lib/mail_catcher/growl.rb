require 'ruby-growl'

module MailCatcher
  module Growl
  
    def self.start
      g = ::Growl.new '127.0.0.1', "MailCatcher", ["MailCatcher Notification"]
      MailCatcher::Events::MessageAdded.subscribe do |message| 
        begin
          notification = <<NOTIFICATION
From: #{message["sender"]}
To: #{message["recipients"]}
Subject: #{message["subject"]}
NOTIFICATION
          g.notify 'MailCatcher Notification', 'MailCatcher caught', notification
        rescue Errno::ECONNREFUSED
        end
      end
    end
  end
end