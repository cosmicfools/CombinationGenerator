//
//  Generator.swift
//  Pods
//
//  Created by Francisco Javier Trujillo Mata on 19/06/2019.
//

import UIKit
import Runtime

open class Generator<T: Any> {
    private var info = try? typeInfo(of: T.self)
    private var combinations: [ReferenceWritableKeyPath<T, Any?>: [Any]] = [:]
    
    public init() {} // Needed to be accesible outside
    
    open func addCombination<TpropertyType: Any>(keyPath: ReferenceWritableKeyPath<T, TpropertyType?>, values: [Any])  {
        combinations[keyPath] = values
    }
    
    open func generateCombinations() -> [T] {
        let objectCombinations = combinations.map { populateCombinations(keyPath: $0, values: $1) }
        return generateObjectsCombinations(objectCombinations)
    }
}

private extension Generator {
    func populateCombinations<Tkey, Tvalue>(keyPath: Tkey, values:[Tvalue]) -> [Tkey: Tvalue] {
        return values.reduce([:]) { (dict, value) -> [Tkey: Tvalue] in
            var dict = dict
            dict[keyPath] = value
            return dict
        }
    }
    
    func generateObjectsCombinations(_ objectCombinations: [[ReferenceWritableKeyPath<T, Any?>: Any]]) -> [T] {
        var generated = [T]()
        
        for singleCombination in objectCombinations {
            guard let option = try? createInstance(of: T.self) as? T else { continue }
            
            for (key, value) in singleCombination {
                option[keyPath: key] = value
            }
            
            generated.append(option)
        }
        
        return generated
    }
}
