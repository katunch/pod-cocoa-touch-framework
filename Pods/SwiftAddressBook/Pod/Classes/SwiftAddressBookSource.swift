
//
//  SwiftAddressBookSource.swift
//  Pods
//
//  Created by Socialbit - Tassilo Karge on 09.03.15.
//
//

import Foundation
import AddressBook

//MARK: Wrapper for ABAddressBookRecord of type ABSource

public class SwiftAddressBookSource : SwiftAddressBookRecord {

	public var sourceType : SwiftAddressBookSourceType {
		get {
			return SwiftAddressBookSourceType(abSourceType: internalSourceType)
		}
	}

	public var searchable : Bool {
		get {
			return (kABSourceTypeSearchableMask & internalSourceType) != 0
		}
	}

	private var internalSourceType : Int32 {
		get {
			let sourceType = ABRecordCopyValue(internalRecord, kABSourceTypeProperty)?.takeRetainedValue() as! NSNumber
			return sourceType.intValue
		}
	}

	public var sourceName : String? {
		get {
			return ABRecordCopyValue(internalRecord, kABSourceNameProperty)?.takeRetainedValue() as? String
		}
	}
}
