DatabaseSize.ps1
	- change: 
		-> $customer = "%ExchangeMailDatabaseName%"
		-> $maxDBsize = "2048" (max database size in MB)
			 
commands.conf
	- change:
		-> command = [ PluginContribDir + "/check_nrpe_size" ]   (path to check_nrpe_size, PluginContribDir = /usr/lib/nagios/plugins)

services.conf
	- change: 
		-> host_name = "%HOSTNAME%"	(hostname or ip)