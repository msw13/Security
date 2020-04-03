echo off

SET /P source1="please enter time source 1:"
SET /P source2="please enter time source 2:"
SET /P source3="please enter time source 3:"
SET /P source4="please enter time source 4:"

echo[


sc config W32Time start= auto
net start W32Time


echo[

ECHO:updating sources...

w32tm /config /manualpeerlist:"%source1%,0x9 %source2%,0x9 %source3%,0x9 %source4%,0x9" /update

w32tm /config /syncfromflags:NO /update

w32tm /config /syncfromflags:MANUAL /update

net start W32Time


echo[
echo[
echo[

ECHO:Current time source is:

w32tm /query /source

pause

SET /p input="Would you like to resync time now? (y/n)"
IF "%input%" == "y" GOTO RESYNC
IF "%input%" == "n" GOTO END

:RESYNC
w32tm /resync

pause

:END
exit
