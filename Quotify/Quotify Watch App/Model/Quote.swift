//
//  Quote.swift
//  Quotify Watch App
//
//  Created by Anuza Simkhada on 12/05/2024.
//

import Foundation

struct Quote: Codable, Hashable {
    let quote: String
    let author: String
    let category: String
}
