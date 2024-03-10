<#
.SYNOPSIS
Example of use of exception objects constructed by reflection.
.NOTES
MyException ver 1.00

MIT License

Copyright (c) 2024 Isao Sato

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
                    
                    $userselect = $host.ui.PromptForChoice('ERROR', ('select action for "{0}".' -f $target), @($choise_retry, $choise_skip, $choise_about), 0)
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
