//
//  SwiftAddressBookRecord.swift
//  Pods
//
//  Created by Socialbit - Tassilo Karge on 09.03.15.
//
//

import Foundation
import AddressBook

//MARK: Wrapper for ABAddressBookRecord

public class SwiftAddressBookRecord {

	public var internalRecord : ABRecord

	init(record : ABRecord) {
		internalRecord = record
	}

	public var recordID: Int {
		get {
			return Int(ABRecordGetRecordID(self.internalRecord))
		}
	}

	public func convertToSource() -> SwiftAddressBookSource? {
		if ABRecordGetRecordType(internalRecord) == UInt32(kABSourceType) {
			let source = SwiftAddressBookSource(record: internalRecord)
			return source
		}
		else {
			return nil
		}
	}

	public func convertToGroup() -> SwiftAddressBookGroup? {
		if ABRecordGetRecordType(internalRecord) == UInt32(kABGroupType) {
			let group = SwiftAddressBookGroup(record: internalRecord)
			return group
		}
		else {
			return nil
		}
	}

	public func convertToPerson() -> SwiftAddressBookPerson? {
		if ABRecordGetRecordType(internalRecord) == UInt32(kABPersonType) {
			let person = SwiftAddressBookPerson(record: internalRecord)
			return person
		}
		else {
			return nil
		}
	}
}
