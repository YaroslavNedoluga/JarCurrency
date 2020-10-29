//
//  ObservableType.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation
import RxAlamofire
import RxSwift

extension ObservableType {
    
    public func decodeDataObject<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data as! Data)
                return Observable.just(object)
            } catch {
                throw NSError(
                    domain: "com.daoflowers",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
        }
    }
    
    public func decodeDataArray<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            do {
                let decoder = JSONDecoder()
                let objects = try decoder.decode([T].self, from: data as! Data)
                return Observable.just(objects)
            } catch {
                throw NSError(
                    domain: "com.daoflowers",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
        }
    }

}
