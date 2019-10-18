import XCTest
import CombinationGenerator

private  enum Gender {
    case male
    case female
}

private class UserInfo: NSObject {
    var name: String?
    var surname: String?
    var age: Int?
    var gender: Gender?
    
    func isEqual(_ object: UserInfo?) -> Bool {
        return name == object?.name &&
            surname == object?.surname &&
            object?.age == age &&
            object?.gender == gender
    }
}

class Tests: XCTestCase {
    private let generator = Generator<UserInfo>()
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    fileprivate func isIncluded(_ user: UserInfo, elements: [UserInfo]) -> Bool {
        var res = false
        
        for currentUser in elements {
            if currentUser.isEqual(user) {
                res = true
                break
            }
        }
        
        return res
    }
    
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
        
        XCTAssert(mockedFirst.isEqual(first), "The only object create must with name Fistrum and surname Rodrigor")
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
        
        XCTAssert(isIncluded(mockedFirst, elements: combinations), "FirstMocked object is not on the generated")
        XCTAssert(isIncluded(mockedSecond, elements: combinations), "SecondMocked object is not on the generated")
        XCTAssert(isIncluded(mockedThird, elements: combinations), "ThirdMocked object is not on the generated")
        XCTAssert(isIncluded(mockedForth, elements: combinations), "MockedForth object is not on the generated")
    }
    
    func testPerformanceGenerateThousandExamples() {
        // This is an example of a performance test case.
        var stringValues: [String] = []
        var integerValues: [Int] = []
        for index in 0...10 {
            stringValues.append("Fistrum" + index.description)
            integerValues.append(index)
        }
        self.measure() {
            self.generator.addCombination(propertyKey: "name", values: stringValues)
            self.generator.addCombination(propertyKey: "surname", values: stringValues)
            self.generator.addCombination(propertyKey: "age", values: integerValues)
            self.generator.addCombination(propertyKey: "gender", values: [Gender.female, Gender.male])
            _ = self.generator.generateCombinations()
        }
    }
    
}
