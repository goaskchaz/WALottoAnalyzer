@{
    ModuleVersion     = '1.0.0'
    Author            = 'C.W.Hitz'
    CompanyName       = 'Sitka 2 Enterprises LLC - www.sitkatwo.com'
    Copyright         = 'Copyright (c) 2024. This module is free to use, modify, and distribute without restriction.'
    GUID              = '7263283c-ceee-4edb-b276-076e0d38f25d'
    Description       = 'This module provides functionality for managing WA Lotto log and operations.'
    RootModule        = 'WALottoLog.psm1'
    NestedModules     = @('WALottoLog.psm1')
    FunctionsToExport = @('*')
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    ScriptsToProcess = @(Run-WALotto.ps1)
    FileList = @('WALottoLog.psm1')
    PrivateData = @{}
    ModuleManifestVersion = '2.0'
}
