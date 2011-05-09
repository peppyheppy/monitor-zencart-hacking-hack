#!/bin/env ruby
require 'rubygems'
require 'fileutils'
require 'net/smtp'
require 'ruby-debug'
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
  root_dir = "/home/#{account}/www/"
  output = `cd #{root_dir}; git status`
  files = output.split("\n").map { |m| file = /.*[^includes]\.(php)/i.match(m); file && root_dir + file[0].gsub("#\t","") }.compact
  if files.size > 0 then
    send_email(
      ARGV[1],
      ARGV[2], 
      "#{account} might have been hacked?", 
      "You might want to check it out.:\n\n#{output}"
    )
    FileUtils.rm files
  end

end
