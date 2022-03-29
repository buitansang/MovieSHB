//
//  WatchMovie.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 25/11/2021.
//

import Foundation

struct WatchMovies: Decodable {
    var id: Int?
    var results: [WatchMovie]
}

struct WatchMovie: Decodable {
    var key: String?
    var name: String?
    var type: String?
}

