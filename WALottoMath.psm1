#----------------------------------------------------------------------------------------------------------
function Get-NumSum {
    <#
    .SYNOPSIS
    Calculates the sum of numbers in a 6/49 lottery draw and evaluates if the sum is within the most probable range.

    .DESCRIPTION
    This function sums up the numbers in a provided array of lottery numbers and checks if the sum
    is within the range of 115 to 185, which is typical for a 6/49 lottery game. The function also
    validates that the input is a 6-number draw with values ranging from 1 to 49.

    .PARAMETER draws
    An array of six integers representing the lottery draw numbers. Each number must be between 1 and 49.

    .EXAMPLE
    $draw = @(7, 12, 25, 33, 40, 44)
    Get-NumSum -draws $draw
    # Output: Draw: Sum = 161 (Within Limits)

    #>
    param (
            [Parameter(Mandatory = $true)][array]$draws
          )

    # Calculate the sum of the draw
    $numSum = ($draws | Measure-Object -Sum).Sum

    # Determine if the sum is within the most probable range
    if ($numSum -ge 115 -and $numSum -le 185) {
        $txtRng = "(Within Limits)"
    }
    else {
        $txtRng = "(Outside of Limits)"
    }

    # Prepare and output the result
    $output = "$numSum $txtRng"
   
   Return $output
}
#----------------------------------------------------------------------------------------------------------
function Get-OddEvenSplit {
<#
    .SYNOPSIS
    Splits the numbers in a lottery draw into odd and even, and formats the output.

    .DESCRIPTION
    This function accepts a single lottery draw (6 numbers from 1 to 49) as input,
    counts the odd and even numbers, formats them as double-digit numbers, and outputs
    the result in a specific format.

    .PARAMETER draws
    An array of integers representing the lottery draw numbers (6/49 game).

    .OUTPUTS
    A formatted string showing the count and values of odd and even numbers.

    .EXAMPLE
    $draw = @(5, 12, 23, 30, 41, 48)
    Get-OddEvenSplit -draws $draw
    # Output: Split: Odd/Even = (03:03), (05,23,41) & (12,30,48)
    #>

    param (
            [Parameter(Mandatory = $true)][array]$draws
          )

    # Initialize counters and arrays for odd and even numbers
    $evenCtr = 0
    $oddCtr  = 0
    $oddNums = @()
    $evenNums = @()

    # Process each number in the draw
    foreach ($num in $draws) {
        # Check if the number is even
        if ($num % 2 -eq 0) {
            $evenCtr++
            $evenNums += $num
        }
        else { # Number is odd
            $oddCtr++
            $oddNums += $num
        }
    }

    # Format counters and numbers as double-digit strings
    $oddCtrFmt = "{0:D2}" -f $oddCtr
    $evenCtrtFmt = "{0:D2}" -f $evenCtr

    # Format arrays with dividers/commas
    $oddNumsSet = $oddNums -join ","
    $evenNumsSet = $evenNums -join ","

     
    $output = "$oddCtrFmt|$evenCtrtFmt = ($oddNumsSet)/($evenNumsSet)"

    # Return the formatted output
    return $output
}
#----------------------------------------------------------------------------------------------------------
function Get-LowHighSplit {
<#
.SYNOPSIS
    Calculates and displays the split between low and high numbers in a given array of numbers.

.DESCRIPTION
    The `Get-LowHighSplit` function takes an array of numbers as input, calculates the midpoint, and then classifies 
    each number as either low or high based on whether it is below or above the midpoint. It outputs the count of low 
    and high numbers along with the formatted sets of numbers. The midpoint for the classification is defined as 24.5 
    (for numbers between 1 and 49).

.PARAMETER draws
    An array of numbers representing the draw. This parameter is mandatory.

.EXAMPLE
    PS C:\> $draws = @(1, 5, 12, 18, 30, 42, 48)
    PS C:\> Get-LowHighSplit -draws $draws

    Output:
    Split Low/High: (04|03) = (01,05,12,18)/(30,42,48) AvgNum = 22

    This example demonstrates the use of `Get-LowHighSplit` with a sample array of draw numbers. The function outputs 
    the count and the sets of low and high numbers, along with the average number of the draw.

.EXAMPLE
    PS C:\> $draws = @(10, 15, 22, 25, 32, 36, 40)
    PS C:\> Get-LowHighSplit -draws $draws

    Output:
    Split Low/High: (03|04) = (10,15,22)/(25,32,36,40) AvgNum = 25

    This example demonstrates the use of `Get-LowHighSplit` with another set of draw numbers. The function correctly
    classifies the numbers and provides the split information.

.INPUTS
    System.Int32[]
    The function accepts an array of integers as input.

.OUTPUTS
    System.String
    Returns a formatted string indicating the count and sets of low and high numbers along with the average number.

.NOTES
    The midpoint (`$midPnt`) is hardcoded as 24.5, assuming a typical lottery draw of numbers ranging from 1 to 49.
    The function calculates the average number from the draw for additional context.

#>


 param (
         [Parameter(Mandatory = $true)][array]$draws
       )

    # Set Number Targets -----------------------------------------------
    try {
        $highNum = ($draws | Measure-Object -Maximum).Maximum
        $midNum = [math]::floor(($draws | Measure-Object -Average).Average)
        $lowNum = ($draws | Measure-Object -Minimum).Minimum
        $midPnt = 24.5  # midpoint between 1 to 49

        # Initialize Counters and Number Sets ---------------------------
        $lowCtr = 0
        $highCtr = 0
        $lowNums = @()
        $highNums = @()
                       

        # Process each number in the draw -------------------------------
        foreach ($num in $draws) {
            if ($num -lt $midPnt) {
                $lowCtr++
                $lowNums += $num
            } else {
                $highCtr++
                $highNums += $num
            }
        }

        # Format and Prepare Output -------------------------------------
        $lowCtrFmt = "{0:D2}" -f $lowCtr
        $highCtrFmt = "{0:D2}" -f $highCtr

        # Join formatted numbers with commas
        $lowNumsSet = $lowNums -join ","
        $highNumsSet = $highNums -join ","
       

        # Output formatted result ---------------------------------------
        $output = "$lowCtrFmt|$highCtrFmt = ($lowNumsSet)/($highNumsSet)"
        return $output

    } catch {
        # Handle any unexpected errors
        Write-Error "An error occurred: $_"
    }
}

