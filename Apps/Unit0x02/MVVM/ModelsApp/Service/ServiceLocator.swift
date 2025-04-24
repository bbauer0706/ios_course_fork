// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import Foundation

/*
 For (observed) ViewModels we use .environment with @Environment. But what
 if you need a global service such as a data repository. You can go with DI
 or with a global ServiceLocator.
 */

class ServiceLocator {
    static let shared = ServiceLocator()    // this is the singleton
    
    private lazy var heartbeatSensorInstance = HeartbeatSensor()
    private lazy var temperatureSensorInstance = TemperatureSensor()
    private lazy var powerSensorInstance = PowerSensor()

    var heartbeatSensor: HeartbeatSensor { heartbeatSensorInstance }     // remember: a getter
    var temperatureSensor: TemperatureSensor { temperatureSensorInstance }
    var powerSensor: PowerSensor { powerSensorInstance }
}
