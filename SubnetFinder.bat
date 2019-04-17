@ECHO OFF
IF NOT "%1"=="" SET LookupDomain=%1
IF "%1"=="" SET LookupDomain=%USERDNSDOMAIN%

SET OutputFile=SubnetFinder-%LookupDomain%.txt
IPCONFIG /all>%OutputFile%
ROUTE PRINT>>%OutputFile%
ARP -a>>%OutputFile%
TRACERT -h 2 8.8.8.8>>%OutputFile%

IF NOT "%1"=="" GOTO manualDomain

IF "%USERDOMAIN%"==AzureAD ECHO This computer is connected to AzureAD...
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" ECHO This computer doesn't seem to be domain-joined...
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" GOTO skipDomain
IF "%USERDNSDOMAIN%"=="" ECHO This computer doesn't seem to be domain-joined...
IF "%USERDNSDOMAIN%"=="" GOTO skipDomain
:manualDomain
	NSLOOKUP %LookupDomain%>>%OutputFile%
	
	NSLOOKUP -type=srv _kerberos._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _kpasswd._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _ldap._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _ldap._tcp.dc._msdcs.%LookupDomain%>>%OutputFile%
	
	TRACERT -h 2 %LookupDomain%>>%OutputFile%
	
:skipDomain
