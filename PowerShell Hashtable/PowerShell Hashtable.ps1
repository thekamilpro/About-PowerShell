#Creating a hashtable
$hash = @{}

#############################
# Adding items to hashtable #
#############################

$hash.Add("Person", "John")
$hash.Add("Email", "John@john.com")
$hash.Add("Pet", "Cat")
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