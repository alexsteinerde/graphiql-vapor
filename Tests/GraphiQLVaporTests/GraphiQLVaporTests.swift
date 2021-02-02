import XCTest
import Vapor
import GraphiQLVapor
import XCTVapor

final class GraphiQLVaporTests: XCTestCase {
    func testRegistering() throws {
        let app = Application(.testing)
        defer { app.shutdown() }

        app.enableGraphiQL()

        try app.testable().test(.GET, "/") { res in
            XCTAssertEqual(res.status, HTTPResponseStatus.ok)
        }
    }

    func testRegisterOnOtherRoute() throws {
        let app = Application(.testing)
        defer { app.shutdown() }

        app.enableGraphiQL(on: "graphiQL")

        try app.testable().test(.GET, "/graphiQL") { res in
            XCTAssertEqual(res.status, HTTPResponseStatus.ok)
        }
    }

    static var allTests = [
        ("testRegistering", testRegistering),
        ("testRegisterOnOtherRoute", testRegisterOnOtherRoute)
    ]
}
