function Get-Timestamp{
<#
.SYNOPSIS
    Retrieves the current date and time formatted as specified, including a time zone.

.DESCRIPTION
    This function gets the current date and time and formats it as "Day, Month/Day/Year - Hour:Minute AM/PM".
    It appends the specified time zone to the formatted date/time string.

.PARAMETER None
    No parameters are required for this function.

.EXAMPLE
    Get-Timestamp
    Returns the current timestamp formatted with the specified time zone.
#>

    # Get the current date and time formatted as requested
    $currentDateTime = Get-Date -Format "dddd, M/d/yyyy - h:mmtt"
    $timeZone = "(PST)" # Adjust if needed based on the actual time zone

    # Combine the date/time with the time zone
    $output = "$currentDateTime $timeZone"
    
    Return $output 
}
#----------------------------------------------------------------------------------------------------------
function Send-ToTextFile {
<#
.SYNOPSIS
Saves the output of lottery draw calculations and tables to a text file.

.DESCRIPTION
The `Send-ToTextFile` function accepts an array of lottery draw numbers and a file path as inputs. 
It generates the output by invoking two external functions: `Display-DrawTable` and `Display-DrawCalc`. 
The outputs from these functions are concatenated and saved into a text file called `WALottoResults.txt` at the specified location. 
If the file already exists, it will be overwritten.

.PARAMETER drawnums
An array of lottery draw numbers. These numbers will be passed to the `Display-DrawTable` and `Display-DrawCalc` 
functions to generate the output. This parameter is mandatory.

.PARAMETER path
The file system path where the output text file will be saved. This must be a valid string representing a directory path. 
The text file `WALottoResults.txt` will be created or overwritten in this location. This parameter is mandatory.

.OUTPUTS
None. This function writes the output to a file but does not return anything to the console.

.EXAMPLES

# Example 1: Save lottery draw results to a file
$drawnumbers = @(1, 2, 3, 4, 5, 6)
$path = "C:\Results"

Send-ToTextFile -drawnums $drawnumbers -path $path

Description:
This example takes an array of draw numbers and saves the results of the calculations and table display to the `WALottoResults.txt` file located in `C:\Results`.

.NOTES
- The function expects two external functions, `Display-DrawTable` and `Display-DrawCalc`, to be defined and used to process the draw numbers.
- The output file is overwritten if it already exists.
#>

    param (
        [Parameter(Mandatory = $true)][array]$drawnums,
        [Parameter(Mandatory = $true)][string]$path
    )
    
    # Path to the output file
    $outfile = Join-Path -Path $path -ChildPath "WALottoResults.txt"

    # Capture the output of Display-DrawTable and Display-DrawCalc and convert them to strings
    $tblout = Display-DrawTable -drawsubset $drawnums 
    $calcout = Display-DrawCalc -drawen $drawnums 

    # Combine the output of both commands with a separator
    $output = $tblout + $calcout

    $output | Out-File -FilePath $outfile -force

    # Write the formatted output to the text file, overwriting it
    #$output | Out-File -FilePath $outfile -Force
}