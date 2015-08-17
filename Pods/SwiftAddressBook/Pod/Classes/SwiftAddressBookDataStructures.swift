//
//  SwiftAddressBookDataStructures.swift
//  Pods
//
//  Created by Socialbit - Tassilo Karge on 09.03.15.
//
//

import Foundation
import AddressBook

//MARK: multivalue entry for multivalue properties

public struct MultivalueEntry<T> {
	public var value : T
	public var label : String?
	public let id : Int

	public init(value: T, label: String?, id: Int) {
		self.value = value
		self.label = label
		self.id = id
	}
}

//MARK: swift structs for convenience

public enum SwiftAddressBookOrdering {

	case lastName, firstName

	init(ordering : ABPersonSortOrdering) {
		switch Int(ordering) {
		case kABPersonSortByLastName :
			self = .lastName
		case kABPersonSortByFirstName :
			self = .firstName
		default :
			self = .firstName
		}
	}

	public var abPersonSortOrderingValue : UInt32 {
		get {
			switch self {
			case .lastName :
				return UInt32(kABPersonSortByLastName)
			case .firstName :
				return UInt32(kABPersonSortByFirstName)
			}
		}
	}
}

public enum SwiftAddressBookCompositeNameFormat {
	case firstNameFirst, lastNameFirst

	init(format : ABPersonCompositeNameFormat) {
		switch Int(format) {
		case kABPersonCompositeNameFormatFirstNameFirst :
			self = .firstNameFirst
		case kABPersonCompositeNameFormatLastNameFirst :
			self = .lastNameFirst
		default :
			self = .firstNameFirst
		}
	}
}

public enum SwiftAddressBookSourceType {
	case local, exchange, exchangeGAL, mobileMe, LDAP, cardDAV, cardDAVSearch

	init(abSourceType : ABSourceType) {
		switch Int(abSourceType) {
		case kABSourceTypeLocal :
			self = .local
		case kABSourceTypeExchange :
			self = .exchange
		case kABSourceTypeExchangeGAL :
			self = .exchangeGAL
		case kABSourceTypeMobileMe :
			self = .mobileMe
		case kABSourceTypeLDAP :
			self = .LDAP
		case kABSourceTypeCardDAV :
			self = .cardDAV
		case kABSourceTypeCardDAVSearch :
			self = .cardDAVSearch
		default :
			self = .local
		}
	}
}

public enum SwiftAddressBookPersonImageFormat {
	case thumbnail
	case originalSize

	public var abPersonImageFormat : ABPersonImageFormat {
		switch self {
		case .thumbnail :
			return kABPersonImageFormatThumbnail
		case .originalSize :
			return kABPersonImageFormatOriginalSize
		}
	}
}


public enum SwiftAddressBookSocialProfileProperty {
	case url, service, username, userIdentifier

	init(property : String) {
		switch property {
		case String(kABPersonSocialProfileURLKey) :
			self = .url
		case String(kABPersonSocialProfileServiceKey) :
			self = .service
		case String(kABPersonSocialProfileUsernameKey) :
			self = .username
		case String(kABPersonSocialProfileUserIdentifierKey) :
			self = .userIdentifier
		default :
			self = .url
		}
	}

	public var abSocialProfileProperty : String {
		switch self {
		case .url :
			return String(kABPersonSocialProfileURLKey)
		case .service :
			return String(kABPersonSocialProfileServiceKey)
		case .username :
			return String(kABPersonSocialProfileUsernameKey)
		case .userIdentifier :
			return String(kABPersonSocialProfileUserIdentifierKey)
		}
	}
}

public enum SwiftAddressBookInstantMessagingProperty {
	case service, username

	init(property : String) {
		switch property {
		case String(kABPersonInstantMessageServiceKey) :
			self = .service
		case String(kABPersonInstantMessageUsernameKey) :
			self = .username
		default :
			self = .service
		}
	}

	public var abInstantMessageProperty : String {
		switch self {
		case .service :
			return String(kABPersonInstantMessageServiceKey)
		case .username :
			return String(kABPersonInstantMessageUsernameKey)
		}
	}
}

public enum SwiftAddressBookPersonType {

	case person, organization

	init(type : CFNumber?) {

		let typeNumber = type as NSNumber?

		if typeNumber?.compare(kABPersonKindPerson).rawValue == 0  {
			self = .person
		}
		else if typeNumber?.compare(kABPersonKindOrganization).rawValue == 0 {
			self = .organization
		}
		else {
			self = .person
		}
	}

	public var abPersonType : CFNumber {
		get {
			switch self {
			case .person :
				return kABPersonKindPerson
			case .organization :
				return kABPersonKindOrganization
			}
		}
	}
}

public enum SwiftAddressBookAddressProperty {
	case street, city, state, zip, country, countryCode

	init(property : String) {
		switch property {
		case String(kABPersonAddressStreetKey):
			self = .street
		case String(kABPersonAddressCityKey):
			self = .city
		case String(kABPersonAddressStateKey):
			self = .state
		case String(kABPersonAddressZIPKey):
			self = .zip
		case String(kABPersonAddressCountryKey):
			self = .country
		case String(kABPersonAddressCountryCodeKey):
			self = .countryCode
		default:
			self = .street
		}
	}

	public var abAddressProperty : String {
		get {
			switch self {
			case .street :
				return String(kABPersonAddressStreetKey)
			case .city :
				return String(kABPersonAddressCityKey)
			case .state :
				return String(kABPersonAddressStateKey)
			case .zip :
				return String(kABPersonAddressZIPKey)
			case .country :
				return String(kABPersonAddressCountryKey)
			case .countryCode :
				return String(kABPersonAddressCountryCodeKey)
			default:
				return String(kABPersonAddressStreetKey)
			}
		}
	}
}
