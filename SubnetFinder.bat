@ECHO OFF
SET OutputFile=IPSubnetFinder.txt
IPCONFIG /all>%OutputFile%
ROUTE PRINT>>%OutputFile%
TRACERT 8.8.8.8>>%OutputFile%

IF NOT "%1"=="" SET LookupDomain=%1
IF NOT "%1"=="" GOTO manualDomain

IF "%USERDOMAIN%"==AzureAD ECHO This computer is connected to AzureAD...
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" ECHO This computer doesn't seem to be domain-joined...
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" GOTO skipDomain
IF "%USERDNSDOMAIN%"=="" ECHO This computer doesn't seem to be domain-joined...
IF "%USERDNSDOMAIN%"=="" GOTO skipDomain
SET LookupDomain=%USERDNSDOMAIN%
:manualDomain
	nslookup %LookupDomain%>>%OutputFile%
	
	nslookup -type=srv _kerberos._tcp.%LookupDomain%>>%OutputFile%
	nslookup -type=srv _kpasswd._tcp.%LookupDomain%>>%OutputFile%
	nslookup -type=srv _ldap._tcp.%LookupDomain%>>%OutputFile%
	nslookup -type=srv _ldap._tcp.dc._msdcs.%LookupDomain%>>%OutputFile%
	
:skipDomain
