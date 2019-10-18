//
//  ViewController.swift
//  CombinationGenerator
//
//  Created by Francisco Javier Trujillo Mata on 06/19/2019.
//  Copyright (c) 2019 Francisco Javier Trujillo Mata. All rights reserved.
//

import UIKit
import CombinationGenerator

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let generator = Generator<UserInfo>()
        generator.addCombination(propertyKey: "name", values: ["Francisco", "Tete", "MadMoc", "Pableras"])
        generator.addCombination(propertyKey: "surname", values: ["Molon", "Nadal", "Singular", "Reyes"])
        generator.addCombination(propertyKey: "age", values: [18, 33, 40, 30, 12, 20])
        generator.addCombination(propertyKey: "gender", values: [UserInfo.Gender.female, UserInfo.Gender.male])
        
        let possibilities = generator.generateCombinations()
        possibilities.forEach { print($0.name!, $0.surname!, $0.age!.description, $0.gender.debugDescription) }
    }
    
}

