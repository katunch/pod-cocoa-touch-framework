//
//  Utils.swift
//  Pod Error Framework
//
//  Created by Silas Knobel on 17/08/15.
//  Copyright (c) 2015 katun.ch. All rights reserved.
//

import Foundation
import SwiftAddressBook

public class Utils {
    public class func doSomething() -> String {
        return "I did something"
    }
    
    public class func requestContactsAccess(completion: (granted: Bool) -> Void) {
        swiftAddressBook?.requestAccessWithCompletion({ (granted, error) -> Void in
            completion(granted: granted)
        })
    }
    
}