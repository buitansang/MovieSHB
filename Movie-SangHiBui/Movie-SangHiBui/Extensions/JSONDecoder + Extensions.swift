//
//  JSONDecoder + Extensions.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 08/11/2021.
//

import Foundation
import UIKit

extension JSONDecoder {
    
    static func decode<T: Decodable>(_ type: T.Type, from data: Data?, completion: @escaping (_ error: String?,_ result: T?) -> Void) {
        
        guard let data = data else {
            completion("The data couldn't be read because it is missing", nil)
            return
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try jsonDecoder.decode(type, from: data)
            completion(nil, result)
        } catch (let error) {
            completion(error.localizedDescription, nil)
        }
        
    }
    
}

// Phần tử cuối mảng
extension Array {
    var last: Element {
        return self[self.endIndex - 1]
    }
}


// Trả về số hàng lớn nhất có thể của text Label
extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}


