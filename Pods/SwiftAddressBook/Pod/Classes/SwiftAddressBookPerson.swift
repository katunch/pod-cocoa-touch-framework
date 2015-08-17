//
//  SwiftAddressBookPerson.swift
//  Pods
//
//  Created by Socialbit - Tassilo Karge on 09.03.15.
//
//

import UIKit
import AddressBook

//MARK: Wrapper for ABAddressBookRecord of type ABPerson

public class SwiftAddressBookPerson : SwiftAddressBookRecord {

	public class func create() -> SwiftAddressBookPerson {
		return SwiftAddressBookPerson(record: ABPersonCreate().takeRetainedValue())
	}

	public class func createInSource(source : SwiftAddressBookSource) -> SwiftAddressBookPerson {
		return SwiftAddressBookPerson(record: ABPersonCreateInSource(source.internalRecord).takeRetainedValue())
	}

	public class func createInSourceWithVCard(source : SwiftAddressBookSource, vCard : String) -> [SwiftAddressBookPerson]? {
		let data : NSData? = vCard.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
		let abPersons : NSArray? = ABPersonCreatePeopleInSourceWithVCardRepresentation(source.internalRecord, data).takeRetainedValue()
		var swiftPersons = [SwiftAddressBookPerson]()
		if let persons = abPersons {
			for person : ABRecord in persons {
				let swiftPerson = SwiftAddressBookPerson(record: person)
				swiftPersons.append(swiftPerson)
			}
		}
		if swiftPersons.count != 0 {
			return swiftPersons
		}
		else {
			return nil
		}
	}

	public class func createVCard(people : [SwiftAddressBookPerson]) -> String {
		let peopleArray : NSArray = people.map{$0.internalRecord}
		let data : NSData = ABPersonCreateVCardRepresentationWithPeople(peopleArray).takeRetainedValue()
		return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
	}

	public class func ordering() -> SwiftAddressBookOrdering {
		return SwiftAddressBookOrdering(ordering: ABPersonGetSortOrdering())
	}

	public class func comparePeopleByName(person1 : SwiftAddressBookPerson, person2 : SwiftAddressBookPerson, ordering : SwiftAddressBookOrdering) -> CFComparisonResult {
		return ABPersonComparePeopleByName(person1, person2, ordering.abPersonSortOrderingValue)
	}


	//MARK: Personal Information

	public func setImage(image : UIImage) -> CFError? {
		let imageData : NSData = UIImagePNGRepresentation(image)
		return errorIfNoSuccess { ABPersonSetImageData(self.internalRecord,  CFDataCreate(nil, UnsafePointer(imageData.bytes), imageData.length), $0) }
	}

	public var image : UIImage? {
		get {
			return ABPersonHasImageData(internalRecord) ? UIImage(data: ABPersonCopyImageData(internalRecord).takeRetainedValue()) : nil
		}
	}

	public func imageDataWithFormat(format : SwiftAddressBookPersonImageFormat) -> UIImage? {
		return UIImage(data: ABPersonCopyImageDataWithFormat(internalRecord, format.abPersonImageFormat).takeRetainedValue())
	}

	public func hasImageData() -> Bool {
		return ABPersonHasImageData(internalRecord)
	}

	public func removeImage() -> CFError? {
		return errorIfNoSuccess { ABPersonRemoveImageData(self.internalRecord, $0) }
	}

	public var allLinkedPeople : Array<SwiftAddressBookPerson>? {
		get {
			return convertRecordsToPersons(ABPersonCopyArrayOfAllLinkedPeople(internalRecord).takeRetainedValue())
		}
	}

	public var source : SwiftAddressBookSource {
		get {
			return SwiftAddressBookSource(record: ABPersonCopySource(internalRecord).takeRetainedValue())
		}
	}

	public var compositeNameDelimiterForRecord : String {
		get {
			return ABPersonCopyCompositeNameDelimiterForRecord(internalRecord).takeRetainedValue() as String
		}
	}

	public var compositeNameFormat : SwiftAddressBookCompositeNameFormat {
		get {
			return SwiftAddressBookCompositeNameFormat(format: ABPersonGetCompositeNameFormatForRecord(internalRecord))
		}
	}

	public var compositeName : String? {
		get {
			return ABRecordCopyCompositeName(internalRecord)?.takeRetainedValue() as? String
		}
	}

	public var firstName : String? {
		get {
			return extractProperty(kABPersonFirstNameProperty)
		}
		set {
			setSingleValueProperty(kABPersonFirstNameProperty,  newValue as NSString?)
		}
	}

