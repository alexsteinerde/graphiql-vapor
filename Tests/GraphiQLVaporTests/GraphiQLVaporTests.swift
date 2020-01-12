import XCTest
import Vapor
import GraphiQLVapor

final class GraphiQLVaporTests: XCTestCase {
    func testRegistering() {
        let app = try! Application.testable()
        try! app.make(Router.self).enableGraphiQL()
        let responder = try! app.make(Responder.self)
         // 2
        let request = HTTPRequest(method: .GET, url: URL(string: "/")!)
         let wrappedRequest = Request(http: request, using: app)

        let status = try? responder.respond(to: wrappedRequest).wait().http

        XCTAssertEqual(status?.status, HTTPResponseStatus.ok)
    }

    func testRegisterOnOtherRoute() {
        let app = try! Application.testable()
        try! app.make(Router.self).enableGraphiQL(on: "graphiQL")
        let responder = try! app.make(Responder.self)
         // 2
        let request = HTTPRequest(method: .GET, url: URL(string: "/graphiQL")!)
         let wrappedRequest = Request(http: request, using: app)

        let status = try? responder.respond(to: wrappedRequest).wait().http

        XCTAssertEqual(status?.status, HTTPResponseStatus.ok)
    }

    static var allTests = [
        ("testRegistering", testRegistering),
        ("testRegisterOnOtherRoute", testRegisterOnOtherRoute)
    ]
}

extension Application {
  static func testable(envArgs: [String]? = nil) throws -> Application {
    let config = Config.default()
    let services = Services.default()
    var env = Environment.testing

    if let environmentArgs = envArgs {
      env.arguments = environmentArgs
    }
    let app = try Application(config: config, environment: env, services: services)

    
    return app
  }
}
