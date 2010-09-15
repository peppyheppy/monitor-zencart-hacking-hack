#!/bin/env ruby

require 'net/smtp'
def send_email(from, from_alias, to, to_alias, subject, message)

	msg = <<-END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to_alias} <#{to}>
Subject: #{subject}
	
#{message}
END_OF_MESSAGE
	
  Net::SMTP.start('localhost') do |smtp|
    smtp.send_message msg, from, to
  end
end

%w(domain1 domain2).each do |account|
  output = `cd /home/#{account}/www; git status`

  if output.split("\n").map { |m| /[^includes\/configure]\.(php)/i.match(m) }.compact.size > 0 then
    send_email(
      'root@host.com',
      'System Monitory', 
      'paul@site.com', 
      'Webmaster', 
      "#{account} might have been hacked?", 
      "You might want to check it out.:\n\n#{output}"
    )
  end

end