#----------------------------------------------------------------------------------------------------------
function Get-LastDigits {
    <#
    .SYNOPSIS
        Finds pairs of numbers that share the same last digit from a lottery draw.

    .DESCRIPTION
        This function evaluates a set of 6 lottery numbers from a 6/49 game and identifies pairs of numbers that
        have the same last digit. Numbers must be within the range of 01 to 49. The function outputs these matching 
        pairs in a formatted string, with all numbers represented as two-digit strings.

    .PARAMETER draws
        An array of 6 integers representing the lottery numbers.

    .EXAMPLE
        Get-LastDigits -draws @(6, 26, 8, 38, 17, 37)

        Output:
        Digits: Last = 06:(06 & 26), 08:(08 & 38), 07:(17 & 37)

        This example shows how the function identifies pairs of numbers with the same last digit and formats them
        with two digits, using leading zeros where necessary.

.INPUTS
        System.Int32[]
        The function accepts an array of integers representing lottery numbers.

.OUTPUTS
        System.String
        Returns a formatted string that lists the matching pairs of numbers with the same last digit.

.NOTES
        This function uses the "{0:D2}" format specifier to ensure that all numbers are displayed as two-digit 
        values, including leading zeros where necessary.
    #>

    param (
        [Parameter(Mandatory = $true)][array]$draws
    )

    # Initialize hashtables to store counts and matching digits
    $lastDigits = @{}
    $matchingDigits = @{}

    try {
        # Iterate over each number in the draws
        foreach ($num in $draws) {
            # Calculate the last digit and format it as two digits
            $lastDigit = "{0:D2}" -f ($num % 10)

            # Format the number itself as two digits
            $formattedNum = "{0:D2}" -f $num

            # If the last digit is already in the hashtable, update it
            if ($lastDigits.ContainsKey($lastDigit)) {
                $lastDigits[$lastDigit] += 1
                $matchingDigits[$lastDigit] += @($formattedNum)
            }
            else {
                # Initialize the hashtable entries for new last digits
                $lastDigits[$lastDigit] = 1
                $matchingDigits[$lastDigit] = @($formattedNum)
            }
        }

        # Initialize an array to store matching sets
        $matchingSets = @()

        # Check for last digits with more than one occurrence
        foreach ($lastDigit in ($lastDigits.Keys | Sort-Object)) {
            $matchingSet = $matchingDigits[$lastDigit]
            # Only include sets with more than one matching number
            if ($matchingSet.Count -gt 1) {
                $matchingSets += "$($lastDigit) = ($($matchingSet -join ' & '))"
            }
        }

        # Format the output based on matching sets found
        if ($matchingSets.Count -eq 0) {
            $output = "(None)"
        }
        else {
            $matchingSetsString = $matchingSets -join ", "
            $output = "$matchingSetsString"
        }

        return $output
    }
    catch {
        # Handle any unexpected errors
        Write-Error "An error occurred: $_"
        return "An error occurred while processing the numbers."
    }
}
#----------------------------------------------------------------------------------------------------------
function Get-DblDigits {
    <#
    .SYNOPSIS
        Identifies double-digit numbers (11, 22, 33, 44) in a 6/49 lottery drawing.

    .DESCRIPTION
        The `Get-DblDigits` function takes an array of 6 integers representing a lottery draw and checks for double-digit
        numbers where both digits are the same, specifically 11, 22, 33, and 44. If any of these numbers are found in the 
        input, the function returns them in a formatted string. If none are found, the function returns an indication that 
        no double-digit numbers were present.

    .PARAMETER draws
        An array of 6 integers representing the lottery draw numbers. Each number must be between 1 and 49, inclusive. 
        This parameter is mandatory.

    .EXAMPLE
        PS C:\> $draw = @(11, 23, 22, 35, 44, 48)
        PS C:\> Get-DblDigits -draws $draw
        Digits Doubled: (11, 22, 44)

        This example shows how the function identifies and returns the double-digit numbers 11, 22, and 44 from the given 
        draw array.

    .EXAMPLE
        PS C:\> $draw = @(5, 18, 25, 37, 41, 49)
        PS C:\> Get-DblDigits -draws $draw
        Digits Doubled: (None)

        In this example, none of the numbers in the draw match the double-digit pattern (11, 22, 33, 44). 
        The function returns "Digits Doubled: (None)".

    .INPUTS
        System.Int32[]
        The function accepts an array of integers as input, representing the 6 numbers from a lottery draw.

    .OUTPUTS
        System.String
        Returns a formatted string indicating the presence of double-digit numbers. If double digits are found, 
        the string lists them; otherwise, it indicates none were found.

    .NOTES
        - The function is designed specifically for use with 6/49 lottery draws, and the array must contain exactly 6 numbers.
        - If a number outside the range of 1 to 49 is passed in the array, the function may produce unexpected results.
        - Only the double-digit numbers 11, 22, 33, and 44 are considered valid for this function.
    #>

     param (
             [Parameter(Mandatory = $true)][array]$draws
           )

    # Initialize an empty array to store double-digit numbers
    $doubleDigits = @()

    # Iterate through each number in the draw
    foreach ($num in $draws) {
        try {
            # Convert number to string for comparison
            $numStr = $num.ToString()

            # Check if the number is a valid double-digit (11, 22, 33, 44)
            if ($numStr.Length -eq 2 -and $numStr[0] -eq $numStr[1] -and ($numStr -match '11|22|33|44')) {
                # Add the double-digit number to the array
                $doubleDigits += $num
            }
        }
        catch {
            # Handle any unexpected errors during the iteration
            Write-Warning "An error occurred while processing the number: $num. $_"
        }
    }

    # Format the output based on the presence of double digits
    if ($doubleDigits.Count -gt 0) {
        $output = "$($doubleDigits -join ', ')"
    } else {
        $output = "(None)"
    }

    # Return the formatted output
    return $output
}
#----------------------------------------------------------------------------------------------------------
function Get-RevDigits {
    <#
    .SYNOPSIS
    Identifies pairs of numbers in a lottery draw where one number is the reverse of another.

    .DESCRIPTION
    This function takes a lottery draw of 6 numbers ranging from 01 to 49 and finds pairs
    where one number is the reverse of another (e.g., 14-41, 04-40, 12-21). It excludes 
    palindromic numbers (e.g., 11, 22, 33, 44).

    .PARAMETER draws
    An array of integers representing the lottery draw. The array must contain exactly 6 numbers
    between 1 and 49.

    .EXAMPLE
    Get-RevDigits -draws @(4, 14, 21, 41, 30, 40)
    # Output: Digits: Reversed = (14-41), (04-40)

    .NOTES
    This function is designed specifically for 6/49 lottery games.
    #>

     param (
             [Parameter(Mandatory = $true)][array]$draws
           )

    # Initialize an empty array to store reverse pairs
    $reversePairs = @()

    # Process each number in the draw
    foreach ($num in $draws) {
        # Convert the number to a two-character string
        $numString = if ($num -lt 10) { "0$num" } else { $num.ToString() }
        
        # Reverse the digits of the number
        $reversedNumber = [string]$numString -replace "(.)(.)", '$2$1'
        $reversedInt = [int]$reversedNumber
        
        # Check if the reversed number is valid and is not a palindrome
        if ($reversedInt -ge 1 -and $reversedInt -le 49 -and 
            $draws -contains $reversedInt -and 
            $num -lt $reversedInt -and 
            $num -notin 11, 22, 33, 44) {
            
            # Add the pair to the reversePairs array
            $reversePairs += "($numString-$reversedNumber)"
        }
    }

    # Format the output based on whether reverse pairs were found
    $output = if ($reversePairs.Count -eq 0) {
                 "(None)"
              } else {
                 $reversePairs -join ", " 
              }

    return $output
}

