//
//  Place.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation

struct PlacesResult: Codable {
    let results: [Place]
}

struct Place: Codable {
    let id: String
    let name: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case name, location
        case id = "fsq_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.location = try container.decodeIfPresent(Location.self, forKey: .location) ?? Location(formattedAddress: "")
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
    }

    init(id: String, name: String, location: Location) {
        self.id = id
        self.name = name
        self.location = location
    }
}

extension Place {
    struct Location: Codable {
        let formattedAddress: String

        enum CodingKeys: String, CodingKey {
            case formattedAddress = "formatted_address"
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<Place.Location.CodingKeys> = try decoder.container(keyedBy: Place.Location.CodingKeys.self)
            self.formattedAddress = try container.decodeIfPresent(String.self, forKey: Place.Location.CodingKeys.formattedAddress) ?? ""
        }

        init(formattedAddress: String) {
            self.formattedAddress = formattedAddress
        }
    }
}

extension Place: Equatable {}
extension Place.Location: Equatable {}
