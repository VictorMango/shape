//
//  Movie.swift
//  Entities
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation

public struct Movie: Codable {
    public let id: Int
    public let title: String
    public let overview: String
    public let original_language: String
    public let release_date: String
    public let genre_ids: [Int]
    public var poster_path: String?
}
