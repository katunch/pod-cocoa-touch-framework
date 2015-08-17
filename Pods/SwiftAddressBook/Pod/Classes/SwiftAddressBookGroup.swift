//
//  SwiftAddressBookGroup.swift
//  Pods
//
//  Created by Socialbit - Tassilo Karge on 09.03.15.
//
//

import Foundation
import AddressBook

//MARK: Wrapper for ABAddressBookRecord of type ABGroup

public class SwiftAddressBookGroup : SwiftAddressBookRecord {

	public var name : String? {
		get {
			return ABRecordCopyValue(internalRecord, kABGroupNameProperty)?.takeRetainedValue() as? String
		}
		set {
			ABRecordSetValue(internalRecord, kABGroupNameProperty, newValue, nil)
		}
	}

	public class func create() -> SwiftAddressBookGroup {
		return SwiftAddressBookGroup(record: ABGroupCreate().takeRetainedValue())
	}

	public class func createInSource(source : SwiftAddressBookSource) -> SwiftAddressBookGroup {
		return SwiftAddressBookGroup(record: ABGroupCreateInSource(source.internalRecord).takeRetainedValue())
	}

	public var allMembers : [SwiftAddressBookPerson]? {
		get {
			return convertRecordsToPersons(ABGroupCopyArrayOfAllMembers(internalRecord)?.takeRetainedValue())
		}
	}

	public func allMembersWithSortOrdering(ordering : SwiftAddressBookOrdering) -> [SwiftAddressBookPerson]? {
		return convertRecordsToPersons(ABGroupCopyArrayOfAllMembersWithSortOrdering(internalRecord, ordering.abPersonSortOrderingValue).takeRetainedValue())
	}

	public func addMember(person : SwiftAddressBookPerson) -> CFError? {
		return errorIfNoSuccess { ABGroupAddMember(self.internalRecord, person.internalRecord, $0) }
	}

	public func removeMember(person : SwiftAddressBookPerson) -> CFError? {
		return errorIfNoSuccess { ABGroupRemoveMember(self.internalRecord, person.internalRecord, $0) }
	}

	public var source : SwiftAddressBookSource {
		get {
			return SwiftAddressBookSource(record: ABGroupCopySource(internalRecord).takeRetainedValue())
		}
	}
}