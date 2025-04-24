// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct SensorScreen: View {
    var body: some View {
        CblScreen(title: "Sensor Screen", image: "lego_background") {
            VStack(spacing:0) {
                UserView()
                HeartbeatView()
                TemperatorView()
                PowerView()
                Spacer()
            }
        }
    }
}

struct UserView: View {
    @Environment(UserViewModel.self) private var userViewModel

    var body: some View {
        ZStack {
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("User:")
                Text("\(userViewModel.user)").font(.title)
            }
            HStack {
                Spacer()
                Button("Login") { userViewModel.login() }
                .padding(3)
                .border(CblTheme.red, width: 1)
                .padding(5)
            }
        }.padding(5)
    }
}

func toValidUnitStr(_ value: Int, _ unit: String) -> String {
    return value < 0 ? "-" : "\(value)\(unit)"
}

struct HeartbeatView: View {
    @Environment(HeartbeatViewModel.self) private var heartbeatModel

    @State private var isOn = false
    
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 5) {
            Text("Heartbeat: \(toValidUnitStr(heartbeatModel.currentBPM,"bpm"))")
                .font(.title2)
            Toggle("", isOn: $isOn)
                .onChange(of: isOn) {
                    if isOn { heartbeatModel.startMonitoring() }
                    else { heartbeatModel.stopMonitoring() }
                }
        }.padding(5)
    }
}

struct TemperatorView: View {
    @Environment(TemperatureViewModel.self) private var temperatureViewModel
    
    @State private var isOn = false
    
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 5) {
            Text("Temperatur: \(toValidUnitStr(temperatureViewModel.currentTemperature,"°C"))")
                .font(.title2)
            Toggle("", isOn: $isOn)
                .onChange(of: isOn) {
                    if isOn { temperatureViewModel.startMonitoring() }
                    else { temperatureViewModel.stopMonitoring() }
                }
        }.padding(5)
    }
}

struct PowerView: View {
    @Environment(PowerViewModel.self) private var powerViewModel
    
    @State private var isOn = false
    
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 5) {
            Text("Power: \(toValidUnitStr(powerViewModel.currentPower,"W"))")
                .font(.title2)
            Toggle("", isOn: $isOn)
                .onChange(of: isOn) {
                    if isOn { powerViewModel.startMonitoring() }
                    else { powerViewModel.stopMonitoring() }
                }
        }.padding(5)
    }
}
