foreach($HEADER in get-content C:\scripts\headers.txt)
{
$HEADER = $HEADER -split(',')
$Websitename = $HEADER[0]
$headerName = $HEADER[1]
$headervalue = $HEADER[2]

write-host "website is: "$websitename
write-host "headername is:"$headerName
write-host "headervalue is:"$headervalue 
}
