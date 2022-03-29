//
//  NewFeedMovie.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 08/11/2021.
//

import Foundation

struct NewFeedMovie: Decodable {
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    func getPosterImage() -> String {
        guard let posterPath = posterPath else {
            return ""
        }
        
        return Constants.baseURLPathImage + posterPath
    }
}
