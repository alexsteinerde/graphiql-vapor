# GraphiQLVapor
[![Language](https://img.shields.io/badge/Swift-5.1-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-3-F6CBCA.svg)](http://vapor.codes)
![build](https://github.com/alexsteinerde/graphiql-vapor/workflows/build/badge.svg)

This package ships functionality to add the [GraphiQL](https://github.com/graphql/graphiql) GraphQL web editor and request tester page to a `Router` service in Vapor.

## Installation
```
import PackageDescription

let package = Package(
    dependencies: [
    .package(url: "https://github.com/alexsteinerde/graphiql-vapor.git", from: "1.0.0"),
    ],
    targets: [
    .target(name: "App", dependencies: [<#T##Other Dependencies#>, "GraphiQLVapor"]),
    ...
    ]
)
```

## Example
```Swift
let router = EngineRouter.default()
router.enableGraphiQL()
services.register(router, as: Router.self)

```
This will register the web page on `GET /`. If you want to have GraphiQL available on another route, call `router.enableGraphiQL(on: "/graphiQL)` instead.

## License
This project is available under the MIT license. See the LICENSE file for more info.

## Contribution
You can contribute to this project by submitting a detailed issue or by forking this project and sending a pull request. Contributions of any kind are very welcome :)
