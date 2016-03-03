//
//  main.swift
//  EnumTest
//
//  Created by Alexander v. Below on 03.03.16.
//  Copyright © 2016 Alexander von Below. All rights reserved.
//

import Foundation

public enum SwiftEnum : Int {
    case foo
    case bar
}

let foo = SwiftEnum(rawValue: 3)

if foo == nil {
    print ("✅ Swift Enum is nil")
}
else {
    print ("❌ Swift Enum is not nil")
}

let bar = ObjcEnum(rawValue: 3)

if bar == nil {
    print ("✅ ObjC Enum is nil")
}
else {
    print ("❌ ObjC Enum is not nil")
}
