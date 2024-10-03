# WALottoAnalyzer

WALottoAnalyzer is a PowerShell-based tool designed to analyze and extract insights from the Washington State lottery 6/49 game. The project provides several PowerShell modules and scripts that facilitate the retrieval, analysis, and formatting of lottery draw data, enabling users to explore patterns and enhance their lottery strategies.

## Configuration Steps (Do prior to running the script!)
Before running the `Run-WALotto.ps1` script, please follow these steps:

### 1. Create Local Path
- Create a folder path to store the PowerShell modules (e.g., `C:\localpath\PS\Modules`).
- Create a folder path to store output files (e.g., `C:\localpath\PS\Data`).

### 2. Copy Files
- Copy all module files and their manifest files (e.g., `.psm1` and `.psd1` files) to the newly created path: `C:\localpath\PS\Modules`.
- Copy the `Run-WALotto.ps1` file to the newly created path: `C:\localpath\PS`.

### 3. Update Variables
Edit the `Run-WALotto.ps1` script (which will reside in `C:\localpath\PS`) and update the following variables in the `Run-WALotto` function:
- `**$modpath** = "C:\localpath\PS\Modules"`
- `**$outFilePath** = "C:\localpath\PS\Data"`

Make sure these paths reflect your local setup.

## Prerequisites
To run **WALottoAnalyzer**, you will need:
- **PowerShell**: PowerShell 5.1 or higher.
- **Internet Connection**: To retrieve the latest lottery draw data from the official Washington Lottery's [Past Drawings page](https://www.walottery.com/winningnumbers/PastDrawings.aspx?gamename=lotto&unittype=draw&unitcount=10).

## Features
- **Data Extraction**: Retrieves lottery draw data from the [Washington Lottery’s Past Drawings](https://www.walottery.com/winningnumbers/PastDrawings.aspx?gamename=lotto&unittype=draw&unitcount=10), which is the source of the lottery draws used in this tool.
- **Pattern Analysis**: Analyzes positional ranges, groups, and occurrences of numbers in different lottery drawings.
- **Detailed Logging**: Records analyzed data for future reference.
- **Custom Lottery Math Functions**: Offers specialized mathematical tools for lottery number evaluation.
- **Modular Structure**: Various PowerShell modules allow for extensibility and customization.

## Modules
The project consists of several PowerShell modules and scripts:
1. **Run-WALotto.ps1**: The main script that coordinates the entire lottery data extraction and analysis process.
2. **WALottoLog.psm1 / WALottoLog.psd1**: Handles logging of results and errors to a file.
3. **WALottoMath.psm1 / WALottoMath.psd1**: Provides mathematical functions for analyzing lottery numbers, such as positional and grouping analysis.
4. **WALottoMgr.psm1 / WALottoMgr.psd1**: Manages the workflow and control logic for executing different parts of the analysis.
5. **WALottoNums.psm1 / WALottoNums.psd1**: Contains logic for manipulating and storing the lottery numbers that are drawn, offering sorting and statistical tools.

**Note:** These modules should be located under `C:\yourpath\PS\Modules`.

## Installation
1. Clone the repository or download the PowerShell files to your local machine.
2. Place the modules and script files in a directory of your choice.

Example:
```bash
git clone https://github.com/yourusername/WALottoAnalyzer.git
cd WALottoAnalyzer
```
3. Ensure that the directory containing the `.psm1` and `.psd1` files is added to your PowerShell `$env:PSModulePath`.

## Usage

### Running the Analysis
The main script to run the lottery analysis is `Run-WALotto.ps1`. To execute it, follow these steps:
1. Open PowerShell.
2. Navigate to `C:\localpath\PS` where the script resides.
3. Run the script by typing:
```powershell
.\Run-WALotto.ps1
```
### Output Options
- The analysis results are either displayed directly in the PowerShell console **or**
- They are saved as text files in the output path specified in the `$outFilePath` variable (e.g., `C:\localpath\PS\Data`).

## Customizing

You can modify the behavior of the scripts by adjusting parameters within the `.psd1` files or by extending the logic in the `.psm1` modules.

### Contributing
Feel free to contribute by:
- Submitting bug reports and feature requests.
- Forking the repository and submitting pull requests:
     - Create a new branch (`git checkout -b feature-branch`)
     - Commit your changes (`git commit -m "Add feature"`)
     - Push to the branch (`git push origin feature-branch`)
     - Open a pull request
Please follow the project's coding style and ensure all changes are thoroughly tested.

## Troubleshooting
If you encounter issues when running the script, here are some common solutions:
- **Error: "UnauthorizedAccessException"**: Ensure you have permission to write to the output directory `C:\localpath\PS\Data`.
- **Error: "Module not found"**: Verify that the PowerShell module path is correctly set with `$env:PSModulePath` and that all `.psm1` files are in the correct folder.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Credits
This project was inspired by the book titled *"The Lotto Black Book"* by Larry Blair.

## Future Enhancements
- Save to `.csv` and `.docx` files.
- Selecting number sets for future draws based on the `Run-WALotto` results.
- Additional selection of WA Lotto past 3, 30, 180-day and yearly draws (10 years is default).
- Probability of a range of numbers based on their position.