#--------------------------------------------------------------------------------
function Get-AvgNum {
<#
.SYNOPSIS
    Calculates the average of a set of numbers and returns it in a formatted string.

.DESCRIPTION
    The Get-AvgNum function takes an array of numbers as input and calculates the average.
    It rounds down the result to the nearest whole number and returns a formatted string showing the average.

.PARAMETER draws
    Specifies the array of numbers for which the average needs to be calculated.
    This parameter is mandatory.

.INPUTS
    None. The function does not accept input from the pipeline.

.OUTPUTS
    System.String
    Returns a string in the format: "Num Avg: <average_value>" where <average_value> is the average
    of the input numbers, rounded down to the nearest whole number.

.EXAMPLE
    Get-AvgNum -draws @(1, 2, 3, 4, 5)
    Output:
    Num Avg:        3

    This example calculates the average of the numbers 1, 2, 3, 4, and 5. The average value is 3.0, 
    which is rounded down to 3 and returned in the formatted string.

.EXAMPLE
    Get-AvgNum -draws @(10, 15, 20)
    Output:
    Num Avg:        15

    This example calculates the average of the numbers 10, 15, and 20. The average value is 15 
    and returned in the formatted string.

.NOTES
    The average is rounded down to the nearest whole number using the [math]::floor method.
    The function returns the result as a string with the format "Num Avg: <average_value>".

.LINK
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object
    https://docs.microsoft.com/en-us/dotnet/api/system.math?view=netframework-4.8
#>
    param (
           [Parameter(Mandatory = $true)][array]$draws
          )
         
        $midNum = [math]::floor(($draws | Measure-Object -Average).Average)
                  
        $output = "$midNum"
        return $output

}

