function Run-WALotto {

<#
.SYNOPSIS
Runs the WA Lotto process by loading necessary modules, retrieving past lottery draw data, displaying results, and saving them to a text file.

.DESCRIPTION
The `Run-WALotto` function is designed to automate the workflow for managing and analyzing Western Australian Lottery (WA Lotto) results. It imports custom modules for lottery calculations, retrieves past drawing data, displays results on the console, and saves them to a text file.

This function utilizes other functions such as `Get-WALottoNums`, `Display-DrawTable`, `Display-DrawCalc`, and `Send-ToTextFile` to complete the process.

.PARAMETER None
This function does not require any parameters as all necessary configurations are hardcoded, such as module paths and file paths.

.OUTPUTS
None. The function displays data on the screen and writes the results to a file, but does not return any data to the console.

.EXAMPLES

# Example 1: Run the WA Lotto process
Run-WALotto

Description:
This example runs the WA Lotto automation process. It retrieves the past draw data, displays the results on the console, and saves the formatted output to a text file.

.NOTES
- The function assumes the modules `WALottoMath.psm1`, `WALottoNums.psm1`, `WALottoLog.psm1`, and `WALottoMgr.psm1` are available at the specified `$modpath` location.
- The result of the drawing data will be saved to the `$outFilePath` location as `WALottoResults.txt`.

#>


    #----- Path & File Setups -----
    $modpath = "D:\My_Computer\My_Computer_Automation\Powershell\WALotto\Modules\"
    $outFilePath = "D:\My_Computer\My_Computer_Automation\Powershell\WALotto\Data\"

    #----- Add Modules -----
    $modmath = Join-Path -Path $modpath -ChildPath "WALottoMath.psm1"
    $modnums = Join-Path -Path $modpath -ChildPath "WALottoNums.psm1"
    $modlog = Join-Path -Path $modpath -ChildPath "WALottoLog.psm1"
    $modmgr = Join-Path -Path $modpath -ChildPath "WALottoMgr.psm1"

    Import-Module $modmath -Force
    Import-Module $modnums -Force
    Import-Module $modlog -Force
    Import-Module $modmgr -Force

    #---- Main Sub -----
    
    # Clear the console
    Clear-Host
    
    # Retrieve Lotto past drawing data using Get-WALottoNums
    $draws = Get-WALottoNums

    # Display Lotto results on the screen
    Display-DrawTable -drawsubset $draws
    Display-DrawCalc -drawen $draws

    # Save results to text file
    Send-ToTextFile -drawnums $draws -path $outFilePath
}

Run-WALotto




