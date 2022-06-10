@ECHO OFF
IF '%1'=='' (
	ECHO Drag multiple files to this batch file to concatenate these files.
	EXIT /B
) 

SET StrConcatenate=%1
SHIFT /1

:StartShift
	SET StrConcatenate=%StrConcatenate%+%1
	SHIFT /1
IF NOT '%1'=='' GOTO StartShift

COPY %StrConcatenate% "%~dp0\%~n0.txt"
PAUSE