	public var lastName : String? {
		get {
			return extractProperty(kABPersonLastNameProperty)
		}
		set {
			setSingleValueProperty(kABPersonLastNameProperty,  newValue as NSString?)
		}
	}

	public var middleName : String? {
		get {
			return extractProperty(kABPersonMiddleNameProperty)
		}
		set {
			setSingleValueProperty(kABPersonMiddleNameProperty,  newValue as NSString?)
		}
	}

	public var prefix : String? {
		get {
			return extractProperty(kABPersonPrefixProperty)
		}
		set {
			setSingleValueProperty(kABPersonPrefixProperty,  newValue as NSString?)
		}
	}

	public var suffix : String? {
		get {
			return extractProperty(kABPersonSuffixProperty)
		}
		set {
			setSingleValueProperty(kABPersonSuffixProperty,  newValue as NSString?)
		}
	}

	public var nickname : String? {
		get {
			return extractProperty(kABPersonNicknameProperty)
		}
		set {
			setSingleValueProperty(kABPersonNicknameProperty,  newValue as NSString?)
		}
	}

	public var firstNamePhonetic : String? {
		get {
			return extractProperty(kABPersonFirstNamePhoneticProperty)
		}
		set {
			setSingleValueProperty(kABPersonFirstNamePhoneticProperty,  newValue as NSString?)
		}
	}

	public var lastNamePhonetic : String? {
		get {
			return extractProperty(kABPersonLastNamePhoneticProperty)
		}
		set {
			setSingleValueProperty(kABPersonLastNamePhoneticProperty,  newValue as NSString?)
		}
	}

	public var middleNamePhonetic : String? {
		get {
			return extractProperty(kABPersonMiddleNamePhoneticProperty)
		}
		set {
			setSingleValueProperty(kABPersonMiddleNamePhoneticProperty,  newValue as NSString?)
		}
	}

	public var organization : String? {
		get {
			return extractProperty(kABPersonOrganizationProperty)
		}
		set {
			setSingleValueProperty(kABPersonOrganizationProperty,  newValue as NSString?)
		}
	}

	public var jobTitle : String? {
		get {
			return extractProperty(kABPersonJobTitleProperty)
		}
		set {
			setSingleValueProperty(kABPersonJobTitleProperty,  newValue as NSString?)
		}
	}

	public var department : String? {
		get {
			return extractProperty(kABPersonDepartmentProperty)
		}
		set {
			setSingleValueProperty(kABPersonDepartmentProperty,  newValue as NSString?)
		}
	}

	public var emails : Array<MultivalueEntry<String>>? {
		get {
			return extractMultivalueProperty(kABPersonEmailProperty)
		}
		set {
			setMultivalueProperty(kABPersonEmailProperty, convertMultivalueEntries(newValue, converter: {  $0 as NSString }))
		}
	}

	public var birthday : NSDate? {
		get {
			return extractProperty(kABPersonBirthdayProperty)
		}
		set {
			setSingleValueProperty(kABPersonBirthdayProperty, newValue)
		}
	}

	public var note : String? {
		get {
			return extractProperty(kABPersonNoteProperty)
		}
		set {
			setSingleValueProperty(kABPersonNoteProperty,  newValue as NSString?)
		}
	}

	public var creationDate : NSDate? {
		get {
			return extractProperty(kABPersonCreationDateProperty)
		}
		set {
			setSingleValueProperty(kABPersonCreationDateProperty, newValue)
		}
	}

	public var modificationDate : NSDate? {
		get {
			return extractProperty(kABPersonModificationDateProperty)
		}
		set {
			setSingleValueProperty(kABPersonModificationDateProperty, newValue)
		}
	}

	public var addresses : Array<MultivalueEntry<Dictionary<SwiftAddressBookAddressProperty,AnyObject>>>? {
		get {
			let keyConverter = {(s : NSString) -> SwiftAddressBookAddressProperty in SwiftAddressBookAddressProperty(property: s as String)}
			let valueConverter = { (s : AnyObject) -> AnyObject in return s }
			return extractMultivalueDictionaryProperty(kABPersonAddressProperty, keyConverter: keyConverter, valueConverter: valueConverter)
		}
		set {
			setMultivalueDictionaryProperty(kABPersonAddressProperty, newValue, keyConverter: { $0.abAddressProperty as NSString }, valueConverter: { $0 } )
		}
	}

	public var dates : Array<MultivalueEntry<NSDate>>? {
		get {
			return extractMultivalueProperty(kABPersonDateProperty)
		}
		set {
			setMultivalueProperty(kABPersonDateProperty, newValue)
		}
	}

