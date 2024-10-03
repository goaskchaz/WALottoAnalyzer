@{
    RootModule = 'WALottoMath.psm1'
    ModuleVersion = '1.0.0'
    GUID = 'a6b7f5f8-bf9f-4b9d-8af1-3bd7b5c3455a'
    Author = 'C.W. Hitz'
    CompanyName = 'Sitka 2 Enterprises - www.sitkatwo.com'
    Copyright = 'Copyright (c) 2024. This module is free to use, modify, and distribute without restriction.'
    Description = 'This module provides mathematical functions for working with lottery data in Washington.'
    PowerShellVersion = '5.1'
    RequiredModules = @()
    RequiredAssemblies = @()
    ScriptsToProcess = @(Run-WALotto.ps1)
    FileList = @('WALottoMath.psm1')
    PrivateData = @{}
    ModuleManifestVersion = '2.0'
}
