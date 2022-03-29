//
//  UserService.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 09/01/2022.
//

import Foundation

class UserService {
    static let shared = UserService()
    
    private var sessionID: String?
    private var accountID: Int?
    
    func setSessionID(with ID: String) {
        UserDefaults.standard.set(ID, forKey: "UserService_Session_ID")
        self.sessionID = ID
    }
    
    func setAccountID(with ID: Int) {
        UserDefaults.standard.set(ID, forKey: "UserService_Account_ID")
        self.accountID = ID
    }
    
    func getSessionID() -> String {
        guard let sessionID = self.sessionID else {
            return ""
        }
        return sessionID
    }
    
    func getAccountID() -> Int {
        guard let accountID = self.accountID else {
            return -1
        }
        return accountID
    }
    
    func removeData() {
        sessionID = nil
        accountID = nil
        UserDefaults.standard.removeObject(forKey: "UserService_Session_ID")
        UserDefaults.standard.removeObject(forKey: "UserService_Account_ID")
    }
}
