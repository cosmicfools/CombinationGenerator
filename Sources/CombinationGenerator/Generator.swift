//
//  Generator.swift
//  Pods
//
//  Created by Francisco Javier Trujillo Mata on 19/06/2019.
//

import Runtime

open class Generator<T: Any> {
    private var info = try? typeInfo(of: T.self)
    private var combinations: [String: [Any]] = [:]
    private var objectCombinations: [[String: Any]] = []
    
    public init() {} // Needed to be accesible outside
    
    open func addCombination(propertyKey: String, values: [Any])  {
        combinations[propertyKey] = values
    }
    
    open func generateCombinations() -> [T] {
        if let nextProp = nextProperty(property: nil) {
            populateCombinations(currentCombinations: [String: Any](), property: nextProp)
        }
        
        return generateObjectsCombinations()
    }
}

// MARK: - Private Methods
private extension Generator {
    func nextProperty(property: PropertyInfo?) -> PropertyInfo? {
        let keys = combinations.keys.sorted()
        var currentKey: String?
        var nextProp: PropertyInfo?
        var index: Int = -1
        
        if  let property = property,
            let newIndex = keys.firstIndex(of: property.name) {
            index = newIndex
            currentKey = keys[index]
        }
        
        if (currentKey != keys.last) {
            let nextPropName = keys[index+1]
            nextProp = try? info?.property(named: nextPropName)
        }
        
        return nextProp
    }
    
    func populateCombinations(currentCombinations: [String: Any], property: PropertyInfo) {
        let valuesForProperty: [Any] = combinations[property.name] ?? []
        let nextProp = nextProperty(property: property)
        
        valuesForProperty.forEach {
            var newCombinations = currentCombinations
            newCombinations[property.name] = $0
            
            if let nextProp = nextProp {
                populateCombinations(currentCombinations: newCombinations, property: nextProp)
            } else {
                objectCombinations.append(newCombinations)
            }
        }
    }
    
    func generateObjectsCombinations() -> [T] {
        let generated = objectCombinations.reduce(into: [T]()) {
            guard var option = try? createInstance(of: T.self) as? T else { return }
            
            $1.forEach { (key, value) in
                let property = try? info?.property(named: key)
                try? property?.set(value: value, on: &option)
            }
            
            $0.append(option)
        }
        
        objectCombinations = [] // Clean  array to save memoery space
        
        return generated
    }
}
