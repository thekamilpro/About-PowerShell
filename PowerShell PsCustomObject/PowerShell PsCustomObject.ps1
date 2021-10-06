
<#PSScriptInfo
.VERSION 1.0.0
.GUID f5228c81-d25c-4984-bb0c-e64576487b3e
.AUTHOR Kamil Procyszyn
.COPYRIGHT Kamil Procyszyn
.PROJECTURI https://github.com/kprocyszyn/About-PowerShell
.RELEASENOTES 2021 October
.DESCRIPTION
Link to the video:
Documentation:
#>

<#
About PsCustomObject:

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

#########
# Types #
#########

$obj | GM # now it is PSCustomObject, duh

$obj.psobject.TypeNames # this looks familiar
$obj.psobject.TypeNames.Insert(0, "Kp.CatsAreAwesome")
$obj | GM

function Fun {
    param ( 
        [PSTypeName('Kp.CatsAreAwesome')]
        [Parameter(ValueFromPipeline)]
        $Cat 
        )
        
        if ($PSBoundParameters.ContainsKey('Cat')) {
            "Here's an awesome cat:"
            return $Cat.SayHi()
        } else {
            "Cats are awesome!"
        }
}

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
$obj2 | fun

# Specify default output
Update-TypeData -TypeName kp.CatsAreAwesome -DefaultDisplayPropertySet Name,Type
$obj # list is now limited to only Name and Type properties
$obj | fl * #displays all