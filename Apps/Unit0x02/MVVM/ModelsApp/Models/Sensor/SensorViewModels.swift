// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import Foundation
import Combine


/*
 We implement three 'observable' ViewModels. The challenge here is the
 asynchronous detection of new sensor data. All ViewModels access their
 respective singleton sensor via ServiceLocator.
  
 HeartbeatViewModel installs itself as a SensorDataReceiver, so it only
 needs to update the observed state (currentBPM) on new data. In this form
 there is only one receiver.
  
 TemperatureViewModel and PowerViewModel register with different publishers
 and are notified of new data.
 */

@Observable
class HeartbeatViewModel: SensorDataReceiver {
    var currentBPM: Int = -1

    private var sensor = ServiceLocator.shared.heartbeatSensor

    init() {
        sensor.sensorDataReceiver = self
    }
    
    func didReceiveSensorData(_ data: Int) {
        currentBPM = data
    }

    func startMonitoring() {
        sensor.startMonitoring()
    }

    func stopMonitoring() {
        sensor.stopMonitoring()
        currentBPM = -1
    }
}

@Observable
class TemperatureViewModel {
    var currentTemperature: Int = -1

    private var cancellables = Set<AnyCancellable>()
    private var sensor = ServiceLocator.shared.temperatureSensor

    init() {
        NotificationCenter.default.publisher(for: TemperatureSensor.notificationName)
            .compactMap { $0.object as? Int }   // data could be anything, compactMap filtering out nils
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newT in self?.currentTemperature = newT }
            .store(in: &cancellables)
    }

    func startMonitoring() {
        sensor.startMonitoring()
    }

    func stopMonitoring() {
        sensor.stopMonitoring()
        currentTemperature = -1
    }
}

@Observable
class PowerViewModel {
    var currentPower: Int = 0

    private var cancellables = Set<AnyCancellable>()
    private var sensor = ServiceLocator.shared.powerSensor

    init() {
        sensor.powerPublisher
            .receive(on: DispatchQueue.main)    // not recommended in combination with SwiftUI: .receive(on: RunLoop.main)
            .sink { [weak self] power in self?.currentPower = power }
            .store(in: &cancellables)
    }
    
    func startMonitoring() {
        sensor.startMonitoring()
    }

    func stopMonitoring() {
        sensor.stopMonitoring()
        currentPower = -1
    }
}
