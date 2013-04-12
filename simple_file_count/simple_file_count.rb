# A Scout plugin to perform simple count of files in a directory using regex.
#
# path - Provide the path to a directory you would like to check.
# file_regex - Provide the regex you want to use to look for file under the path.
# http://ruby-doc.org/core-2.0/Dir.html#method-c-glob
# 
# Created by Gerric Chaplin <gerric@particleflux.co.uk>

class SimpleFileCount < Scout::Plugin

    OPTIONS=<<-EOS
      path:
	name: path
	notes: Provide the path to a directory you would like to check for files. 
        default: /tmp/
      file_regex:
	name: file_regex 
	notes: Provide the regex you want to use to look for file under the path.
        default: *.tmp
    EOS

    def build_report
	path = option(:path)
	exists = Dir.exists?(path)
	file_regex = option(:file_regex)

	if exists
		count = Dir.glob("#{path}/#{file_regex}").size
		report(:file_count => count)
	else
		alert(:subject => "Error running Simple File Count plugin. Directory does not exist.",:body => "#{path} does not exist" )	
	end			
    rescue Exception => e
      error(:subject => 'Error running Simple File Count plugin', :body => e)
      return -1
    end
  end