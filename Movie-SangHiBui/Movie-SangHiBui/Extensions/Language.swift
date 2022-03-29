//
//  Language.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 16/01/2022.
//

import Foundation

enum Language: Equatable {
    case english
    case vietnamese
}

extension Language {

    var code: String {
        switch self {
        case .english: return "en"
        case .vietnamese: return "vi"
        }
    }
    
    var name: String {
        switch self {
        case .english: return "English"
        case .vietnamese:  return "Việt Nam"
        }
    }
}

extension Language {

    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {

        case "en": self = .english
        case "vi": self = .vietnamese
        default: return nil
            
        }
    }
}
