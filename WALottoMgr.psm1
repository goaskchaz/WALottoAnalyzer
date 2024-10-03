#-----------------------------------------------------------------------------------------------------------------
function Display-DrawTable {
<#
.SYNOPSIS
    Displays a formatted table with a timestamp header based on the input array.

.DESCRIPTION
    The `Display-DrawTable` function takes an array of numbers as input and generates a formatted table using another function `Display-Results`.
    It adds a timestamp as a header and removes any extra spaces from the table entries.

.PARAMETER drawsubset
    An array of values that will be passed to the `Display-Results` function to generate the table.
    This parameter is mandatory.

.EXAMPLE
    PS C:\> $numbers = 1..10
    PS C:\> Display-DrawTable -drawsubset $numbers

    This example will create a table of results for the numbers 1 through 10 and display it with a timestamp header.

.NOTES
    - The function depends on an external function `Display-Results` to generate the table content.
    - The timestamp is generated using the `Get-Timestamp` function, which is also an external dependency.

#>

    param (
        [Parameter(Mandatory = $true)][array]$drawsubset
    )

    # Get current timestamp using a custom function `Get-Timestamp`
    $timestamp = Get-Timestamp

    # Create a header with the timestamp
    $header = "$timestamp`n`n"

    # Call another function `Display-Results` with the input parameter to generate a table
    $tbl = Display-Results -Nums $drawsubset

    # Remove or trim all spaces from the table rows
    $tbltrim = $tbl -join "`n" | ForEach-Object { $_.Trim() }

    # Display the header
    $header

    # Format and display the trimmed table
    $output = $tbltrim | Format-Table

    Return $output
}

#--------------------------------------------------------------------------------
function Display-Results {
<#.SYNOPSIS
    Displays Lotto draw results in a formatted table.

.DESCRIPTION
    The Display-Results function takes an array of Lotto draw objects and formats them into a readable table format.

.PARAMETER Nums
    An array of Lotto draw objects containing properties such as Day, Date, and winning numbers P1 through P6.

.EXAMPLE
    $draws = Get-WALottoNums
    Display-Results -Nums $draws

    This example displays the past Lotto draws in a formatted table.

            Day Date       P1 P2 P3 P4 P5 P6
            --- ----       -- -- -- -- -- --
            Wed 09/25/2024 15 16 18 19 33 49
            Mon 09/23/2024 02 05 15 23 36 44
            Sat 09/21/2024 02 13 21 42 43 49
            Wed 09/18/2024 02 12 21 32 33 49
            Mon 09/16/2024 01 06 17 24 28 40
            Sat 09/14/2024 05 09 16 24 38 44
            Wed 09/11/2024 02 10 19 36 38 49
            Mon 09/09/2024 05 25 34 37 47 49
            Sat 09/07/2024 02 05 06 24 32 36
            Wed 09/04/2024 03 11 25 27 36 43
#>
    param (
        [Parameter(Mandatory = $true)][array]$Nums
    )

    $divr = "--------------------------------"
    
    # Create an array to hold the formatted data
    $results = @()

    # Loop through each item in $Nums and construct a PSObject for each row
    $Nums | foreach { 
        $result = New-Object psobject
        foreach ($key in $_.keys) {
            $result | Add-Member -MemberType NoteProperty -Name $key -Value $_[$key]
        }
        $results += $result
    }

    # Convert the results to a formatted table string
    $output = $results | Format-Table -AutoSize | Out-String

    # Trim any extra newlines at the start or end of the output
    $output = $output.Trim()

    # Combine the formatted table and the separator
    $finalOutput = "$output`r`n$divr"

    # Return the final formatted output
    return $finalOutput
}


