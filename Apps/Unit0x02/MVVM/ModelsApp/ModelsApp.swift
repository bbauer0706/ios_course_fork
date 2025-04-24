// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI

@main
struct ModelsAppApp: App {
    @State private var userViewModel = UserViewModel()
    @State private var heartbeatViewModel = HeartbeatViewModel()
    @State private var temperatureViewModel = TemperatureViewModel()
    @State private var powerViewModel = PowerViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userViewModel)
                .environment(heartbeatViewModel)
                .environment(temperatureViewModel)
                .environment(powerViewModel)
        }
    }
}
