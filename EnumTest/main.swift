//
//  main.swift
//  EnumTest
//
//  Created by Alexander v. Below on 03.03.16.
//
//  Copyright (c) 2016 Alexander von Below
//
//  See the LICENSE file for details

import Foundation

public enum SwiftEnum : Int {
    case Foo
    case Bar
}

func faz (_ x : CEnum) {
    switch x {
    case .Foo:
        print ("We have Foo")
    case .Bar:
        print ("We have Bar")
    default:
        print ("We have something else")
    }
}

let foo = SwiftEnum(rawValue: 4)

if foo == nil {
    print ("✅ Swift Enum is nil")
}
else {
    print ("❌ Swift Enum is not nil")
}

if let bar = CEnum(rawValue: 4) {
    switch bar {
        case .Foo:
            print ("We have Foo")
        case .Bar:
            print ("We have Bar")
    @unknown default:
        print ("C Enum is a differnet value: \(bar.rawValue)")
    }
}
