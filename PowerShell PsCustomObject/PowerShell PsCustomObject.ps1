
<#PSScriptInfo
.VERSION 1.0.0
.GUID f5228c81-d25c-4984-bb0c-e64576487b3e
.AUTHOR Kamil Procyszyn
.COPYRIGHT Kamil Procyszyn
.PROJECTURI https://github.com/kprocyszyn/About-PowerShell
.RELEASENOTES 2021 November
.DESCRIPTION
Link to the video: https://youtu.be/DAVGyCytsqM
#>

<#
About PsCustomObject:
    https://forums.powershell.org/t/what-is-the-difference-between-pscustomobject-and-psobject/3887/4
    [PSCustomObject] is a type accelerator. It constructs a PSObject, but does so in a way that results in hash table keys 
    becoming properties. 
    PSCustomObject isn’t an object type per se - it’s a process shortcut. 
    The docs are relatively clear about it (https://msdn.microsoft.com/en-us/library/system.management.automation.pscustomobject(v=vs.85).aspx) 
    PSCustomObject is a placeholder that’s used when PSObject is called with no constructor parameters.
#>

# Creating custom object:
$obj = [PSCustomObject]@{
    Name    = "Mr Fiber"
    Species = "Domestic cat"
    Type    = "Tabby cat"
}
$obj
$obj.Name

# Saving to a file (JSON):
# We could save CSV, however CSV doesn't support nested properties, thus why JSON is preferable 
$Path = "$env:TEMP\pstojson.json"
$obj | ConvertTo-Json -Depth 99 | Set-Content -Path $path
$imported = Get-Content -Path $Path
$imported
$imported | ConvertFrom-Json

##############
# PROPERTIES #
##############

# Accessing properties
$obj.Species

# Dynamically accessing properties
$prop = 'Type'
$obj.$prop

# Adding property
$obj | Add-Member -MemberType NoteProperty -Name 'Favourite Snack' -Value 'Dental treats'
$obj.'Favourite Snack'

# Removing properties
$obj.psobject.Properties.Remove('Favourite Snack')
$obj.'Favourite Snack'

# Listing properteis
$obj.psobject.properties.name
$obj | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

#############
# Hashtable #
#############

# Converting hashtable to psobject:
$ht = @{
    Name    = "Mr Fiber"
    Species = "Domestic cat"
    Type    = "Tabby cat"
}
$ht
$htobj = [pscustomobject]$ht
$htobj

# Converting psobject to hashtable
$newHt = @{}
foreach ($property in $htobj.psobject.Properties.name) {
    $newHt[$property] = $htobj.$property
}
$newHt

###########
# Methods #
###########

# We can actually have some action!
$method = {
    "Hi, my name is $($this.name) and I like to sleep."
}

$params = @{
    MemberType = "ScriptMethod"
    Name       = "SayHi"
    Value      = $method
}
$obj | Add-Member @params
$obj.SayHi()

# How about, converting Object to Hashtable, as the actual method?
$params = @{
    MemberType = "ScriptMethod"
    Name       = "OutHashtable"
    Value      = {
        $hash = @{}
        $this.psobject.properties.name.foreach({
                $hash[$_] = $this.$_
            })
        return $hash
    }
}
$obj | Add-Member @params
$obj.OutHashtable()

#########
# Types #
#########

$obj | Get-Member # now it is PSCustomObject, duh

$obj.psobject.TypeNames # this looks familiar
$obj.psobject.TypeNames.Insert(0, "Kp.CatsAreAwesome")
$obj | Get-Member

function Invoke-CAA {
    param ( 
        # We only accept parameter of type Kp.CatsAreAwesome
        [PSTypeName('Kp.CatsAreAwesome')]
        [Parameter(ValueFromPipeline)]
        $Cat 
        )
        
        # If $Cat has been passed, we call method SayHi(), otherwise we just say that cats are awesome (generally)
        if ($PSBoundParameters.ContainsKey('Cat')) {
            "Here's an awesome cat:"
            return $Cat.SayHi()
        } else {
            "Cats are awesome!"
        }
}
Invoke-CAA
Invoke-Caa -Cat $obj
Invoke-Caa -Cat "BLA"

# We can also specify type name at creation
$obj2 = [pscustomobject]@{
    PSTypeName = 'Kp.CatsAreAwesome'
    Name = 'Whiskers'
    Species = "Domestic cat"
    Type    = "Persian"
}

$method = {
    "Hi, my name is $($this.name) and I like to sleep."
}

$params = @{
    MemberType = "ScriptMethod"
    Name       = "SayHi"
    Value      = $method
}
$obj2 | Add-Member @params
$obj2 | Invoke-CAA

# Specify default output
Update-TypeData -TypeName kp.CatsAreAwesome -DefaultDisplayPropertySet Name,Type
$obj # list is now limited to only Name and Type properties
$obj2
$obj | Format-List -Property * #displays all

# Let's see arrays and pscustomobjects working together
$list = [System.Collections.Generic.List[pscustomobject]]::new()
$locations = @("London", "Sligo", "Barcelona", "Paphos", "Ubud", "Valdemosa")
$baseUri = "wttr.in/"

foreach ($location in $locations) {
    "Currently retrieving weather for: $location"
    $Uri = "{0}{1}?format=j1" -f $baseUri, $location
    $Uri
    $data = Invoke-RestMethod $Uri
    $result = [pscustomobject]@{
        City = $Location
        Temperature = $data.current_condition.temp_C
        Pressure =  $data.current_condition.pressure
    }
    $list.Add($result)
}
$list