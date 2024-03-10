<#
.SYNOPSIS
Example of use of exception objects constructed by reflection.
#>

. .\myexception.ps1

try {
    try {
        invalid-command
    } catch {
        throw (New-Object MyErrorMessageException 'my error message', $_.Exception)
    }
} catch [MyErrorMessageException] {
    'my error exception was thrown.'
    $_ | Out-String
}

try {
    try {
        invalid-command
    } catch {
        throw (New-Object MyErrorCodeException 123, $_.Exception)
    }
} catch [MyErrorCodeException] {
    'my error exception was thrown.'
    $_ | Out-String
}
