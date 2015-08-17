# SwiftAddressBook - A strong-typed Swift Wrapper for ABAddressBook

[![CI Status](http://img.shields.io/travis/SocialbitGmbH/SwiftAddressBook.svg?style=flat)](https://travis-ci.org/SocialbitGmbH/SwiftAddressBook)
[![Version](https://img.shields.io/cocoapods/v/SwiftAddressBook.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAddressBook)
[![License](https://img.shields.io/cocoapods/l/SwiftAddressBook.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAddressBook)
[![Platform](https://img.shields.io/cocoapods/p/SwiftAddressBook.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAddressBook)

Complete wrapper for the ABAddressBook C-Framework for iOS, written in Swift to be typesafe and convenient

## Description

  It is tedious and requires very much reading in the documentation if you want to understand the ABAddressBook in iOS. To provide a solution, this wrapper uses Swift, which is strong-typed (unlike c). It also circumvents the use of unsafe c-pointers when accessing ABAddressBook from Swift, by directly casting them to the correct type. All properties, previously only available via the correct key, can now be accessed conveniently via variables.
  
  Here´s how you would access ABAddressBook via SwiftAddressBook: [How To](https://github.com/SocialbitGmbH/SwiftAddressBook/wiki/How-To)
  
  Some minimal examples below:
  
  1. Request access
  ```Swift
  swiftAddressBook?.requestAccessWithCompletion({ (success, error) -> Void in
      if success {
        //do something with swiftAddressBook
      }
      else {
        //no success. Optionally evaluate error
      }
  })
  ```
  
  2. Use Addressbook: 
    - Get array of all people and log their phone numbers)
      ```Swift
      if let people = swiftAddressBook?.allPeople {
          for person in people {
            NSLog("%@", person.phoneNumbers?.map( {$0.value} ))
          }
      }
      ```
      
    - Create Contacts
      ```Swift
      var person = SwiftAddressBookPerson.create()
      person.firstName = "John"
      
      var email = MultivalueEntry(value: "someone@gmail.com", label: "home", id: 0)
      person.emails = [email]
      
      swiftAddressBook?.addRecord(person)
      swiftAddressBook?.save()
      ```
      
Complicated Swift typecasting to NS-..., thousand times of unwrapping optionals, figuring out which constant is the key to your person property, distinguishing between group, source or person - nothing that you have to deal with any more

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SwiftAddressBook is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "SwiftAddressBook"

Note: version 0.36 requires you to also specify the flag

    use_frameworks!

as documented [here](http://blog.cocoapods.org/CocoaPods-0.36/)
and then `import SwiftAddressBook` in your project (and `import AddressBook` for using constants from ABAddressBook)

If you don´t want to use CocoaPods, or need to maintain iOS7 compatibility, just copy all files from the folder Pod/Classes into your project. This way, you don´t need to `import SwiftAddressBook`-



## License  
    Copyright 2014 Socialbit GmbH

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.   
