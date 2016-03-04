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

func faz (x : CEnum) {
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

let bar = CEnum(rawValue: 4)

if bar == nil {
    print ("✅ C Enum is nil")
}
else {
    print ("❌ C Enum is not nil, but \(bar!.rawValue)")
    faz (bar!)
}

