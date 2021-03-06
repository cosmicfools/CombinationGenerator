# CombinationGenerator

![CI](https://github.com/cosmicfools/CombinationGenerator/workflows/CI/badge.svg)
![CIContainer](https://github.com/cosmicfools/CombinationGenerator/workflows/CIContainer/badge.svg)
[![Version](https://img.shields.io/cocoapods/v/CombinationGenerator.svg?style=flat)](http://cocoapods.org/pods/CombinationGenerator)
[![License](https://img.shields.io/cocoapods/l/CombinationGenerator.svg?style=flat)](http://cocoapods.org/pods/CombinationGenerator)
[![Platform](https://img.shields.io/cocoapods/p/CombinationGenerator.svg?style=flat)](http://cocoapods.org/pods/CombinationGenerator)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/fjtrujy/CombinationGenerator)](http://clayallsopp.github.io/readme-score?url=https://github.com/fjtrujy/CombinationGenerator)

## Overview

CombinationGenerator basically is a helper that use brute-force to generate all possibilities for a concrete DataModel given a list of possible values per property. CombinationGenerator use Generics, so it makes your life even easier.

## Requirements

Is valid for iOS 9 and higher.
Requires Swift 5.2 and XCode 11.0 or higher.

## Installation

### Swift Package Manager

You can install CombinationGenerator via [Swift Package Manager](https://swift.org/package-manager/) by adding the following line to your `Package.swift`:

```swift
import PackageDescription

let package = Package(
    [...]
    dependencies: [
        .Package(name: "CombinationGenerator", url: "https://github.com/cosmicfools/CombinationGenerator.git", .branch("master"))
    ]
)
```

### Cocoapods

You can install CombinationGenerator via [Cocoapods](https://cocoapods.org/) by adding the following line to your `Podfile`:

```ruby
pod 'CombinationGenerator'
```

In case that you still want to see here how it works, keep reading :)

An example used to be easier to understand than 1000 words.. so:

#### 1. Import CombinationGenerator

```swift
import CombinationGenerator
```

#### 2. Create your Data model

```swift
class UserInfo {
    var name: String?
    var surname: String?
    var age: Int?
}
```

#### 3. Instanciate, add combination and generate all the possibilities

```swift
let generator = Generator<UserInfo>()
generator.addCombination(propertyKey: "name", values: ["Tete", "MadMoc", "Pableras", "Trujy"])
generator.addCombination(propertyKey: "surname", values: ["Molon", "Singular", "Friendly"])
generator.addCombination(propertyKey: "age", values: [18, 33, 40])


let possibilities = generator.generateCombinations()
```

#### 4. Results:

In the previous example if we want to see the generated object we can do:

```swift
possibilities.forEach { print($0.name!, $0.surname!, $0.age!.description, $0.gender.debugDescription) }
```

And the received output:

```swift
Tete Molon 18
Tete Singular 18
Tete Friendly 18
MadMoc Molon 18
MadMoc Singular 18
MadMoc Friendly 18
Pableras Molon 18
Pableras Singular 18
Pableras Friendly 18
Trujy Molon 18
Trujy Singular 18
Trujy Friendly 18
Tete Molon 33
Tete Singular 33
Tete Friendly 33
MadMoc Molon 33
MadMoc Singular 33
MadMoc Friendly 33
Pableras Molon 33
Pableras Singular 33
Pableras Friendly 33
Trujy Molon 33
Trujy Singular 33
Trujy Friendly 33
Tete Molon 40
Tete Singular 40
Tete Friendly 40
MadMoc Molon 40
MadMoc Singular 40
MadMoc Friendly 40
Pableras Molon 40
Pableras Singular 40
Pableras Friendly 40
Trujy Molon 40
Trujy Singular 40
Trujy Friendly 40
```

![Well Done!](https://raw.githubusercontent.com/fjtrujy/CombinationGenerator/master/wellDone.gif)

## Author

Francisco Javier Trujillo Mata, fjtrujy@gmail.com

## License

CombinationGenerator is available under the MIT license. See the LICENSE file for more info.
