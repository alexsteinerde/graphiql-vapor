import Vapor

extension Request {
    internal func serve(html: String) -> Response {
        return Response(status: .ok, headers: HTTPHeaders([(HTTPHeaders.Name.contentType.description, "text/html")]), body: Response.Body(string: html))
    }
}

public extension Application {
    func enableGraphiQL(on pathComponents: PathComponent..., method: HTTPMethod = .GET, serverPath: PathComponent = "/graphql") {
        graphQLServerPath = serverPath

        self.on(method, pathComponents) { (request) -> Response in
            request.serve(html: grahphiQLHTML)
        }
    }

    func enableGraphiQL(method: HTTPMethod = .GET) {
        self.enableGraphiQL(on: "", method: .GET, serverPath: "/graphql")
    }
}

var graphQLServerPath: PathComponent = "/graphql"

let grahphiQLHTML = """
<!--
 *  Copyright (c) 2021 GraphQL Contributors
 *  All rights reserved.
 *
 *  This source code is licensed under the license found in the
 *  LICENSE file in the root directory of this source tree.
-->
<!DOCTYPE html>
<html>
  <head>
    <style>
      body {
        height: 100%;
        margin: 0;
        width: 100%;
        overflow: hidden;
      }

      #graphiql {
        height: 100vh;
      }
    </style>

    <!--
      This GraphiQL example depends on Promise and fetch, which are available in
      modern browsers, but can be "polyfilled" for older browsers.
      GraphiQL itself depends on React DOM.
      If you do not want to rely on a CDN, you can host these files locally or
      include them directly in your favored resource bunder.
    -->
    <script
      crossorigin
      src="https://unpkg.com/react@16/umd/react.development.js"
    ></script>
    <script
      crossorigin
      src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"
    ></script>

    <!--
      These two files can be found in the npm module, however you may wish to
      copy them directly into your environment, or perhaps include them in your
      favored resource bundler.
     -->
    <link rel="stylesheet" href="https://unpkg.com/graphiql/graphiql.min.css" />
  </head>

  <body>
    <div id="graphiql">Loading...</div>
    <script
      src="https://unpkg.com/graphiql/graphiql.min.js"
      type="application/javascript"
    ></script>
    <script src="/renderExample.js" type="application/javascript"></script>
    <script>
      function graphQLFetcher(graphQLParams) {
        return fetch(
          '\(graphQLServerPath)',
          {
            method: 'post',
            headers: {
              Accept: 'application/json',
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(graphQLParams),
            credentials: 'omit',
          },
        ).then(function (response) {
          return response.json().catch(function () {
            return response.text();
          });
        });
      }

      ReactDOM.render(
        React.createElement(GraphiQL, {
          fetcher: graphQLFetcher,
          defaultVariableEditorOpen: true,
        }),
        document.getElementById('graphiql'),
      );
    </script>
  </body>
</html>
"""
