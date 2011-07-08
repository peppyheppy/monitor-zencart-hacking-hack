### It's Sad, but ZenCart is not secure

You can easily modify the script to use any path to any site, but for my purposes (in use with a shared hosting spanel account, I use the /home/<account name>/www as a default path. 

To run the script I would recommend adding the script to the cron like so:
*/5 * * * * ruby ./zencart_hack_check.rb cpanelaccount1,two,three root@domain.com webmaster

An example that I used was:
*/15 * * * * /bin/bash -l -c "/opt/ruby-enterprise-1.8.7-2010.01/bin/ruby /home/bin/zencart_hack_check.rb site1,site2,site2 paul@domain.com paul@domain.com >/dev/null 2>&1"

Enjoy!
