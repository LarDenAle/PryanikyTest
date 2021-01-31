//
//  PryanikyData.swift
//  PryanikyTest
//
//  Created by Denis Larin on 31.01.2021.
//

import Foundation

struct Pryaniky: Decodable {
    let data: [DataArray]
    let view: [String]
    
}

struct DataArray: Codable {
    let name: String
    let data: DataStruct
}


struct DataStruct: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variants]?

    enum CodingKeys: String, CodingKey {
        case text
        case url
        case selectedID = "selectedId"
        case variants
    }
}

struct Variants: Codable {
    let id: Int?
    let text: String?
}
