# A Scout plugin to perform simple checks on files.
#
# Provide the path to a file you would like to check.
# Then define if that file should exist or not.
# Set up the corresponding trigger to catch your state and trigger and alert.
# Usually you want to trigger on 1 as this denotes a difference with your required check.
# Further checks to come.
#
# Created by Gerric Chaplin <gerric@particleflux.co.uk>

class SimpleFileCheck < Scout::Plugin

    OPTIONS=<<-EOS
      path:
	name: path
	notes: Full path to the file which will be checked.
        default: /var/log/syslog
      existence:
	name: existence 
	notes: Should the file exist? true or false
        default: true
    EOS

    def build_report
	path = option(:path)
	exists = File.exists?(path)
	existence = option(:existence)

	if exists
		if existence == "true"	
			report(:exists => 0)
		else
			report(:exists => 1)
		end
	else
		if existence == "false"  
                        report(:exists => 0)
                else
                        report(:exists => 1)
                end
	end			
    rescue Exception => e
      error(:subject => 'Error running Simple File Check plugin', :body => e)
      return -1
    end
  end
