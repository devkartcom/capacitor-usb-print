// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DevkartcomCapacitorUsbPrint",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DevkartcomCapacitorUsbPrint", targets: ["DevkartcomCapacitorUsbPrint"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/ionic-team/capacitor-swift-pm.git",
            exact: "8.4.2"
        )
    ],
    targets: [
        .target(
            name: "DevkartcomCapacitorUsbPrint",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Plugin"
        )
    ]
)
