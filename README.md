
# WALottoAnalyzer

WALottoAnalyzer is a PowerShell-based tool designed to analyze and extract insights from Washington State lottery (WALotto) data. The project provides several PowerShell modules and scripts that facilitate the retrieval, analysis, and formatting of lottery draw data, enabling users to explore patterns and enhance their lottery strategies.

## Features

- **Data Extraction**: Retrieves lottery draw data from web sources.
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

## Prerequisites

To run the **WALottoAnalyzer**, you will need:

- **PowerShell**: The scripts are designed to work with PowerShell.
- **Internet Connection**: To retrieve the latest lottery draw data.

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
2. Navigate to the directory where the script is located.
3. Run the script by typing:

```powershell
.\Run-WALotto.ps1
```

### Functions Overview

Each module contains specific functions for lottery analysis. Below is a brief overview of key functions:

#### 1. **Get-GrpNums**
- **Description**: Analyzes a lottery draw and assigns numbers to one of three groups based on predefined ranges.
- **Usage**: 
  ```powershell
  $draw = @(5, 10, 25, 30, 35, 45)
  Get-GrpNums -draws $draw
  ```
- **Output**: Group distribution of the numbers based on their ranges.

#### 2. **Get-GrpNumPos**
- **Description**: Evaluates whether each number in a lottery draw falls within its positional range.
- **Usage**:
  ```powershell
  $draw = @(5, 10, 25, 30, 35, 45)
  Get-GrpNumPos -draws $draw
  ```
- **Output**: A string showing numbers that fall within their positional ranges.

### Logging

The **WALottoLog** module handles logging of each analysis session. Logs are written to a file for tracking results and troubleshooting errors.

To enable logging, ensure that the `WALottoLog` module is imported into your session.

### Customizing

You can modify the behavior of the scripts by adjusting parameters within the `.psd1` files or by extending the logic in the `.psm1` modules.

## Contributing

Feel free to contribute by:

- Submitting bug reports and feature requests.
- Forking the repository and submitting pull requests.

Please follow the project's coding style and ensure all changes are thoroughly tested.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Let me know if you'd like to include additional details or modify any section of this `README.md`!
