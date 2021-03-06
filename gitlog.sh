#!/usr/bin/env ruby

# Write git commit messages to a log file
# 
# Lincoln A. Mullen | lincoln@lincolnmullen.com | http://lincolnmullen.com
# MIT License <http://lmullen.mit-license.org/>
#
# You will have to install the git gem for this to work:
gem install git
#
# Name this file 'post-commit' and drop it in the directory '.git/hooks'  in
# any repository that you want to log. Make sure the file is executable. You
# can also add this to your git templates, which will put it in every new
# repository or to existing repositories by re-running git init.  
# 
# A commit message in the log should look this this:
#   2013-07-26-11-25-55 [repository:branch] First line of commit message

require "git"

log_file = "/home/lmullen/todo/time-use.txt"
repo = Git.open(Dir.pwd)
repo_name = Dir.pwd[%r{[\.\-\w]+$}]                       # top directory
date = repo.log.first.date.strftime("%Y-%m-%d-%H-%M-%S")  # format date
message = repo.log.first.message.lines.first.strip        # just first line
branch = repo.log.first.name
File.open(log_file, "a") do |log|                        
  log.puts "#{date} [#{repo_name}:#{branch}] #{message}"  
end
