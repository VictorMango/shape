//
//  Results.swift
//  API
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation

public struct Results<T: Codable>: Codable {
    public let results: T
}
