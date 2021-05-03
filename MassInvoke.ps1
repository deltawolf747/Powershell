
$Form1 = New-Object -TypeName System.Windows.Forms.Form
function InitializeComponent
{
$Form1.SuspendLayout()
#
#Form1
#
$Form1.Text = [System.String]'Mass Invoke'
$Form1.ResumeLayout($false)
Add-Member -InputObject $Form1 -Name base -Value $base -MemberType NoteProperty
}
. InitializeComponent
Add-Type -AssemblyName System.Windows.Forms



[System.Windows.Forms.Application]::EnableVisualStyles()

$initialDirectory = "C:\"
$global:computerslist 
Function Get-FileName($initialDirectory)
{  
    
 
 [System.Reflection.Assembly]::LoadWithPartialName(“System.windows.forms”) | Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = “All files (*.*)| *.*”
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
 
} #end function Get-FileName 

function Establish-Session (){

    $computers = Get-Content -Path $global:computerslist   
    
    foreach ($computer in $computers)
{
$session = New-PSSession -Computer $computer

	if($session.State -eq "Opened")
	{
        Write-Host ""

		#Initiate remote session, pass in credentials and commands, find all bilockered volumes (not just C:\)
		Invoke-Command -Session $session -ScriptBlock {ping AI911420}

		

        Get-PSSession -Computer $computer | Remove-PSSession

        if($session.State -eq "Opened")
        {
        Write-Host "$computer session not closed" -ForegroundColor DarkRed
        }
        else
        {
        Write-Host "$computer session closed successfully" -ForegroundColor DarkGreen
        }
    }
	else
	{
	Write-Host ""
        Write-Host "$computer is inaccessible" -ForegroundColor Red
    }
}
}


$MassInvoke                      = New-Object system.Windows.Forms.Form
$MassInvoke.ClientSize           = New-Object System.Drawing.Point(858,662)
$MassInvoke.text                 = "Form"
$MassInvoke.TopMost              = $false
$MassInvoke.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#000000")


$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Import List"
$Button1.width                   = 224
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(50,578)
$Button1.Font                    = New-Object System.Drawing.Font('Consolas',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Button1.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#00d41a")
$Button1.Add_click({
    $selFile = Get-FileName
    $Import = Get-Content -Path $selFile -Delimiter " "
    $global:computerslist = $selFile
    $TextBox1.Text = $Import
}
)



$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $true
$TextBox1.width                  = 221
$TextBox1.height                 = 518
$TextBox1.location               = New-Object System.Drawing.Point(53,45)
$TextBox1.Font                   = New-Object System.Drawing.Font('Courier New',10)
$TextBox1.BackColor              =[System.Drawing.ColorTranslator]::FromHtml("Black")
$TextBox1.ForeColor              =[System.Drawing.ColorTranslator]::FromHtml("Green")

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $true
$TextBox2.width                  = 482
$TextBox2.height                 = 140
$TextBox2.location               = New-Object System.Drawing.Point(326,423)
$TextBox2.Font                   = New-Object System.Drawing.Font('Courier New',10)
$TextBox2.BackColor              =[System.Drawing.ColorTranslator]::FromHtml("Black")
$TextBox2.ForeColor              =[System.Drawing.ColorTranslator]::FromHtml("Green")

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Import Script"
$Button2.width                   = 226
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(583,578)
$Button2.Font                    = New-Object System.Drawing.Font('Consolas',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Button2.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#03d718")
$Button2.Add_click({
    $selFile = Get-FileName
    $Import = Get-Content -Path $selFile
    
    $TextBox2.Text = $Import
}
)

$TextBox3                       = New-Object System.Windows.Forms.TextBox
$TextBox3.multiline             = $true
$TextBox3.height                = 351
$TextBox3.width                 = 481
$TextBox3.text                  = Out-Host
$TextBox3.location              = New-Object System.Drawing.Point(326,45)
$TextBox3.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("Black")
$TextBox3.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("Green")
$TextBox3.ScrollBars            = "Vertical"


$Button3                         = New-Object system.Windows.Forms.Button
$Button3.text                    = "Execute"
$Button3.width                   = 235
$Button3.height                  = 30
$Button3.location                = New-Object System.Drawing.Point(326,578)
$Button3.Font                    = New-Object System.Drawing.Font('Consolas',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Button3.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#03d718")
$Button3.Add_Click({Establish-Session})

$MassInvoke.controls.AddRange(@($Button1,$TextBox1,$TextBox2,$Button2,$TextBox3,$Button3))




$MassInvoke.ShowDialog()




$MassInvoke.Controls.Add($Button1)


    
        
        
        











