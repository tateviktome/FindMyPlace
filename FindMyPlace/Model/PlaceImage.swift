//
//  PlaceImage.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 14/01/2023.
//

import Foundation

struct PlaceImage: Codable {
    let prefix: String
    let suffix: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.prefix = try container.decodeIfPresent(String.self, forKey: .prefix) ?? ""
        self.suffix = try container.decodeIfPresent(String.self, forKey: .suffix) ?? ""
    }

    init(prefix: String, suffix: String) {
        self.prefix = prefix
        self.suffix = suffix
    }
}

extension PlaceImage {
    var urlString: String {
        "\(self.prefix)original\(self.suffix)"
    }
}

extension PlaceImage: Equatable {}
