//
//  DetailAccount.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 26/12/2021.
//

import Foundation

struct DetailAccount: Decodable {
    var avatar: Avatar?
    var id: Int?
    var name: String?
    var username: String?
    
    func getAvatarImage() -> String {
        guard let avatarPath = avatar?.tmdb?.avatarPath else {
            return ""
        }
        
        return Constants.baseURLPathImage + avatarPath
    }
}

struct Avatar: Decodable {
    var gravatar: Gravatar?
    var tmdb: Tmdb?
}

struct Gravatar: Decodable {
    var hash: String?
}

struct Tmdb: Decodable {
    var avatarPath: String?
}
