<#
.SYNOPSIS
Example of use of exception objects constructed by reflection.
#>

. .\myexception.ps1

$targetlist = dir
try {
    foreach($target in $targetlist) {
        do {
            $retry = $false
            try {
                'processing "{0}"' -f $target
                try {
                    # something logics
                    throw ('something wrong "{0}"' -f $target)
                } catch [OperationSkipException] {
                    throw
                } catch [OperationRetryException] {
                    throw
                } catch [System.OperationCanceledException] {
                    throw
                } catch {
                    $_ | Out-String
                    $choise_retry = New-Object System.Management.Automation.Host.ChoiceDescription '&Retry', ('retry "{0}"' -f $target)
                    $choise_skip  = New-Object System.Management.Automation.Host.ChoiceDescription '&Skip', ('skip "{0}"' -f $target)
                    $choise_about = New-Object System.Management.Automation.Host.ChoiceDescription '&About', 'about all.'
                    
                    $userselect = $host.ui.PromptForChoice('ERROR', ('select action for "{0}".' -f $target.Name), @($choise_retry, $choise_skip, $choise_about), 0)
                    switch($userselect) {
                        0 {'selected retry.'; throw (New-Object OperationRetryException)}
                        1 {'selected skip.';  throw (New-Object OperationSkipException)}
                        2 {'selected about.'; throw (New-Object OperationCanceledException)}
                    }
                }
            } catch [OperationSkipException] {
                'Skipped "{0}"' -f $target
            } catch [OperationRetryException] {
                $retry = $true
                'Retrying "{0}"' -f $target
            }
        } while($retry)
    }
} catch [System.OperationCanceledException] {
    'Abouted.'
}
