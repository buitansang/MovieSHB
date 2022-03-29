//
//  APIController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 08/11/2021.
//

import UIKit
import Alamofire
import Foundation

typealias ResponseClosure<T: Decodable> = (_ error: String?,_ data: T?) -> Void

struct APIController {
    
    static func request<T: Decodable>(_ responseType: T.Type, _ url: String, method: HTTPMethod, completion: @escaping ResponseClosure<T>) {
        
        AF.request(url, method: method).responseData { responseData in
            switch responseData.result {
            case .success(let data):
                if let dataResult = try? JSONDecoder().decode(responseType, from: data) {
                    completion(nil, dataResult)
                    return
                }
                
                completion("Không có dữ liệu", nil)
            case .failure(let error):
                completion(error.localizedDescription, nil)
                return
            }
        }
        
    }
    
    static func request<T: Decodable>(_ responseType: T.Type, _ manager: APIManager, params: Parameters? = nil, completion: @escaping ResponseClosure<T>) {
        
        print("URL REQUEST: \(manager.url)")
        
        AF.request(manager.url, method: manager.method, parameters: params).responseData { responseData in
            switch responseData.result {
            case .success(let data):
                JSONDecoder.decode(responseType, from: data, completion: { (error, response) in
                    completion(error, response)
                })
            case .failure(let error):
                completion(error.localizedDescription, nil)
                return
            }
        }
    }
}



struct Person: Decodable {
    var adult: Bool?
    var gender: Int?
}
