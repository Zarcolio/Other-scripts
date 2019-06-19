@ECHO OFF
SET SPath=%USERPROFILE%\Documents\MyScans
SET SUser=Scanner
SET SPassword=P@ssw0rd

ECHO *** Creating user %SUser% ***
NET USER %SUser% %SPassword% /ADD

ECHO *** Disabling password expiration ***
NET ACCOUNTS /MaxPWAge:unlimited

ECHO *** Disable user account expiration ***
NET USER %SUser% /expires:never

ECHO *** Creating directory ***
MD "%SPath%"

ECHO:
ECHO *** Sharing directory ***
NET SHARE MyScans$="%SPath%" /UNLIMITED

ECHO *** Setting permissions on path ***
ICACLS "%SPath%" /grant:r %SUser%:(CI)(OI)M

ECHO:
PAUSE
