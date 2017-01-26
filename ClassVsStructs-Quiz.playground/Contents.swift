// Class vs. Structs Quiz
// Ryan Hennings 01/25/17

import UIKit

class Giant {
    var name: String
    var weight: Double
    var homePlanet: String // Change from "let"
    
    init(name: String, weight: Double, homePlanet: String) {
        self.name = name
        self.weight = weight
        self.homePlanet = homePlanet
    }
}
// Q1. Yes, should work
let fred = Giant(name: "Fred", weight: 340.0, homePlanet: "Earth")

// Q2. No, .homePlanet is a constant and needs to be a var
fred.name = "Brick"
fred.weight = 999.2
fred.homePlanet = "Mars"

struct Alien {
    var name: String
    var height: Double
    var homePlanet: String
}

var bilbo = Alien(name: "Bilbo", height: 1.67, homePlanet: "Venus")

// Q3. No, bilbo is a constant and the struct type values are locked in when assigned to a constant
bilbo.name = "Jake"
bilbo.height = 1.42
bilbo.homePlanet = "Saturn"
// Q4. Changing bilbo to a variable should fix the problem

// Q5. The code should run. The value of edgar should be the same as jason though, since both edgar and jason are pointing to the same instance of Giant
let edgar = Giant(name: "Edgar", weight: 520.0, homePlanet: "Earth")
let jason = edgar
jason.name = "Jason"
print(edgar.name) // Verifying that edgar has also been changed
print(jason.name)

// Q6. Since Alien is a struct, its contents are passed by values and are copied to new instances
//     Alien charles should still have a homePlanet of Pulto (not a planet btw)
//     Alien charlesFromJupiter **copied** charles information into a new instance and will have a homePlanet of "Jupiter"
var charles = Alien(name: "Charles", height: 2.25, homePlanet: "Pluto")
var charlesFromJupiter = charles
charlesFromJupiter.homePlanet = "Jupiter"
print(charles.homePlanet) // Remains "Pluto" as expected
print(charlesFromJupiter.homePlanet) // Is "Jupiter" as expected

// Q7. I don't think the code will compile as the methods of BankAccount are mutating the data which is not allowed unless they are **mutating functions**
struct BankAccount {
    var owner: String
    var balance: Double
    
    // Add mutating to allow balance to be changed
    mutating func deposit(_ amount: Double) {
        balance += amount
    }
    
    // Add mutating to allow balance to be changed
    mutating func withdraw(_ amount: Double) {
        balance -= amount
    }
}
// Q8. Simply adding mutating to the functions deposit(_:) and withdraw(_:) should correct the code


// Q9. joeAccount and joeOtherAccount are seperate instances since BankAccount is a struct.
//      joeOtherAccount recieves a copy of joeAccount before any changes are made
//      joeAccount.balance will be 50.0 as it was changed when joeAccount.withdraw(50.0) is called
//          and the balace will be: 100.0 - 50.0 = 50.0
//      joeOtherAccount is its own instance not affected by joeAccount.withdraw(50.0) and should
//          remain at 100.0 from when it was copied to joeAccount
var joeAccount = BankAccount(owner: "Joe", balance: 100.0)
var joeOtherAccount = joeAccount
joeAccount.withdraw(50.0)
print(joeAccount.balance) // Prints 50.0 as expected
print(joeOtherAccount.balance) // Prints 100.0 as expected


// Q10. library1 and library2 are pointing to the same instance since MusicLibrary is a class
//      The contents are passed by reference when library1 is assigned to library2
//      They should boths contain the array ["Michelle","Voodoo Child","Come As You Are"]
class MusicLibrary {
    var tracks: [String]
    
    init() {
        tracks = []
    }
    
    func add(track: String) {
        tracks.append(track)
    }
}
let library1 = MusicLibrary()
library1.add(track: "Michelle")
library1.add(track: "Voodoo Child")
let library2 = library1
library2.add(track: "Come As You Are")
print(library1.tracks) // Prints ["Michelle","Voodoo Child","Come As You Are"] as expected
print(library2.tracks) // Prints ["Michelle","Voodoo Child","Come As You Are"] as expected
// Even though library2.add(track: "Come As You Are") is performed after library1 is assigned to library 2
// They are still both refering to the same instance of MusicLibrary which contains the array
// ["Michelle","Voodoo Child","Come As You Are"] and thus, will both print that