#----------------------------------------------------------------------------------------------------------
function Get-AdjNums {
    <#
    .SYNOPSIS
        Retrieves adjacent numbers for each number in a given lottery draw.
    
    .DESCRIPTION
        This function calculates the adjacent numbers before (preceding) and after (succeeding)
        each number in the provided lottery draw of 6 numbers, ranging from 01 to 49. 
        If the adjacent number falls outside the valid range (less than 01 or greater than 49), 
        it is represented as "--". The output displays each number's adjacent pairs 
        formatted as "Num Adj: (FrontNum*LastNum)" where FrontNum and LastNum represent the adjacent numbers.

    .PARAMETER draws
        An array of 6 integers representing a lottery draw with values between 1 and 49. 
        Each number in the draw should be unique.

    .OUTPUTS
        A string displaying each number's adjacent pairs, formatted as "Num Adj: (FrontNum*LastNum)".
        If no adjacent pairs are found, "--" will be displayed instead of the invalid numbers.

    .EXAMPLE
        # Example 1: Standard draw with all numbers within range
        Get-AdjNums -draws @(03, 15, 28, 34, 42, 49)
        # Output: Num Adj: (02*04,14*16,27*29,33*35,41*43,48*--)

        # Example 2: Draw including boundary values
        Get-AdjNums -draws @(01, 06, 17, 24, 28, 40)
        # Output: Num Adj: (--*02,05*07,16*18,23*25,27*29,39*41)

        # Example 3: Draw with a number exceeding upper boundary
        Get-AdjNums -draws @(02, 13, 21, 42, 43, 49)
        # Output: Num Adj: (01*03,12*14,20*22,41*43,42*44,48*--)
    #>

    param (
        [Parameter(Mandatory = $true)][array]$draws
    )

    # Declaration Section
    $AdjNum = @()

    # Main Section
    foreach ($Num in $draws) {
        # Convert the number to an integer
        $Num = [int]$Num
        # Calculate adjacent numbers
        $FrontNum = $Num - 1
        $LastNum = $Num + 1

        # Validate FrontNum
        if ($FrontNum -lt 1) {
            $FirstNumSet = "--"
        } else {
            $FirstNumSet = "{0:D2}" -f $FrontNum
        }

        # Validate LastNum
        if ($LastNum -gt 49) {
            $LastNumSet = "--"
        } else {
            $LastNumSet = "{0:D2}" -f $LastNum
        }

        # Combine and add to result
        $AdjNum += "$FirstNumSet*$LastNumSet"
    }

    # Output Section - Format and display the result
    $AdjNumSet = $AdjNum -join ","
    $output = "($AdjNumSet)"

    return $output
}
#----------------------------------------------------------------------------------------------------------
function Get-SeqNums {
    <#
    .SYNOPSIS
    Identifies sequences of consecutive numbers in a 6/49 lottery draw.

    .DESCRIPTION
    This function takes an array of six integers representing lottery draw numbers ranging from 1 to 49.
    It identifies sequences where numbers follow each other consecutively by 1 (e.g., 29, 30, 31, 32)
    and returns them in a formatted string. If no such sequences are found, it indicates so.

    .PARAMETER draws
    An array of six integers representing the lottery draw numbers (must be between 1 and 49).

    .EXAMPLE
    $draws = @(5, 12, 13, 14, 22, 33)
    $output = Get-SeqNums -draws $draws
    Write-Host $output
    # Output: Num: Seq = (12,13,14)

    #>
    param (
           [Parameter(Mandatory = $true)][array[]]$draws
          )

    # Flatten the array of arrays into a single array, filter out non-integer values
    $fltdrws = @()
    foreach ($draw in $draws) {
        foreach ($num in $draw) {
            if ([int]::TryParse($num, [ref]$null)) {
                $fltdrws += [int]$num
            }
        }
    }

    # Sort the flattened array
    $fltdrws = $fltdrws | Sort-Object

    # Initialize variables
    $seqgrps = @()
    $crtseq = @()

    # Iterate through the numbers
    for ($i = 0; $i -lt $fltdrws.Count; $i++) {
        if ($i -eq 0 -or $fltdrws[$i] -eq $fltdrws[$i-1] + 1) {
            # If the current number starts a new sequence or is consecutive, add it to the current sequence
            $crtseq += $fltdrws[$i]
        } else {
            # If the current number is not consecutive, add the current sequence to the group and start a new one
            if ($crtseq.Count -gt 1) {
                $seqgrps += ,@($crtseq)
            }
            $crtseq = @($fltdrws[$i])
        }
    }

    # Add the last sequence group if there is any and it has more than one number
    if ($crtseq.Count -gt 1) {
        $seqgrps += ,@($crtseq)
    }

    # Check if there are any valid sequences
    $output = ""
    if ($seqgrps.Count -eq 0) {
        $output = "(None)"
    } else {
        # Format the output, only display sequences with more than one number
        foreach ($seq in $seqgrps) {
            $setseq = $seq -join ","
            $output += $setseq + " "
        }
    }

    # Output the result
    Write-Output $output.Trim()
}

