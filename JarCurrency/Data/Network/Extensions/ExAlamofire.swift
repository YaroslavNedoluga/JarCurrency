//
//  ExAlamofire.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation
import RxSwift
import Alamofire

public func requestAlamofire(url: String, urlQueryItems: [URLQueryItem]? = nil, httpMethod: String) -> Observable<Data?> {
    let urlComponents = NSURLComponents(string: url)!
    
    if let urlQueryItems = urlQueryItems { urlComponents.queryItems = urlQueryItems }
    else { urlComponents.queryItems = [URLQueryItem(name: "access_key", value: NetworkManager.getAPIKey())] }
    
    var urlRequest = URLRequest(url: urlComponents.url!)
    urlRequest.httpMethod = httpMethod

    return Observable.create({ (observer) -> Disposable in
        let request = Alamofire.request(urlRequest).responseData{ (responseData) in
            switch (responseData.result){
            case .success(_):
                if let statusCode = responseData.response?.statusCode, statusCode == 200 || statusCode == 201 {
                    observer.onNext(responseData.data)
                    observer.onCompleted()
                } else { observer.onError(NSError(domain: "com.jarCurrency", code: -1, userInfo: [NSLocalizedDescriptionKey: "error response success statusCode \(responseData.response?.statusCode ?? -1)"])) }
                break
            case .failure(_):
                observer.onError(NSError(domain: "com.jarCurrency", code: -1, userInfo: [NSLocalizedDescriptionKey: "error response .failure"]))
                break
            }
        }
        
        return Disposables.create {
            request.cancel()
        }
    })

}
