#Creating a hashtable
$hash = @{}

#############################
# Adding items to hashtable #
#############################

$hash.Add("Person", "John")
$hash.Add("Email", "John@john.com")
$hash.Add("Pet", "Cat")
$hash.Add("Surname", "Smith")
$hash

# Removing Key from hashtable
$hash.Remove("Surname")
$hash

# Prepopulating hashtable
$details = @{
    Person = "Mike"
    Email = "Mike@Mike.com"
    Pet = "Dog"
}
$details

# Adding key that already exists throws
$details.Add("Pet", "Snake")

###################
# Accessing items #
###################

# Accessing with property name
$details['Pet']
$details.Pet

# We can use variable
$property = "Email"
$details[$property]

# Accessing multiple properties
$details["Email", "Person"]

# Non existent value doesn't throw
$details['Surname']
$details.Surname

# Although we can check for true/false 
[bool]$details['Surname']

###################
# Updating values #
###################

# We can update and add new values
$details['Pet'] = "Snake"
$details['Drink'] = "Flat white"
$details

$details.pet = "Dog"
$details.Food = "Lamb Shish Kebab"
$details

###########
# Looping #
###########

# using foreach
foreach ($key in $details.Keys) {
    "{0} is {1}" -f $key, $details[$key]
}

# piping to foreach-object
$details.Keys | ForEach-Object {
    "{0} is {1}" -f $_, $details[$_]
}

# GetEnumerator() allows us to work with properties
$details.GetEnumerator() | ForEach-Object {
    "{0} is {1}" -f $_.Key, $_.Value
}

# Values can't be updated while enumarated!
foreach ($key in $details.Keys) {
    $details[$key] = 'BLAH'
}

# Keys must be cloned before updating
$details.Keys.Clone() | ForEach-Object {
    $details[$_] = "SANITISED"
}
$details

######
# IF #
######

# checking if hashtable exists
if ($details) {"It's there"}

$empty = @{}
if ($empty) {"It's empty, but it's there!"}

# Checking if key exists
if ($details.Person) {"There's some info about a person"}

# Deailing with false
$details.Add("Empty", "")
$details.Add("Null", $Null)
$details.Add("False", $false)
$details

if ($details.Empty) {"It's there"}
if ($details.Null) {"It's there"}
if ($details.False) {"It's there"}

if ($details.ContainsKey('Null')) {"It's null!"}

######################
# Custom expressions #
######################

$employee = @{
    Name = "Beth"
    HourlyWage = 10
    "Hours worked" = 7.5
    }
$employee | Select-Object -Property  *,@{N = "Wage"; E = {$_.HourlyWage * $_."Hours Worked" } }