//
//  APIService.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 12/11/2021.
//

import Foundation

struct APIService {
    
    // MARK: - Movies

    static func getMovie(with apiManager: APIManager, _ page: Int = 1, _ completion: @escaping ([NewFeedMovie]?) -> ()) {
        let params: [String: Any] = ["api_key": Constants.apiKey, "page": page]
        
        APIController.request(ResponsePaging<NewFeedMovie>.self, apiManager, params: params) { error, data in
            if let movies = data?.results {
                completion(movies)
                return
            }
            completion(nil)
            print("Lỗi get Movie")
        }
    }
    
    static func requestGetDetailMovie(with movieId: Int, _ completion: @escaping(DetailMovie?) -> ()) {
        let params: [String: Any] = ["api_key": Constants.apiKey]
        
        APIController.request(DetailMovie.self, .detailMovie(movieId), params: params) { error, data in
            if let detailMovies = data {
                completion(detailMovies)
                return
            }
            completion(nil)
            print("Lỗi get Detail Movie")
        }
    }
    
    static func requestCastsMovie(with movieId: Int, _ completion: @escaping([CastMovie]?) -> ()) {
        let params: [String: Any] = ["api_key": Constants.apiKey]
        
        APIController.request(CastsMovie.self, .castsMovie(movieId), params: params) { error, data in
            if let castsMovie = data?.cast {
                completion(castsMovie)
                return
            }
            completion(nil)
            print("Lỗi get Casts Movie")
        }
    }
    
    static func requestWatchMovie(with movieId: Int, _ completion: @escaping([WatchMovie]?) -> ()) {
        let params: [String: Any] = ["api_key": Constants.apiKey]
        
        APIController.request(WatchMovies.self, .watchMovie(movieId), params: params) { error, data in
            if let watchMovie = data?.results {
                completion(watchMovie)
                return
            }
            completion(nil)
            print("Lỗi get Watch Movie")
        }
    }
    
    static func requestToken(_ completion: @escaping(Token?) -> ()) {
        let params: [String: Any] = ["api_key": Constants.apiKey]
        
        APIController.request(Token.self, .getToken, params: params) { error, data in
            if let token = data {
                print(token)
                completion(token)
                return
            }
            completion(nil)
            print("Lỗi request Token")
        }
    }
    
    static func requestSessionWithLogin(username username: String, password password: String, token requestToken: String , _ completion: @escaping(Token?) -> ()) {
        
        let params: [String: Any] = ["username": username, "password": password, "request_token": requestToken]
        
        APIController.request(Token.self, .sessionWithLogin, params: params) { error, data in
            if let token = data {
                print(token)
                completion(token)
                return
            }
            completion(nil)
            print("Lỗi request Session With Login")
        }
    }
    
    static func requestSession(token requestToken: String , _ completion: @escaping(Session?) -> ()) {
        
        let params: [String: Any] = ["request_token": requestToken]
        
        APIController.request(Session.self, .sessionID, params: params) { error, data in
            if let session = data, let sessionId = session.sessionId {
                print(session)
                UserService.shared.setSessionID(with: sessionId)
                //Luu Data vao UserService
                completion(session)
                return
            }
            completion(nil)
            print("Lỗi get sessionID")
        }
    }
    
    static func maskFavoriteMovie(movieID: Int, isFavorite: Bool, _ completion: @escaping(MaskFavoriteMovie?) -> ()) {
    
        let params: [String: Any] = ["media_type": "movie", "favorite": isFavorite, "media_id": movieID]
        let accountID = UserService.shared.getAccountID()
        let sessionID = UserService.shared.getSessionID()
        print("Param maskFavoriteMovie: \(params)")
        APIController.request(MaskFavoriteMovie.self, .maskFavoriteMovie(accountID, sessionID), params: params) { error, data in
            if let data = data {
                completion(data)
                return
            }
            completion(nil)
            print("Lỗi mask Favorite Movie")
        }
    }
    
    static func requestFavoriteMovie(_ page: Int = 1, _ completion: @escaping ([NewFeedMovie]?) -> ()) {
        let params: [String: Any] = ["page": page]
        let accountID = UserService.shared.getAccountID()
        let sessionID = UserService.shared.getSessionID()
        APIController.request(ResponsePaging<NewFeedMovie>.self, .getFavoriteMovie(accountID, sessionID), params: params) { error, data in
            if let movies = data?.results {
                completion(movies)
                return
            }
            completion(nil)
            print("Lỗi get Favorite Movie")
        }
    }
    
    static func requestDetailAccount(completion: @escaping(String?,DetailAccount?) ->()) {
        let sessionID = UserService.shared.getSessionID()
        let params: [String: Any] = ["session_id": sessionID]
        
        APIController.request(DetailAccount.self, .detailAccount, params: params) { error, data in
            if let detailAccount = data, let accountID = detailAccount.id {
                print(detailAccount)
                UserService.shared.setAccountID(with: accountID)
                completion(nil,detailAccount)
                return
            }
            completion(error,nil)
            print("Lỗi get Detail Account")
            
        }
    }
}
