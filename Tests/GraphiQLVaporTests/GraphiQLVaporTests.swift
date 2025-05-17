import Vapor
import VaporTesting
import Testing

@testable import GraphiQLVapor

@Suite
struct GraphiQLVaporTests {

    @Test
    func registering() async throws {
        // prepare
        let app = try await Application.make(.testing)

        // act
        app.enableGraphiQL()

        // assert
        try await app.testing().test(.GET, "/") { res in
            #expect(res.status == .ok)
        }

        // cleanup
        try await app.asyncShutdown()
    }

    @Test
    func registerOnOtherRoute() async throws{
        // prepare
        let app = try await Application.make(.testing)

        // act
        app.enableGraphiQL(on: "graphiQL")

        // assert
        try await app.testing().test(.GET, "/graphiQL") { res in
            #expect(res.status == .ok)
        }

        // cleanup
        try await app.asyncShutdown()
    }

    @Test
    func registerOnRoutesBuilder() async throws {
        // prepare
        let app = try await Application.make(.testing)

        // act
        app.grouped("test").enableGraphiQL()

        // assert
        try await app.testing().test(.GET, "/test") { res in
            #expect(res.status == .ok)
        }

        // cleanup
        try await app.asyncShutdown()
    }
}