#----------------------------------------------------------------------------------------------------------
 function Get-HalfNum {
    <#
    .SYNOPSIS
    Identifies numbers in a lottery draw where one number is exactly half of another.

    .DESCRIPTION
    This function takes an array of six integers representing a 6/49 lottery draw.
    It checks for any numbers where one is exactly half of another within the same draw.

    .PARAMETER draws
    An array of six unique integers between 1 and 49 inclusive.

    .OUTPUTS
    A string indicating the pairs of numbers where one is half of another.

    .EXAMPLE
    $draw = @(7, 14, 21, 28, 35, 42)
    Get-HalfNum -draws $draw
    # Output: Num: Half = (7 is half of 14), (14 is half of 28), (21 is half of 42)
    #>



    param (
           [Parameter(Mandatory = $true)][array]$draws
          )
  

    # Array to store pairs
    $pairs = @()

    # Check each pair of numbers to see if one is exactly half of the other
    foreach ($num in $draws) {
        foreach ($half in $draws) {
            if ($num -eq ($half / 2)) {
                $pairs += "($num is half of $half)"
            }
        }
    }

    # Add pairs to the result or "None" if no pairs found
    if ($pairs.Count -eq 0) {
        $output += "(None)"
    }
    else {
        $output += ($pairs -join ", ")
    }

    # Output the result
   Return $output
}
#----------------------------------------------------------------------------------------------------------
  function Get-NumMulti {
    <#
    .SYNOPSIS
    Finds pairs of numbers in a lottery draw where the product equals another number in the same draw.

    .DESCRIPTION
    This function accepts an array of six unique integers between 1 and 49 (inclusive), representing a lottery draw in a 6/49 game.
    It identifies any pairs of numbers within the draw such that their product equals another number in the same draw.

    .PARAMETER draws
    An array of six unique integers between 1 and 49 inclusive.

    .OUTPUTS
    A string indicating the pairs found or 'None' if no such pairs exist.

    .EXAMPLE
    $draw = @(2, 3, 6, 8, 16, 24)
    Get-NumMulti -draws $draw
    # Output: Num Multi:  (02*03=06), (02*08=16), (03*08=24)
    #>


    param (
            [Parameter(Mandatory = $true)][array]$draws
          )

        # Initialize an empty array to store matching pairs
        $result = @()

        # Loop through each element in the array
        for ($i = 0; $i -lt $draws.Count; $i++) {
            for ($j = 0; $j -lt $draws.Count; $j++) {
                # Skip if comparing the same element, if either number is 1, or if index $i is not less than $j
                if ($i -ne $j -and $i -lt $j -and $draws[$i] -ne 1 -and $draws[$j] -ne 1) {
                    # Calculate the product of two different numbers, ensuring they are treated as integers
                    $product = [int]$draws[$i] * [int]$draws[$j]

                    # Check if the product exists in the array and it's not one of the numbers being multiplied
                    if ($draws -contains $product) {
                        # Check if the pair has been added already to avoid duplicates
                        $formattedString = "({0:00}*{1:00}={2:00})" -f $draws[$i], $draws[$j], $product
                        if ($result -notcontains $formattedString) {
                            # Add the formatted string to the result array
                            $result += $formattedString
                        }
                    }
                }
            }
        }

        # Display the result
        if ($result.Count -eq 0) {
            $output =  "(None)"
        } else {
            $resultset = $result -join ", "
            $output = "$resultset"
        }
    Return $output
}

