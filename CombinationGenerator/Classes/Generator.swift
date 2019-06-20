//
//  Generator.swift
//  Pods
//
//  Created by Francisco Javier Trujillo Mata on 19/06/2019.
//

import UIKit
import Runtime

open class Generator: NSObject {
    private var baseClass: NSObject.Type
    private var info: TypeInfo?
    private var combinations: Dictionary<String, [Any]>
    private var objectCombinations: [Dictionary<String, Any>]
    
    public init(baseClass: NSObject.Type) {
        self.baseClass = baseClass
        self.combinations = Dictionary<String, [Any]>()
        self.objectCombinations = [Dictionary<String, Any>]()
        
        do {
            self.info = try typeInfo(of: baseClass)
        } catch {}
        
        super.init()
    }
    
    open func addCombination(propertyKey: String, values: [Any])  {
        combinations[propertyKey] = values
    }
    
    open func generateCombinations() -> [NSObject] {
        
        let nextProp = nextProperty(property: nil)  ?? nil
        if nextProp != nil {
            populateCombinations(currentCombinations: Dictionary<String, Any>(), property: nextProp!)
        }
        
        return generateObjectsCombinations()
    }
    
    private func nextProperty(property: PropertyInfo?) -> PropertyInfo? {
        let keys = Array(combinations.keys.sorted())
        var currentKey: String? = nil
        var nextProp: PropertyInfo? = nil
        var index: NSInteger = -1
        
        if (property != nil) {
            index = keys.firstIndex(of: property!.name)!
            currentKey = keys[index]
        }
        
        if (currentKey != keys.last) {
            let nextPropName = keys[index+1]
            do {
                nextProp = try info!.property(named: nextPropName)
            } catch {}
        }
        
        return nextProp
    }
    
    private func populateCombinations(currentCombinations: Dictionary<String, Any>, property: PropertyInfo) {
        let valuesForProperty: [Any] = combinations[property.name] ?? []
        let nextProp = nextProperty(property: property)
        for value in valuesForProperty {
            var newCombinations = currentCombinations
            newCombinations[property.name] = value
            
            if (nextProp != nil) {
                populateCombinations(currentCombinations: newCombinations, property: nextProp!)
            } else {
                objectCombinations.append(newCombinations)
            }
        }
    }
    
    private func setKeyValue(key: String, value: Any, inObject: Any) -> Any {
        var currentObject = inObject
        do {
            let property = try info!.property(named: key)
            try property.set(value: value, on: &currentObject)
        } catch {}
        
        return currentObject
    }
    
    private func generateSingleObject(values: Dictionary<String, Any>) -> NSObject {
        var result: NSObject
        do {
            var option = try createInstance(of: baseClass)
            
            values.forEach { (key, value) in
                option = setKeyValue(key: key, value: value, inObject: option)
            }
            result = option as! NSObject
        } catch {
            result = baseClass.init()
        }
        
        objectCombinations = [Dictionary<String, Any>]()
        
        return result
    }
    
    private func generateObjectsCombinations() -> [NSObject] {
        return objectCombinations.compactMap{ singleCombination in generateSingleObject(values: singleCombination)}
    }
}
