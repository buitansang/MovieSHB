//
//  DetailMovie.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 18/11/2021.
//

import Foundation

struct DetailMovie: Decodable {
    var adult: Bool?
    var backdropPath: String?
    var originalTitle: String?
    var overview: String?
    var productionCompanies: [Companies]?
    var genres: [Genres]?
    var posterPath: String?
    var releaseDate: String?
    var voteAverage: Double?
    
    func getBackdropPath() -> String {
        guard let backdropPath = backdropPath else {
            return ""
        }
        
        return Constants.baseURLPathImage + backdropPath
    }
}

struct Companies: Decodable {
    var id: Int?
    var logoPath: String?
    var name: String?
    var originCountry: String?
}

struct Genres: Decodable {
    var id: Int?
    var name: String?
}


