if ( (Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction:SilentlyContinue) -eq $null)
{
    Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010
}
$customer = "DBNAME"
$maxDBsize = "280000"

$NagiosStatus = "0"
$NagiosDescription = ""
$perfdata = ""

$db = Get-MailboxDatabase -Status $customer | select name
$dbs = Get-MailboxDatabase -Status $customer | select DatabaseSize

$DBsizeMB = $dbs.DatabaseSize.ToMB()




    if ($dbsizeMB -gt $maxDBsize)
    {
        if ($NagiosDescription -ne "") 
		{
			# Format the output for Nagios
			$NagiosDescription = $NagiosDescription + ", "
		}
        
	       $NagiosDescription = $NagiosDescription + $db.Name + " = " + $dbsizMB		
            # Set the status to failed.
		      $NagiosStatus = "2 "

  
    
    } #end if
   if ($NagiosStatus -eq "2") 
{
	Write-Host ""$NagiosDescription" MB ($DBsizeMB MiB) in use. Max. allowed is: "$maxdbsize" MB | 'DBsizeMiB'=${dbsizeMB}"
	

} 
else 
{	
Write-Host "Database: "$dbsizeMB" MiB | 'DBsizeMiB'=${dbsizeMB}"

}



exit $NagiosStatus