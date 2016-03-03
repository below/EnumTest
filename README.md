# EnumTest
A simple project to illustrate a possible Swift bug in `rawValue` for enums.

## Description
The Swift documentation says:

"Not all possible Int values will find a matching planet, however. Because of this, the raw value initializer always returns an optional enumeration case."
https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html


This is good, and a usecase is provided with the documentation:

```Swift
let positionToFind = 9
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
        case .Earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
    } else {
        print("There isn't a planet at position \(positionToFind)")
    }
```

The documentation does not give any indication this may be different for enums which were originally declared in Objective-C 

"Swift imports any C enumeration marked with the NS_ENUM macro as a Swift enumeration with an Int raw value type"
https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithCAPIs.html

However, this sample shows that raw values outside of the scope will return a non-nil, undefined result. This is significant as most of the framework enums are based on Objective-C code.