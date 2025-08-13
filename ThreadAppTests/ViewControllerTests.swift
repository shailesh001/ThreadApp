import XCTest
@testable import ThreadApp

/// Unit tests for ViewController's data and calculation methods.
class ViewControllerTests: XCTestCase {
    var viewController: ViewController!

    override func setUp() {
        super.setUp()
        // Instantiate ViewController from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        // Load the view hierarchy
        _ = viewController.view
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testFetchSomethingFromServer() {
        let result = viewController.fetchSomethingFromServer()
        XCTAssertEqual(result, "Hi there")
    }

    func testProcessData() {
        let input = "hello"
        let result = viewController.processData(input: input)
        XCTAssertEqual(result, "HELLO")
    }

    func testCalculateFirstResult() {
        let input = "HELLO"
        let result = viewController.calculateFirstResult(input)
        XCTAssertTrue(result.contains("Number of chars: 5"))
    }

    func testCalculateSecondResult() {
        let input = "HELLO"
        let result = viewController.calculateSecondResult(input)
        XCTAssertEqual(result, "HELLO") // No 'E' in uppercase, so remains the same
        let input2 = "HEE"
        let result2 = viewController.calculateSecondResult(input2)
        XCTAssertEqual(result2, "Hee")
    }

    func testCalculateThirdResult() {
        let input = "DATA"
        let result = viewController.calculateThirdResult(input)
        XCTAssertEqual(result, "Third result for: DATA")
    }
}
