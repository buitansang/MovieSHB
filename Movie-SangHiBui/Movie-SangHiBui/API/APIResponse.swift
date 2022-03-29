//
//  APIResponse.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 08/11/2021.
//

import Foundation

struct ResponsePaging<T: Decodable>: Decodable {
    var page: Int?
    var results: [T]?
    var totalPages: Int?
    var totalResults: Int?
}
