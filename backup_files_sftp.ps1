# Zip and Transfer nightly database backups from Product Dev to SFTP Backup Server
# MSW - 19/06/2019
#
 
 param
 (
 $tobackup = "c:\backups\Archive\*",
 $remotepath = "/devbackups/daily/Insurers/",
 $backupserver = "99.80.58.151",
 $backupuser = "centos",
 $keylocation = "c:\scripts\backup\Linux_File_backup_server.ppk"
 )
 
 
try
{
    # Load WinSCP .NET assembly
    Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = $backupserver
        UserName = $backupuser
        SshPrivateKeyPath = $keylocation
   #     GiveUpSecurityAndAcceptAnySshHostKey = $true
       SshHostKeyFingerprint = "ssh-rsa 2048 4Xzynuazyt/ZlX3sjHTmleHkTJ/aiFzy1LAWJvyciCU=" 
    }
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        # Upload files
        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
 
        $transferResult =
            $session.PutFiles($tobackup, $remotePath, $False, $transferOptions)
 
        # Throw on any error
        $transferResult.Check()
 
        # Print results
        foreach ($transfer in $transferResult.Transfers)
        {
            Write-Host "Upload of $($transfer.FileName) succeeded"
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}