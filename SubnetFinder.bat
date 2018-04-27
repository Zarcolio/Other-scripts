SET OutputFile=IPSubnetFinder.txt
IPCONFIG /all>%OutputFile%
ROUTE PRINT>>%OutputFile%
TRACERT 8.8.8.8>>%OutputFile%