#!/bin/env ruby

require 'net/smtp'
def send_email(from, to, subject, message)

	msg = <<-END_OF_MESSAGE
From: #{from}
To: #{to}
Subject: #{subject}
	
#{message}
END_OF_MESSAGE
	
  Net::SMTP.start('localhost') do |smtp|
    smtp.send_message msg, from, to
  end
end

raise "Arguments must be:\ncpanel,acount,names from@email.com to@email.com" unless ARGV.size == 3

ARGV[0].split(',').each do |account|
  output = `cd /home/#{account}/www; git status`

  if output.split("\n").map { |m| /[^includes\/configure]\.(php)/i.match(m) }.compact.size > 0 then
    send_email(
      ARGV[1],
      ARGV[2], 
      "#{account} might have been hacked?", 
      "You might want to check it out.:\n\n#{output}"
    )
  end

end
