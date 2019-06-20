//
//  UserInfo.swift
//  CombinationGenerator_Example
//
//  Created by Francisco Javier Trujillo Mata on 19/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

enum Gender {
    case male
    case female
}

class UserInfo: NSObject {
    var name: String?
    var surname: String?
    var age: Int?
    var gender: Gender?
}
