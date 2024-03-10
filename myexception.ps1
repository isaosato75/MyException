<#
.SYNOPSIS
Construction of exception objects by reflection.
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

$MyExceptionNamespace = 'NASsystems.MyException'

$appdomain = [AppDomain]::CurrentDomain
$asmbuilder = $appdomain.DefineDynamicAssembly((New-Object Reflection.AssemblyName $MyExceptionNamespace), [Reflection.Emit.AssemblyBuilderAccess]::Run)
$modbuilder = $asmbuilder.DefineDynamicModule("$MyExceptionNamespace.dll")

$type_pstypeaccelerators = [psobject].Assembly.GetType('System.Management.Automation.TypeAccelerators')

& {
    $type_pstypeaccelerators::Add(
        "OperationSkipException",
        $modbuilder.DefineType(
		    "$MyExceptionNamespace.OperationSkipException",
		    [System.Reflection.TypeAttributes] 'AutoLayout, AnsiClass, Class, Public, BeforeFieldInit',
		    [System.Exception]
		    ).CreateType())
    $type_pstypeaccelerators::Add(
        "OperationRetryException",
        $modbuilder.DefineType(
		    "$MyExceptionNamespace.OperationRetryException",
		    [System.Reflection.TypeAttributes] 'AutoLayout, AnsiClass, Class, Public, BeforeFieldInit',
		    [System.Exception]
		    ).CreateType())
}

& {
    $typename = "$MyExceptionNamespace.MyErrorMessageException"
    
    $typebuilder = $modbuilder.DefineType(
	    $typename,
	    [System.Reflection.TypeAttributes] 'AutoLayout, AnsiClass, Class, Public, BeforeFieldInit',
	    [System.ApplicationException])
    
    $constructor0builder = $typebuilder.DefineConstructor(
        [System.Reflection.MethodAttributes] 'PrivateScope, Public, HideBySig, SpecialName, RTSpecialName',
        [System.Reflection.CallingConventions] 'Standard, HasThis',
        @([string], [System.Exception]))
    
    $constructor0ilgen = $constructor0builder.GetILGenerator()
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_0)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_1)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_2)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Call, [System.ApplicationException].GetConstructor([type[]] @([string], [System.Exception])))
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ret)
    
    $builttype = $typebuilder.CreateType()
    
    $type_pstypeaccelerators::Add('MyErrorMessageException', $builttype)
}

& {
    $typename = "$MyExceptionNamespace.MyErrorCodeException"
    
    $typebuilder = $modbuilder.DefineType(
	    $typename,
	    [System.Reflection.TypeAttributes] 'AutoLayout, AnsiClass, Class, Public, BeforeFieldInit',
	    [System.ApplicationException])
    
    $constructor0builder = $typebuilder.DefineConstructor(
        [System.Reflection.MethodAttributes] 'PrivateScope, Public, HideBySig, SpecialName, RTSpecialName',
        [System.Reflection.CallingConventions] 'Standard, HasThis',
        @([Int32], [System.Exception]))
    
    $field0builder = $typebuilder.DefineField(
	    'MyErrorCode',
	    [System.Int32],
	    [System.Reflection.FieldAttributes] 'Public, InitOnly')
    
    $constructor0ilgen = $constructor0builder.GetILGenerator()
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_0)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldstr, 'my error code is {0}')
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_1)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Box, [Int32])
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Call, [string].GetMethod('Format', [type[]]@([string], [object])))
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_2)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Call, [System.ApplicationException].GetConstructor([type[]] @([string], [System.Exception])))
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_0)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ldarg_1)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Stfld, $field0builder)
    $constructor0ilgen.Emit([System.Reflection.Emit.OpCodes]::Ret)
    
    $builttype = $typebuilder.CreateType()
    
    $type_pstypeaccelerators::Add('MyErrorCodeException', $builttype)
}
