# Swift: The Dirty Secret of enum's rawValue

## Abstract

The behavior of `init?(rawValue:)` for `enum` types imported from (Objective-)C is not well documented and can lead to confusion or errors in code

## Introduction

The Swift language provides a lot of improvement over enums in (Objective-C). They are _first-class types in their own right_, whereas in C they are basically just an `Int` container with a few fancy labels.

This leads to a problem that can easily be overlooked and is not obviously mentioned in the documentation. The documentation states that:

_If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type and returns either an enumeration case or nil._

(Objective-)C Enums are automatically converted to Swift:

_Swift imports any C enumeration marked with the NS_ENUM macro as a Swift enumeration with an Int raw value type._

So this:

```C
typedef NS_ENUM(NSInteger, CEnum) {
    Foo,
    Bar
};
```

becomes this:

```Swift
public enum CEnum : Int {

case Foo
case Bar
}
```

## Does it really?

As stated above, a C enum can be assigned any integer value, without regard to a label being defined for that case. So `CEnum e = 4;` is perfectly valid.
Thus, a return value of type `CEnum` may contain any integer value. The only place where this is clearly documented is in the Swift sourcecode:

```Swift
// Unlike a standard init(rawValue:) enum initializer, this does a reinterpret
// cast in order to preserve unknown or future cases from C.
```
https://github.com/apple/swift/blob/3ffbe020d76112c9a5f1bc05e64f272a9ba2ff6e/lib/ClangImporter/ImportDecl.cpp#L407

Knowning this, there are things to be aware of:

## Issue One: No validity checking

This means, that for enums imported this way, `rawValue` will *not* return nil if no label can be found. This makes it impossible to check if a certain raw value corresponds to an existing label. Every possible raw value will return a valid object

## Issue Two: Exhaustiveness

Swift's `switch` statement demands to be exhaustive, that is you must cover every possible case, or insert a `default:` clause. What about our `CEnum`?

```Swift
if let e = CEnum(rawValue: 4) {
    switch e {
        case .Foo:
            print ("We have Foo")
        case .Bar:
            print ("We have Bar")
    }
}
```

The above is completely valid Swift code and will not lead to a compiler error. But what will happen at runtime? Even then, we are not informed of any issue and our `CEnum` with the value 4 is recognized as the first enumeration case, `.Foo`. One might think that `.Bar` would be the better choice, but it does not matter because neither is correct. 

Worse yet, the introduction of a `default:` case will generate the warning `warning: default will never be executed`. This is actually true: Even with the default case, our enum will be recognized as `.Foo`

That said, transforming the enum back into a raw value will correctly return the value `4` which provides a workaround to cover special cases with a `default:`case.

## Summary 

All the demonstrated issues of course arise from the behavior of enums in C, and Swift is simply trying it's best to emulate this behaviour.

As most, if not all, Apple Framework emums are currently imported from (Objective-)C, this concerns a significant number of enums that will be used in any given Swift app. Developers should be aware that sometimes what you see is not what you get. 

## Links

_Not all possible Int values will find a matching planet, however. Because of this, the raw value initializer always returns an optional enumeration case._
https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html


_Swift imports any C enumeration marked with the NS_ENUM macro as a Swift enumeration with an Int raw value type_
https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithCAPIs.html

