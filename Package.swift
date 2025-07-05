// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "search-engine",
  targets: [
    .executableTarget(
      name: "SearchEngine"
    ),
    .testTarget(
      name: "SearchEngineTests",
      dependencies: ["SearchEngine"],
      resources: [
        .process("Data")
      ]
    ),
  ]
)