<# Test script to check function
Cls
$draws = Get-WALottoNums
$tbl = Display-Results -Nums $draws 
$tbl | Format-Table
#>
#--------------------------------------------------------------------------------
function Display-DrawCalc {
<#
.SYNOPSIS
    Displays detailed information about draw data and invokes additional processing on subsets of draw numbers using functions from the WALottoCalc module.

.DESCRIPTION
    The `Display-DrawCalc` function displays results from various mathematical calculations listed in the WALottoCalc module.
    The function operates in two main parts:
    
    1. It first displays the draw number, draw date, and the winning numbers in the following format:
    
        -----------------------------------------------------
        Draw Num:       <draw_number>
        Draw Date:      <draw_date>, <additional_info>
        Draw Nums:      (<num1>, <num2>, <num3>, <num4>, <num5>, <num6>)
    
    2. After displaying the draw information, the draw numbers (indices 2 to 7) are passed to the `Invoke-AllFunctions` function for further processing. 
       The output of `Invoke-AllFunctions` contains several analyses, such as number adjustments, averages, group positions, number sums, and more, based on the WALottoCalc module.

.PARAMETER drawen
    Mandatory. An array where each element represents a draw. Each draw is expected to be a sub-array containing:
    - Index 0: the draw date.
    - Index 1: additional date-related information (e.g., day of the week).
    - Indices 2 to 7: the six winning numbers for that draw.
    
.EXAMPLE
    $draws = @(
        @("2024-09-25", "Wednesday", 5, 12, 23, 34, 45, 56),
        @("2024-09-26", "Thursday", 7, 14, 21, 28, 35, 42)
    )
    Display-DrawCalc -drawen $draws

    This example displays information for two draws and processes the draw numbers through the `Invoke-AllFunctions` function.

.OUTPUTS
    System.String
        Outputs formatted details of each draw to the console, including the results of mathematical functions and calculations.

    Example output:
        -----------------------------------------------------
        Draw Num:       10
        Draw Date:      Sat, 09/07/2024
        Draw Nums:      (02, 05, 06, 24, 32, 36)

        Num Adj:        (01*03,04*06,05*07,23*25,31*33,35*37)
        Num Avg:        17
        Digits Dbld:    (None)
        Grp Pos:        P1:02, P2:05, P3:( ), P4:( ), P5:32, P6:( )
        Grp Thirds:     3-2-1 = [1:(3),2:(2),3:(1)]
        Num Half:       (None)
        Digits Last:    02 = (02 & 32), 06 = (06 & 36)
        Split Low/High: 04|02 = (02,05,06,24)/(32,36)
        Num Div:        (None)
        Num Multi:      (None)
        Draw Sum:       105 (Outside of Limits)
        Split Odd/Even: 01|05 = (05)/(02,06,24,32,36)
        Digits Rev:     (None)
        Num Seq:        (5,6)

.NOTES
    - The output format and the order of function results reflect how the functions are arranged and run sequentially in the WALottoCalc module.
    - To modify the order of displayed results, adjust the function positions within the module as needed.
    - Ensure that the `Invoke-AllFunctions` function and any other dependent functions are correctly defined and available within the WALottoCalc module.
#>

    param (
        [Parameter(Mandatory = $true)] [array]$drawen
    )

    $divr = "-----------------------------------------------------"
    
    # Use StringBuilder for efficient concatenation
    $sb = New-Object -TypeName System.Text.StringBuilder

    # Iterate over each draw in the array
    foreach ($draw in $drawen) {
        # Extract required elements
        $subset = @($draw[2], $draw[3], $draw[4], $draw[5], $draw[6], $draw[7])
        $winnum = $subset -join ", "
        
        # Perform calculations for each draw
        $numsum = Get-NumSum -draws $subset
        $oddevn = Get-OddEvenSplit -draws $subset
        $lowhgh = Get-LowHighSplit -draws $subset
        $lastdt = Get-LastDigits -draws $subset
        $dbldgt = Get-DblDigits -draws $subset
        $revdgt = Get-RevDigits -draws $subset
        $avgnum = Get-AvgNum -draws $subset
        $adjnum = Get-AdjNums -draws $subset
        $seqnum = Get-SeqNums -draws $subset
        $halfnm = Get-HalfNum -draws $subset
        $mltnum = Get-NumMulti -draws $subset
        $divnum = Get-NumDiv -draws $subset
        $grpnum = Get-GrpThirds -draws $subset
        $posnum = Get-GrpNumPos -draws $subset

        # Build the output for the current draw
        [void]$sb.AppendLine("Draw Num:       $($drawen.IndexOf($draw) + 1)")
        [void]$sb.AppendLine("Draw Date:      $($draw[0]), $($draw[1])")
        [void]$sb.AppendLine("Draw Nums:      ($winnum)")
        [void]$sb.AppendLine("Draw Sum:       $numsum")
        [void]$sb.AppendLine("Split Odd/Even: $oddevn")
        [void]$sb.AppendLine("Split Low/High: $lowhgh")
        [void]$sb.AppendLine("Digits Last:    $lastdt")
        [void]$sb.AppendLine("Digits Dbld:    $dbldgt")
        [void]$sb.AppendLine("Digits Rev:     $revdgt")
        [void]$sb.AppendLine("Num Avg:        $avgnum")
        [void]$sb.AppendLine("Num Adj:        $adjnum")
        [void]$sb.AppendLine("Num Seq:        $seqnum")
        [void]$sb.AppendLine("Num Half:       $halfnm")
        [void]$sb.AppendLine("Num Multi:      $mltnum")
        [void]$sb.AppendLine("Num Div:        ($divnum)")
        [void]$sb.AppendLine("Grp Thirds:     $grpnum")
        [void]$sb.AppendLine("Grp Pos:        $posnum")
        [void]$sb.AppendLine($divr)
        [void]$sb.AppendLine()
    }

    # Convert the StringBuilder to a string and return the result
    $output = $sb.ToString().TrimEnd()  # Use TrimEnd() to remove trailing blank lines or dividers
    return $output
}



#----------------------------------------------------------------------------------------------------------
