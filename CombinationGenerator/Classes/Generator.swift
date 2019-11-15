//
//  Generator.swift
//  Pods
//
//  Created by Francisco Javier Trujillo Mata on 19/06/2019.
//

import UIKit
import Runtime

open class Generator<T: Any> {
    private var combinations: [(Any, [Any])] = []
    
    public init() {} // Needed to be accesible outside
    
    open func addCombination<TparamType>(keyPath: WritableKeyPath<T, TparamType?>, values: [Any])  {
        combinations.append((keyPath, values))
    }
    
    open func generateCombinations() -> [T] {
        let objectCombinations = combinations.map { populateCombinations(keyPath: $0.0, values: $0.1) }
        return generateObjectsCombinations(objectCombinations)
    }
}

private extension Generator {
    func populateCombinations<Tkey, Tvalue>(keyPath: Tkey, values:[Tvalue]) -> [(Tkey, Tvalue)] {
        return values.map { (keyPath, $0) }
    }
    
    func populateCombinations(currentCombinations: [String: Any], property: Any?) {
        let valuesForProperty: [Any] = combinations[property.name] ?? []
        let nextProp = nextProperty(property: property)
        for value in valuesForProperty {
            var newCombinations = currentCombinations
            newCombinations[property.name] = value
            
            if let nextProp = nextProp {
                populateCombinations(currentCombinations: newCombinations, property: nextProp)
            } else {
                objectCombinations.append(newCombinations)
            }
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
