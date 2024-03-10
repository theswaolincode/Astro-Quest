//
//  MediaItemsDomain.swift
//  Astro-Quest
//
//  Created by Daniel Ayala on 10/3/24.
//

import Foundation

@Observable
class AstroItem: Codable, Hashable {
    let id = UUID().uuidString
    var title: String
    var description: String
    var image: String
    
    static func == (lhs: AstroItem, rhs: AstroItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(item: ItemResponse) {
        self.title = item.data?.first?.title ?? ""
        self.description = item.data?.first?.description ?? ""
        self.image = item.links?.first?.href ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case _title = "title"
        case _description = "description"
        case _image = "image"
    }
}

