// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "OpenWeatherMapSDK",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "OpenWeatherMapSDK",
            targets: ["OpenWeatherMapSDK"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            from: Version(5, 4, 3)
        )
    ],
    targets: [
        .target(
            name: "OpenWeatherMapSDK",
            dependencies: [
                .product(name: "Alamofire")
            ]
        )
    ]
)
