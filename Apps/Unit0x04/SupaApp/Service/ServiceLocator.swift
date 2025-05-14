// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()
    
    private lazy var networkMonitorInstance = NetworkMonitor()
    private lazy var databaseConnectorInstance = DatabaseConnector()

    var networkMonitor: NetworkMonitor { networkMonitorInstance }
    var databaseConnector: DatabaseConnector { databaseConnectorInstance }
}
