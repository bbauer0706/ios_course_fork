// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import Foundation
import Network
import Combine

fileprivate let logger = PredefinedLogger.dataLogger

final class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    private let eventSubject = CurrentValueSubject<Bool, Never>(false)

    var eventPublisher: AnyPublisher<Bool, Never> { eventSubject.eraseToAnyPublisher() }

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.eventSubject.send(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}

@Observable
class NetworkViewModel {
    var isConnected: Bool = true

    private var monitor = ServiceLocator.shared.networkMonitor
    private var cancellables = Set<AnyCancellable>()

    init() {
        monitor.eventPublisher
            .receive(on: DispatchQueue.main)
            // also possible: .assign(to: \.isConnected, on: self)
            .sink { isConnected in
                self.isConnected = isConnected
                logger.notice("[NetworkViewModel] connected:\(isConnected)")
            }
            .store(in: &cancellables)
    }
    
    func reset() {
        logger.notice("[NetworkViewModel] reset")
    }
}