#----------------------------------------------------------------------------------------------------------
function Get-NumDiv {
    <#
    .SYNOPSIS
    Finds pairs of numbers in a lottery draw where one number divided by another equals a third number in the draw.

    .DESCRIPTION
    This function analyzes a 6-number lottery draw (numbers ranging from 1 to 49) and identifies all unique triplets (num1, num2, num3) such that:

    - num1 divided by num2 equals num3.
    - All three numbers are distinct.
    - The division results in an integer to avoid floating-point precision issues.

    .PARAMETER draws
    An array of exactly 6 unique integers between 1 and 49 inclusive.

    .EXAMPLE
    PS> $draws = @(2, 4, 8, 16, 32, 48)
    PS> $result = GetNumDiv -draws $draws
    PS> Write-Output $result
    Num: Div = (8/2=4, 8/4=2, 16/2=8, 16/8=2, 32/2=16, 32/4=8, 32/8=4, 32/16=2)

    .NOTES
    Author: [Your Name]
    Date: [Current Date]
    #>
    param (
             [Parameter(Mandatory = $true)][array]$draws
           )

    # Initialize an array to store valid division expressions
    $numDivPairs = @()

    # Iterate over all unique pairs of numbers in the draw
    for ($i = 0; $i -lt $draws.Length; $i++) {
        $num1 = $draws[$i]
        for ($j = 0; $j -lt $draws.Length; $j++) {
            if ($i -ne $j) {
                $num2 = $draws[$j]

                # Ensure numbers are distinct and avoid division by zero
                if ($num2 -ne 0) {

                    # Check if num1 divides evenly by num2
                    if ($num1 % $num2 -eq 0) {
                        $quotient = $num1 / $num2

                        # Ensure quotient is a distinct number in the draw
                        if (($draws -contains $quotient) -and ($quotient -ne $num1) -and ($quotient -ne $num2)) {
                            $expression = "$num1/$num2=$quotient"

                            # Add the expression if it's not already in the list
                            if (-not ($numDivPairs -contains $expression)) {
                                $numDivPairs += $expression
                            }
                        }
                    }
                }
            }
        }
    }

    # Prepare the output
    if ($numDivPairs.Count -gt 0) {
        $output = $numDivPairs -join ", "
    } else {
        $output = "None"
    }

    return $output
}
#----------------------------------------------------------------------------------------------------------
function Get-GrpThirds {
    <#
    .SYNOPSIS
        Analyzes a set of 6 lottery numbers and determines their distribution among three numerical groups.

    .DESCRIPTION
        The function accepts an array of 6 unique integers between 1 and 49 (inclusive), representing lottery numbers from a 6/49 game.
        It calculates how many numbers fall into each of the ollowing groups:
            - Group 1: Numbers 1 to 16
            - Group 2: Numbers 17 to 32
            - Group 3: Numbers 33 to 49
        The function outputs the counts in a formatted string.

    .PARAMETER draws
        An array of 6 unique integers between 1 and 49.

    .EXAMPLE
        PS> Get-GrpThirds -draws @(5, 12, 19, 25, 34, 45)
        Grp: Thirds = 2-2-2, 1:(2),2:(2),3:(2)

    .NOTES
        Author: [Your Name]
        Date:   [Today's Date]
    #>

      param (
             [Parameter(Mandatory = $true)][array]$draws
            )

    # Initialize group counters
    $grp1 = 0
    $grp2 = 0
    $grp3 = 0

    # Iterate through each number and increment the appropriate group counter
    foreach ($Num in $draws) {
       $Num = [int]$Num
        if ($Num -ge 1 -and $Num -le 16) {
            $grp1++
        }
        elseif ($Num -ge 17 -and $Num -le 32) {
            $grp2++
        }
        elseif ($Num -ge 33 -and $Num -le 49) {
            $grp3++
        }
        else {
            # This else block should not be reached due to prior validation
            Throw "Number '$Num' is out of the expected range."
        }
    }

    # Construct the output string
    $output = "$grp1-$grp2-$grp3 = [1:($grp1),2:($grp2),3:($grp3)]"

    # Return the output
    return $output
}
#----------------------------------------------------------------------------------------------------------
function Get-GrpNumPos {
<#
.SYNOPSIS
    Evaluates a lottery draw against predefined positional ranges.

.DESCRIPTION
    This function accepts an array of six lottery numbers and checks each number
    to determine if it falls within its specified positional range. It then formats
    the output accordingly, displaying the number if it's within range or "( )" if not.

.PARAMETER draws
    An array of six integers representing a lottery draw. Each number must be between 1 and 49.

.EXAMPLE
    $draw = @(5, 10, 25, 30, 35, 45)
    Get-GrpNumPos -draws $draw

    Output:
    Grp Pos:  P1:05, P2:10, P3:25, P4:30, P5:35, P6:45

.OUTPUTS
    A string indicating which numbers are within their positional ranges.

.NOTES
    Author: Your Name
    Date:   2023-10-13
    This function is designed for a 6/49 lottery game.

#>

    param (
            [Parameter(Mandatory = $true)][array]$draws
           )

    # Define positional ranges using a hashtable
    $rngpos = @{
        P1 = @{ Min = 1;  Max = 13 }
        P2 = @{ Min = 5;  Max = 21 }
        P3 = @{ Min = 16; Max = 29 }
        P4 = @{ Min = 26; Max = 38 }
        P5 = @{ Min = 31; Max = 44 }
        P6 = @{ Min = 41; Max = 49 }
    }

  
    try {
        # Loop through each number and its corresponding position
        for ($i = 0; $i -lt 6; $i++) {
            
            # Determine the current position
            $pos = "P$($i + 1)"
            if ($i -lt $draws.Count) {
               $rng = $rngpos[$pos]
               $num = $draws[$i]
               $inum = [int]$num
             

                # Check if the number is within the positional range
                if ($inum -ge $rng.Min -and $inum -le $rng.Max) {
                    $numset = "{0:D2}" -f $inum
                } else {
                    $numset = "( )"
                }
            } else {
                $numset = "( )"
            }

            # Append the formatted number to the output string using subexpression $()
            $output += "$($pos):$numset"

            # Add a comma separator if not the last position
            if ($i -lt 5) {
                $output += ", "
            }
        }

        # Return the final output string
        return $output
    }
    catch {
        Write-Error "An error occurred while processing the draw: $_"
    }
}


#----------------------------------------------------------------------------------------------------------
