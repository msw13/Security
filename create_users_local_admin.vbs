Set objShell = CreateObject("Wscript.Shell")


strComputer = "."

strPass = "%pa55w0rd%CA5T"
Const ADS_UF_PASSWD_CANT_CHANGE = &H0040 
Const ADS_UF_DONT_EXPIRE_PASSWD = &H10000 

dim strusers(12)

strusers(0)="toryan"
strusers(1)="dephgrave"
strusers(2)="dflood"
strusers(3)="pbotterill"
strusers(4)="rlangley"
strusers(5)="srichardson"
strusers(6)="thowcroft"
strusers(7)="asarban"
strusers(8)="sdrake"
strusers(9)="mwhitaker"
strusers(10)="rharrison"
strusers(11)="fsohail"
strusers(12)="dkilmartin"

 For i = 0 to UBound (strusers)
msgbox strusers(i)

	Set colAccounts = GetObject("WinNT://" & strComputer & "")
	Set objUser = colAccounts.Create("user", strusers(i))
	objUser.SetPassword strPass
	objUser.SetInfo

	objUser.Put "PasswordExpired", 1
	objUser.SetInfo

	'Set objUser=GetObject("WinNT://" & strComputer & "/" & strusers(i))

	'If objUser.UserFlags And ADS_UF_DONT_EXPIRE_PASSWD Then
  	  'objUser.UserFlags=objUser.UserFlags XoR ADS_UF_DONT_EXPIRE_PASSWD
	'End If

	'objUser.SetInfo 
msgbox strusers(i)



'Set objGroup = GetObject("WinNT://" & strComputer & "/Administrators,group")
'objGroup.Add(objUser.ADsPath)
 
 Next
