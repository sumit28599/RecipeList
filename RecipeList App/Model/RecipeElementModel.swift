//
//  RecipeElementModel.swift
//  RecipeList App
//
//  Created by Mac on 24/01/25.
//

import Foundation

struct RecipeElement: Codable {
    let id: Int
    let name: String
    let ingredients, instructions: [String]
    let cuisine: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, name, ingredients, instructions,  cuisine
        case image
    }
}
