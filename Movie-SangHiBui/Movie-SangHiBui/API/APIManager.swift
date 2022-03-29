//
//  APIManager.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 08/11/2021.
//

import Alamofire

enum APIManager {
    
    case popularMovie
    case topRatedMovie
    case detailMovie(Int)
    case castsMovie(Int)
    case watchMovie(Int)
    case getToken
    case sessionID
    case sessionWithLogin
    case maskFavoriteMovie(Int, String)
    case detailAccount
    case getFavoriteMovie(Int, String)
    
}

extension APIManager {
    
    static let apiKey = "4e9fd5825f9681d9114e1bb1163875e9"
    
    //https://api.themoviedb.org/3/person/popular?api_key=ee8cf966d22254270f6faa1948ecf3fc&language=en-US&page=1
    
    //https://api.themoviedb.org/3/authentication/token/new?api_key=4e9fd5825f9681d9114e1bb1163875e9
    var baseURL: String { return "https://api.themoviedb.org" }
  
    //MARK: - URL
    
    var url: String {
        
        var path = ""
        var v3 = "/3"
        
        switch self {
            
        case .popularMovie: path = v3 + "/movie/popular"
        case .topRatedMovie: path = v3 + "/movie/top_rated"
        case .detailMovie(let id) : path = v3 + "/movie/\(id)"
        case .castsMovie(let id) : path = v3 + "/movie/\(id)/credits"
        case .watchMovie(let id) : path = v3 + "/movie/\(id)/videos"
        case .getToken: path = v3 + "/authentication/token/new"
        case .sessionID: path = v3 + "/authentication/session/new?api_key=" + Constants.apiKey
        case .sessionWithLogin: path = v3 + "/authentication/token/validate_with_login?api_key=" + Constants.apiKey
        case .maskFavoriteMovie(let accountID, let sessionID): path = v3 + "/account/\(accountID)/favorite?api_key=" + Constants.apiKey + "&session_id=\(sessionID)"
        case .detailAccount: path = v3 + "/account?api_key=" + Constants.apiKey
        case .getFavoriteMovie(let accountID, let sessionID): path = v3 + "/account/\(accountID)/favorite/movies?api_key=" + Constants.apiKey + "&session_id=\(sessionID)"
        }
        
        return baseURL + path
    }
    
    //MARK: - METHOD
    
    var method: HTTPMethod {
        switch self {
        case .popularMovie, .topRatedMovie, .detailMovie, .castsMovie, .watchMovie, .getToken, .detailAccount, .getFavoriteMovie:
            return .get
        case .sessionID, .sessionWithLogin, .maskFavoriteMovie:
            return .post
        }
    }
    
    //MARK: - HEADER
    
    var header: HTTPHeaders? {
        switch self {
        case .maskFavoriteMovie:
            return [Header.contentType : Header.contentTypeValue]
        default:
            return nil
            
        }
    }
    
    //MARK: - ENCODING
    
    var encoding: ParameterEncoding {
        
        switch self.method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}

struct Header {
    
    static let authorization            = "Authorization"
    static let contentType              = "Content-Type"
    static let contentTypeValue         = "application/json"
    
}
