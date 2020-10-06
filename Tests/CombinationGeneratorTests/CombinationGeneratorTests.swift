import XCTest
@testable import CombinationGenerator

private class UserInfo: Equatable {
    enum Gender: CaseIterable {
        case male
        case female
    }
    
    var name: String?
    var surname: String?
    var age: Int?
    var gender: Gender?
    
    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        lhs.name == rhs.name && lhs.surname == rhs.surname && lhs.age == rhs.age && lhs.gender == rhs.gender
    }
}

final class CombinationGeneratorTests: XCTestCase {
    private let generator = Generator<UserInfo>()
        
    func testEmptyCombinations() {
        let combinations = self.generator.generateCombinations()
        
        XCTAssert(combinations.count == 0, "The number of element must be 0")
    }
    
    func testSingleValueEmptyContent() {
        self.generator.addCombination(propertyKey: "name", values: [])
        
        let combinations = self.generator.generateCombinations()
        
        XCTAssert(combinations.count == 0, "The number of element must be 0")
    }
    
    func testSingleValue() {
        self.generator.addCombination(propertyKey: "name", values: ["Fistrum"])
        
        let combinations = self.generator.generateCombinations()
        
        XCTAssert(combinations.count == 1, "The number of element must be 1")
        let first = combinations.first
        XCTAssert(first?.name == "Fistrum", "The only object create must be named Fistrum")
    }
    
    func testSingleValue2Combination() {
        let mockedFirst = UserInfo()
        mockedFirst.name = "Fistrum"
        mockedFirst.surname = "Rodrigor"
        
        self.generator.addCombination(propertyKey: "name", values: [mockedFirst.name!])
        self.generator.addCombination(propertyKey: "surname", values: [mockedFirst.surname!])
        
        let combinations = self.generator.generateCombinations()
        
        XCTAssert(combinations.count == 1, "The number of element must be 1")
        let first = combinations.first
        
        XCTAssert(mockedFirst == first, "The only object create must with name Fistrum and surname Rodrigor")
    }
    
    func test2Value2Combination() {
        let mockedFirst = UserInfo()
        mockedFirst.name = "Fistrum"
        mockedFirst.surname = "Rodrigor"
        
        let mockedSecond = UserInfo()
        mockedSecond.name = "Fistrum"
        mockedSecond.surname = "Condemor"
        
        let mockedThird = UserInfo()
        mockedThird.name = "Gramenawer"
        mockedThird.surname = "Rodrigor"
        
        let mockedForth = UserInfo()
        mockedForth.name = "Gramenawer"
        mockedForth.surname = "Condemor"
        
        self.generator.addCombination(propertyKey: "name", values: [mockedFirst.name!, mockedThird.name!])
        self.generator.addCombination(propertyKey: "surname", values: [mockedFirst.surname!, mockedSecond.surname!])
        
        let combinations = self.generator.generateCombinations()
        
        XCTAssert(combinations.count == 4, "The number of element must be 4")
        
        XCTAssert(combinations.contains(mockedFirst), "FirstMocked object is not on the generated")
        XCTAssert(combinations.contains(mockedSecond), "SecondMocked object is not on the generated")
        XCTAssert(combinations.contains(mockedThird), "ThirdMocked object is not on the generated")
        XCTAssert(combinations.contains(mockedForth), "MockedForth object is not on the generated")
    }
    
    func testPerformanceGenerateThousandExamples() {
        // This is an example of a performance test case.
        let values = [0...10].reduce(into: ([String](), [Int]())) {
            $0.0.append("Fistrum\($1.description)")
            $0.1.append(contentsOf: $1)
        }
        self.measure() {
            self.generator.addCombination(propertyKey: "name", values: values.0)
            self.generator.addCombination(propertyKey: "surname", values: values.0)
            self.generator.addCombination(propertyKey: "age", values: values.1)
            self.generator.addCombination(propertyKey: "gender", values: UserInfo.Gender.allCases)
            _ = self.generator.generateCombinations()
        }
    }
    
    func testGenerateCombinations() {
        let names = ["Francisco", "Tete", "MadMoc", "Pableras"]
        let surnames = ["Molon", "Nadal", "Singular", "Reyes"]
        let ages =  [18, 33, 40, 30, 12, 20]
        let genders = UserInfo.Gender.allCases
        let generator = Generator<UserInfo>()
        generator.addCombination(propertyKey: "name", values: names)
        generator.addCombination(propertyKey: "surname", values: surnames)
        generator.addCombination(propertyKey: "age", values: ages)
        generator.addCombination(propertyKey: "gender", values: genders)
        
        let possibilities = generator.generateCombinations()
        let options: [[Any]] = [names, surnames, ages, genders]
        let expectedCombinations = options.reduce(into: 1) { $0 *= $1.count }
        XCTAssert(possibilities.count == expectedCombinations, "All possible combinations weren't generated")
    }

    static var allTests = [
        ("testEmptyCombinations", testEmptyCombinations),
        ("testSingleValueEmptyContent", testSingleValueEmptyContent),
        ("testSingleValue", testSingleValue),
        ("testSingleValue2Combination", testSingleValue2Combination),
        ("test2Value2Combination", test2Value2Combination),
        ("testPerformanceGenerateThousandExamples", testPerformanceGenerateThousandExamples),
        ("testGenerateCombinations", testGenerateCombinations),
    ]
}
