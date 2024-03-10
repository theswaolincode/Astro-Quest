//
//  MediaItemsResponse.swift
//  Astro-Quest
//
//  Created by Daniel Ayala on 10/3/24.
//

import Foundation

// MARK: - Welcome
struct MediaItemsResponse: Codable {
    let collection: CollectionResponse?
}

// MARK: - Collection
struct CollectionResponse: Codable {
    let version: String?
    let href: String?
    let items: [ItemResponse]?
    let metadata: MetadataResponse?
    let links: [CollectionLinkResponse]?
}

// MARK: - Item
struct ItemResponse: Codable {
    let href: String?
    let data: [DatumResponse]?
    let links: [ItemLinkResponse]?
}

// MARK: - Datum
struct DatumResponse: Codable {
    let center, title: String?
    let keywords: [String]?
    let nasaID: String?
    let dateCreated: String?
    let mediaType, description: String?

    enum CodingKeys: String, CodingKey {
        case center, title, keywords
        case nasaID = "nasa_id"
        case dateCreated = "date_created"
        case mediaType = "media_type"
        case description
    }
}

// MARK: - ItemLink
struct ItemLinkResponse: Codable {
    let href: String?
    let rel, render: String?
}

// MARK: - CollectionLink
struct CollectionLinkResponse: Codable {
    let rel, prompt: String?
    let href: String?
}

// MARK: - Metadata
struct MetadataResponse: Codable {
    let totalHits: Int?

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}
