<#
.SYNOPSIS
    Retrieves Lotto past drawing data from the Washington Lottery website.

.DESCRIPTION
    The Get-WALottoNums function lifts the Washington Lottery website for Lotto past drawing data, 
    parses the HTML to extract drawing dates and winning numbers, and returns the data as an array 
    of objects with structured properties.

.PARAMETER None
    This function does not take any parameters.

.OUTPUTS
    System.Object
    An array of custom PSObjects representing each Lotto draw with properties:
    - Day: The day of the draw (e.g., "Wednesday").
    - Date: The date of the draw formatted as "MM/dd/yyyy".
    - P1-P6: The six winning numbers for each draw.

.EXAMPLE
    $draws = Get-WALottoNums
    Display-Results -Nums $draws
    SaveAsCSVFile

    This example retrieves the past Lotto draws, displays them in a formatted table.

.NOTES
    The URL used in this function is: 
    https://www.walottery.com/WinningNumbers/PastDrawings.aspx?gamename=lotto&unittype=draw&unitcount=10

    Other data can be retrieved based on revisions to the query string of the URL:
    - To get the past 3 winning number sets drawn: `?gamename=lotto&unittype=draw&unitcount=3`
    - To get the past 10 winning number sets drawn (default): `?gamename=lotto&unittype=draw&unitcount=10`
    - To get the past 30 winning number sets drawn: `?gamename=lotto&unittype=draw&unitcount=30`
    - To get the past 180 winning number sets drawn: `?gamename=lotto&unittype=draw&unitcount=180`
    - To get past year winning number sets drawn: `?gamename=lotto&unittype=year&unitcount=2024` (or any year)


    Ensure there is an active internet connection, and the target website's structure has not changed.

.LINK
    https://www.walottery.com/WinningNumbers/PastDrawings.aspx?gamename=lotto&unittype=draw&unitcount=10
#>
function Get-WALottoNums {
    # Define the URL to load the Lotto past drawing data
    $url = "https://www.walottery.com/WinningNumbers/PastDrawings.aspx?gamename=lotto&unittype=draw&unitcount=10"

    # Invoke the web request to fetch the page content
    $tditequest = Invoke-WebRequest -Uri $url -UseBasicParsing

    # Load the HTML content into a COM object for parsing
    $html = New-Object -ComObject "HTMLFile"
    [string]$htmlBody = $tditequest.Content
    $html.IHTMLDocument2_write($htmlBody)

    # Get the specific table(s) with class name "table-viewport-large"
    $tables = $html.body.getElementsByTagName("table") | Where-Object { $_.className -match "table-viewport-large" }

    # Initialize an array to hold the draw results
    $tbldraw = @()

    # Loop through each table to extract data
    foreach ($table in $tables) {
        # Initialize an array to hold rows of data
        $arow = @()

        # Find the date headers within each table
        $ths = $table.getElementsByTagName("h2")

        # Loop through each date header to extract the date information
        foreach ($th in $ths) {
            $innerDate = $th.innerText

            # Split and format the date
            $Day, $Date = $innerDate -split ',', 2
            $DayIs = $Day.Trim()
            $DateIs = ($Date.Trim() -replace '[,]') | Get-Date -Format "MM/dd/yyyy"

            # Find the table data cells containing the draw numbers
            $tds = $table.getElementsByTagName("td") | Where-Object { $_.className -match "game-balls" }
            $tdit = ($tds | ForEach-Object { $_.innerText }) -join '' # concatenate numbers into a single string

            # Debug output to verify $tdit content
            # Write-Output "Raw Numbers: $tdit"

            # Remove any non-digit characters and ensure correct length
            $tdit = -join ($tdit -split '\D')  # Remove any non-digit characters
            $tdit = $tdit.Trim()               # Ensure no leading/trailing spaces

            # Corrected indices for each pair of digits
            if ($tdit.Length -ge 12) {
                $arow += [ordered]@{
                    Day = $DayIs
                    Date = $DateIs
                    P1 = $tdit.Substring(0, 2).Trim()    # Positions 0-1
                    P2 = $tdit.Substring(2, 2).Trim()    # Positions 2-3
                    P3 = $tdit.Substring(4, 2).Trim()    # Positions 4-5
                    P4 = $tdit.Substring(6, 2).Trim()    # Positions 6-7
                    P5 = $tdit.Substring(8, 2).Trim()    # Positions 8-9
                    P6 = $tdit.Substring(10, 2).Trim()   # Positions 10-11
                }
            }
        }

        # Append the row to the main array
        $tbldraw += $arow
    }

    # Return the array of draw results
    return $tbldraw
}

#-------------------------------------------------------------------------------------




