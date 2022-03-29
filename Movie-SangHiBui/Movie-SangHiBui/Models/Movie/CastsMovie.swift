//
//  CastMovie.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 24/11/2021.
//

import Foundation

struct CastsMovie: Decodable {
    var cast: [CastMovie]?
}

struct CastMovie: Decodable {
    var originalName: String?
    var profilePath: String?
    
    func getprofilePath() -> String {
        guard let profilePath = profilePath else {
            return ""
        }
        
        return Constants.baseURLPathImage + profilePath
    }
}
