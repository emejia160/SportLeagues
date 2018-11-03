//
//  Encodable.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation

extension Encodable {
    
    func asDictionary()  -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return dictionary as? [String: Any]
        } catch {
            print("PARSER ERROR: \(error.localizedDescription)")
            return [String: Any]()
        }
    }
    
}

extension Decodable {
    
    static func toModel<T>(data: Any) -> T? where T: Decodable {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: jsonData)
            return model
        } catch {
            print("PARSER ERROR: \(error.localizedDescription)")
            return nil
        }
    }
}
