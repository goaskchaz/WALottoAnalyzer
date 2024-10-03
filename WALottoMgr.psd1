@{
    ModuleVersion     = '1.0.0'
    Author            = 'C.W.Hitz'
    CompanyName       = 'Sitka 2 Enterprises LLC - www.sitkatwo.com'
    Copyright         = 'Copyright (c) 2024. This module is free to use, modify, and distribute without restriction.'
    GUID              = 'fad83da7-fba2-49ce-90ee-91f93339d30f'
    Description       = 'This module provides functionality for managing WA Lotto log and operations.'
    RootModule        = 'WALottoMgr.psm1'
    NestedModules     = @('WALottoMgr.psm1')
    FunctionsToExport = @('*')
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    ScriptsToProcess = @(Run-WALotto.ps1)
    FileList = @('WALottoMgr.psm1')
    PrivateData = @{}
    ModuleManifestVersion = '2.0'
}