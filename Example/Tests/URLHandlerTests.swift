import XCTest
import SortingHat

class URLHandlerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRegisterHandler() {
        // Normal
        SortingHat.register(url: "/test/:title") { _ in nil }
        XCTAssert(SortingHat.canHandle(url: "/test/HELLO"))
        XCTAssert(SortingHat.canHandle(url: "/test/Hello?id=10"))
        
        // URL pattern not matched
        XCTAssert(SortingHat.canHandle(url: "/test/HELLO/xx") == false)
        
        // URL invalid
        XCTAssert(SortingHat.register(url: "") { _ in nil } == false)
        
        // Two URLs have same root path
        SortingHat.register(url: "/test2/detail/:id") { _ in nil }
        SortingHat.register(url: "/test2/:title") { _ in nil }
        XCTAssert(SortingHat.canHandle(url: "/test2/detail/123"))
        XCTAssert(SortingHat.canHandle(url: "/test2/TITLE"))
    }
    
    func testHandlerParameter() {
        // Normal parameter parse and return type check
        SortingHat.register(url: "/test/:title") { params in
            XCTAssert(params["title"] != nil)
            return true
        }
        XCTAssert(SortingHat.handle(url: "/test/HELLO.SORTINGHAT") as! Bool == true)
        
        // Queryitems parse
        SortingHat.register(url: "/test1/:target") { params in
            XCTAssert(params["target"] != nil)
            if let id = params["id"] as? String {
                return Int(id)
            } else {
                return nil
            }
        }
        XCTAssert(SortingHat.handle(url: "/test1/story?id=321") as! Int == 321)

        // Two URLs have same root path and different return type
        SortingHat.register(url: "/test2/detail/:id") { params in
            XCTAssert(params["id"] != nil)
            return Int(params["id"] as! String)!
        }
        SortingHat.register(url: "/test2/:title") { params in
            XCTAssert(params["title"] != nil)
            return params["title"] as! String
        }
        XCTAssert(SortingHat.handle(url: "/test2/detail/123") as! Int == 123)
        XCTAssert(SortingHat.handle(url: "/test2/TITLE") as! String == "TITLE")
    }
}