	public var type : SwiftAddressBookPersonType {
		get {
			return SwiftAddressBookPersonType(type : extractProperty(kABPersonKindProperty))
		}
		set {
			setSingleValueProperty(kABPersonKindProperty, newValue.abPersonType)
		}
	}

	public var phoneNumbers : Array<MultivalueEntry<String>>? {
		get {
			return extractMultivalueProperty(kABPersonPhoneProperty)
		}
		set {
			setMultivalueProperty(kABPersonPhoneProperty, convertMultivalueEntries(newValue, converter: { $0 as NSString}))
		}
	}

	public var instantMessage : Array<MultivalueEntry<Dictionary<SwiftAddressBookInstantMessagingProperty,String>>>? {
		get {
			let keyConverter = {(s : NSString) -> SwiftAddressBookInstantMessagingProperty in SwiftAddressBookInstantMessagingProperty(property: s as String)}
			let valueConverter = { (s : String) -> String in return s }
			return extractMultivalueDictionaryProperty(kABPersonInstantMessageProperty, keyConverter: keyConverter, valueConverter: valueConverter)
		}
		set {
			setMultivalueDictionaryProperty(kABPersonInstantMessageProperty, newValue, keyConverter: {  $0.abInstantMessageProperty as NSString }, valueConverter: {  $0 as NSString })
		}
	}

	public var socialProfiles : Array<MultivalueEntry<Dictionary<SwiftAddressBookSocialProfileProperty,String>>>? {
		get {
			let keyConverter = {(s : NSString) -> SwiftAddressBookSocialProfileProperty in SwiftAddressBookSocialProfileProperty(property: s as String)}
			let valueConverter = { (s : String) -> String in return s }
			return extractMultivalueDictionaryProperty(kABPersonSocialProfileProperty, keyConverter: keyConverter, valueConverter: valueConverter)
		}
		set {
			setMultivalueDictionaryProperty(kABPersonSocialProfileProperty, newValue, keyConverter: {  $0.abSocialProfileProperty as NSString }, valueConverter:  {  $0 as NSString } )
		}
	}


	public var urls : Array<MultivalueEntry<String>>? {
		get {
			return extractMultivalueProperty(kABPersonURLProperty)
		}
		set {
			setMultivalueProperty(kABPersonURLProperty, convertMultivalueEntries(newValue, converter: {  $0 as NSString }))
		}
	}

	public var relatedNames : Array<MultivalueEntry<String>>? {
		get {
			return extractMultivalueProperty(kABPersonRelatedNamesProperty)
		}
		set {
			setMultivalueProperty(kABPersonRelatedNamesProperty, convertMultivalueEntries(newValue, converter: {  $0 as NSString }))
		}
	}

	public var alternateBirthday : Dictionary<String, AnyObject>? {
		get {
			return extractProperty(kABPersonAlternateBirthdayProperty)
		}
		set {
			let dict : NSDictionary? = newValue
			setSingleValueProperty(kABPersonAlternateBirthdayProperty, dict)
		}
	}


	//MARK: generic methods to set and get person properties

	private func extractProperty<T>(propertyName : ABPropertyID) -> T? {
		//the following is two-lines of code for a reason. Do not combine (compiler optimization problems)
		var value: AnyObject? = ABRecordCopyValue(self.internalRecord, propertyName)?.takeRetainedValue()
		return value as? T
	}

	private func setSingleValueProperty<T : AnyObject>(key : ABPropertyID,_ value : T?) {
		ABRecordSetValue(self.internalRecord, key, value, nil)
	}

	private func extractMultivalueProperty<T>(propertyName : ABPropertyID) -> Array<MultivalueEntry<T>>? {
		var array = Array<MultivalueEntry<T>>()
		let multivalue : ABMultiValue? = extractProperty(propertyName)
		for i : Int in 0..<(ABMultiValueGetCount(multivalue)) {
			let value : T? = ABMultiValueCopyValueAtIndex(multivalue, i).takeRetainedValue() as? T
			if let v : T = value {
				let id : Int = Int(ABMultiValueGetIdentifierAtIndex(multivalue, i))
				let label = ABMultiValueCopyLabelAtIndex(multivalue, i)?.takeRetainedValue() as? String
				array.append(MultivalueEntry(value: v, label: label, id: id))
			}
		}
		if array.count > 0 {
			return array
		}
		else {
			return nil
		}
	}

