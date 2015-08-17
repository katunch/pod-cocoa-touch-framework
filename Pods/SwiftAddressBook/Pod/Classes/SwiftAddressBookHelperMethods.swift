//
//  SwiftAddressBookHelperMethods.swift
//  Pods
//
//  Created by Socialbit - Tassilo Karge on 09.03.15.
//
//

import Foundation
import AddressBook

extension NSString {

	convenience init?(optionalString : String?) {
		if optionalString == nil {
			self.init()
			return nil
		}
		self.init(string: optionalString!)
	}
}

func errorIfNoSuccess(call : (UnsafeMutablePointer<Unmanaged<CFError>?>) -> Bool) -> CFError? {
	var err : Unmanaged<CFError>? = nil
	let success : Bool = call(&err)
	if success {
		return nil
	}
	else {
		return err?.takeRetainedValue()
	}
}


//MARK: methods to convert arrays of ABRecords

func convertRecordsToSources(records : CFArray?) -> [SwiftAddressBookSource]? {
	let swiftRecords = (records as? [ABRecord])?.map {(record : ABRecord) -> SwiftAddressBookSource in return SwiftAddressBookRecord(record: record).convertToSource()!}
	return swiftRecords
}

func convertRecordsToGroups(records : CFArray?) -> [SwiftAddressBookGroup]? {
	let swiftRecords = (records as? [ABRecord])?.map {(record : ABRecord) -> SwiftAddressBookGroup in return SwiftAddressBookRecord(record: record).convertToGroup()!}
	return swiftRecords
}

func convertRecordsToPersons(records : CFArray?) -> [SwiftAddressBookPerson]? {
	let swiftRecords = (records as? [ABRecord])?.map {(record : ABRecord) -> SwiftAddressBookPerson in
		return SwiftAddressBookRecord(record: record).convertToPerson()!
	}
	return swiftRecords
}
