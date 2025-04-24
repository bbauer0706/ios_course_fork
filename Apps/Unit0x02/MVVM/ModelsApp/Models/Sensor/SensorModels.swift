// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import Foundation
import Combine

/*
 We simulate a 1D hardware sensor that provides sensor data over time, with
 limited variation and in a specific range, i.e. the readings may flicker
 but do not jump.

 All 'sensors' here, i.e. HeartbeatSensor, TemperatureSensor, and PowerSensor
 are of that type with different ranges, they fulfill the SensorProtocol.
 
 In order to inform that new sensor data has been received, the SimulatedSensor
 will call a SensorDataReceiver; see also discussion below.
 
 ---
 
 How does the new sensor data get to the sensor user?
 
 The underlying SimulatedSensor supports a callback function didReceiveSensorData
 from SensorDataReceiver. So we have implemented three different ways:
  - The user of the sensor implements the SensorDataReceiver itself, e.g. in
    a ViewModel. This is the way for HeartbeatSensor.
  - The sensor class itself is the SensorDataReceiver and notifies the user in
    a different way. Here we have
      - a global notification via NotificationCenter on a specific channel
        for TemperatureSensor, and
      - a notification via Publisher for PowerSensor.
 
    There are differences:
        Feature                NotificationCenter      Combine (Publisher)
        Type safety            No                      Yes
        Lifecycle management   No(can leak)            Yes (via cancellables)
        Global                 yes                     You choose

 ---
 
 Should a sensor such as HeartbeatSensor inherit or embed SimulatedSensor?
 
 Prefer Composition if:
  - You need high flexibility in the behavior of your objects.
  - You wish to avoid deep inheritance hierarchies and tight coupling.
  - You want to ensure that parts of your application can be developed, changed, and extended independently.
 
 Prefer Inheritance if:
  - The subclasses are truly specializations of the parent class.
  - You are confident the base class implementation will not undergo significant changes that could affect subclasses.
  - You want to use polymorphic behavior that inheritance naturally supports.
 */

protocol SensorProtocol {
    var lastSensorData: Int { get set }
    var sensorDataReceiver: SensorDataReceiver? { get set }
    
    func startMonitoring()
    func stopMonitoring()
}

protocol SensorDataReceiver {
    func didReceiveSensorData(_ data: Int)
}

// just a demo that you can also extend Int
extension Int {
    func clamped(to limits: ClosedRange<Int>) -> Int {
        Swift.min(Swift.max(self, limits.lowerBound), limits.upperBound)
    }

    func adjusted(within range: ClosedRange<Int>, variation: Int) -> Int {
        let offset = Int.random(in: -variation...variation)
        return (self + offset).clamped(to: range)
    }
}

class SimulatedSensor: SensorProtocol {
    var lastSensorData: Int
    var sensorDataReceiver: SensorDataReceiver?

    private let minValue: Int
    private let maxValue: Int
    private let variation: Int
    private let timeInterval: Double
    private var timer: Timer?
    
    init(minValue: Int, maxValue: Int, startValue: Int, variation: Int = 1, timeInterval: Double = 1.0) {
        self.lastSensorData = startValue
        self.minValue = minValue
        self.maxValue = maxValue
        self.variation = variation
        self.timeInterval = timeInterval
    }
    
    func startMonitoring() {
        guard timer == nil else { return }

        // send the last known data at start; that typically refreshes the UI with a valid value
        self.sensorDataReceiver?.didReceiveSensorData(self.lastSensorData)
        
        // set timer and send new sensor data periodically
        timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true) { [weak self] _ in
            guard let self = self else { return }   // somtimes also 'strongSelf'
            self.lastSensorData = self.lastSensorData.adjusted(
                within: self.minValue...self.maxValue,
                variation: self.variation
            )
            self.sensorDataReceiver?.didReceiveSensorData(self.lastSensorData)
        }
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
}


// Remember: In order to work with a heartbeat sensor, you must provide
// a sensorDataReceiver.

class HeartbeatSensor: SimulatedSensor {
    init() {
        super.init(minValue: 40, maxValue: 200, startValue: 60, variation: 2)
    }
}


// A TemperatureSensor receives its own data and sends it via the
// NotificationCenter.

class TemperatureSensor: SimulatedSensor, SensorDataReceiver {
    static let notificationName = Notification.Name("newTemperatureDetected")
    
    init() {
        super.init(minValue: -10, maxValue: 60, startValue: 20, variation: 2)
        self.sensorDataReceiver = self
    }
    
    func didReceiveSensorData(_ data: Int) {
        NotificationCenter.default.post(name: TemperatureSensor.notificationName, object: data)
    }
}

// A PowerSensor receives its own data and sends it via the
// Publisher.

class PowerSensor: SimulatedSensor, SensorDataReceiver {
    public let powerPublisher = PassthroughSubject<Int, Never>() // sends to all active subscribers

    init() {
        super.init(minValue: 0, maxValue: 500, startValue: 100, variation: 10)
        self.sensorDataReceiver = self
    }

    func didReceiveSensorData(_ data: Int) {
        powerPublisher.send(data)
    }
}

