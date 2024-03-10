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
