@{
    # Module metadata
    RootModule        = 'WALottoNums.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'd7bdbf11-5367-42f7-bf6e-4e6b2d19a8c4'
    Author            = 'C.W.Hitz'
    CompanyName       = 'Sitka 2 Enterprises LLC - www.sitkatwo.com'
    Copyright         = 'Copyright (c) 2024. This module is free to use, modify, and distribute without restriction.'
    Description       = 'Module for fetching and parsing WA Lotto numbers from the web.'
    CompatiblePSEditions = @('Desktop', 'Core')
    PowerShellVersion = '5.1'
    RequiredModules = @()
    RequiredAssemblies = @()
    ScriptsToProcess = @(Run-WALotto.ps1)
    FileList = @('WALottoNums.psm1')
    PrivateData = @{}
    ModuleManifestVersion = '2.0'
}

