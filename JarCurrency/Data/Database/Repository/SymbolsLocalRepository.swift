//
//  SymbolsLocalRepository.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation
import Alamofire
import RxSwift
import CoreData

protocol SymbolsLocalRepository {
    func getSymbols() -> Observable<DbSymbols?>
    func saveOrUpdateSymbols(jsonData: String, _ symbols: DbSymbols?) -> Completable
}

final class SymbolsLocalRepositoryImpl: SymbolsLocalRepository {
    private let dataManager = CoreDataManager.instance

    func getSymbols() -> Observable<DbSymbols?> {
        let request: NSFetchRequest<NSFetchRequestResult> = {
            $0.predicate = NSPredicate(format: "id == %@", String(1))
            return $0
        }(NSFetchRequest<NSFetchRequestResult>(entityName: "DbSymbols"))
        
        do {
            guard let results = try dataManager.managedObjectContext.fetch(request) as? [DbSymbols], !results.isEmpty else { return Observable.just(nil) }
            return Observable.just(results.last)
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            return Observable.just(nil)
        }
    }
    
    func saveOrUpdateSymbols(jsonData: String, _ symbols: DbSymbols?) -> Completable {
        let currentTime = Date().toMillis()!
        if let symbols = symbols { symbols.update(time: currentTime, json: jsonData) }
        else { let _ = DbSymbols(time: currentTime, json: jsonData) }
        
        return dataManager.saveContextCompletable()
    }
}

