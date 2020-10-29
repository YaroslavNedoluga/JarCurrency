//
//  ExJSON.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation

extension JSONEncoder {
    
    func encodeOrNil<T>(_ value: T) -> Data? where T : Encodable {
        do {
            let jsonData = try self.encode(value)
            return jsonData
        } catch {
            let _ = error as NSError
//            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
}

extension JSONDecoder {
    
    func decodeOrNil<T>(_ type: T.Type, from data: Data?) -> T? where T : Decodable {
        guard let data = data else { return nil }
        do {
            let data = try self.decode(type, from: data)
            return data
        } catch {
            let _ = error as NSError
//            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    
}