	private func extractMultivalueDictionaryProperty<T : NSCopying, U, V, W>(propertyName : ABPropertyID, keyConverter : (T) -> V, valueConverter : (U) -> W ) -> Array<MultivalueEntry<Dictionary<V, W>>>? {

		var property : Array<MultivalueEntry<NSDictionary>>? = extractMultivalueProperty(propertyName)
		if let array = property {

			var array2 : Array<MultivalueEntry<Dictionary<V, W>>> = []
			for oldValue in array {
				let mv = MultivalueEntry(value: convertNSDictionary(oldValue.value, keyConverter: keyConverter, valueConverter: valueConverter)!, label: oldValue.label, id: oldValue.id)
				array2.append(mv);
			}
			return array2

		}
		else {
			return nil
		}
	}

	private func convertNSDictionary<T : NSCopying, U, V, W>(d : NSDictionary?, keyConverter : (T) -> V, valueConverter : (U) -> W ) -> Dictionary<V, W>? {
		if let d2 = d {
			var dict = Dictionary<V,W>()
			for key in d2.allKeys as! Array<T> {
				let newKey = keyConverter(key)
				let newValue = valueConverter(d2[key] as! U)
				dict[newKey] = newValue
			}
			return dict
		}
		else {
			return nil
		}
	}

	private func convertDictionary<T, U, V : AnyObject, W : AnyObject where V : Hashable>(d : Dictionary<T,U>?, keyConverter : (T) -> V, valueConverter : (U) -> W ) -> NSDictionary? {
		if let d2 = d {
			var dict = Dictionary<V,W>()
			for key in d2.keys {
				dict[keyConverter(key)] = valueConverter(d2[key]!)
			}
			return dict
		}
		else {
			return nil
		}
	}

	private func convertMultivalueEntries<T,U: AnyObject>(multivalue : [MultivalueEntry<T>]?, converter : (T) -> U) -> [MultivalueEntry<U>]? {

		var result: [MultivalueEntry<U>]?
		if let multivalue = multivalue {
			result = []
			for m in multivalue {
				var convertedValue = converter(m.value)
				var converted = MultivalueEntry(value: convertedValue, label: m.label, id: m.id)
				result?.append(converted)
			}
		}
		return result
	}

	private func setMultivalueProperty<T : AnyObject>(key : ABPropertyID,_ multivalue : Array<MultivalueEntry<T>>?) {
		if(multivalue == nil) {
			let emptyMultivalue: ABMutableMultiValue = ABMultiValueCreateMutable(ABPersonGetTypeOfProperty(key)).takeRetainedValue()
			//TODO: handle possible error
			let error = errorIfNoSuccess { ABRecordSetValue(self.internalRecord, key, emptyMultivalue, $0) }
			return
		}

		var abmv : ABMutableMultiValue? = nil

		/* make mutable copy to be able to update multivalue */
		if let oldValue : ABMultiValue = extractProperty(key) {
			abmv = ABMultiValueCreateMutableCopy(oldValue)?.takeRetainedValue()
		}

		var abmv2 : ABMutableMultiValue? = abmv

		/* initialize abmv for sure */
		if abmv2 == nil {
			abmv2 = ABMultiValueCreateMutable(ABPersonGetTypeOfProperty(key)).takeRetainedValue()
		}

		let abMultivalue: ABMutableMultiValue = abmv2!

		var identifiers = Array<Int>()

		for i : Int in 0..<(ABMultiValueGetCount(abMultivalue)) {
			identifiers.append(Int(ABMultiValueGetIdentifierAtIndex(abMultivalue, i)))
		}

		for m : MultivalueEntry in multivalue! {
			if contains(identifiers, m.id) {
				let index = ABMultiValueGetIndexForIdentifier(abMultivalue, Int32(m.id))
				ABMultiValueReplaceValueAtIndex(abMultivalue, m.value, index)
				ABMultiValueReplaceLabelAtIndex(abMultivalue, m.label, index)
				identifiers.removeAtIndex(find(identifiers,m.id)!)
			}
			else {
				ABMultiValueAddValueAndLabel(abMultivalue, m.value, m.label, nil)
			}
		}

		for i in identifiers {
			ABMultiValueRemoveValueAndLabelAtIndex(abMultivalue, ABMultiValueGetIndexForIdentifier(abMultivalue,Int32(i)))
		}

		ABRecordSetValue(internalRecord, key, abMultivalue, nil)
	}

	private func setMultivalueDictionaryProperty<T, U, V: AnyObject, W: AnyObject where V: Hashable>(key : ABPropertyID, _ multivalue : Array<MultivalueEntry<Dictionary<T,U>>>?,keyConverter : (T) -> V , valueConverter : (U)-> W) {

		let array = convertMultivalueEntries(multivalue, converter: { d -> NSDictionary in
			return self.convertDictionary(d, keyConverter: keyConverter, valueConverter: valueConverter)!
		})
		
		setMultivalueProperty(key, array)
	}
}
