// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import Supabase

fileprivate let logger = PredefinedLogger.dataLogger

struct ReadAllMessagesViewData: Decodable, Hashable, Identifiable {
    let id: UUID
    let created_at: Date
    let email: String?
    let message: [String: String]?
}

struct GlobalMessageQueueInsertData: Encodable, Hashable {
    let user_id: UUID
    let message: [String: String]
}

@Observable
class MessagesViewModel {
    var messages: [ReadAllMessagesViewData] = []
    
    init() {}

    func insertMessage(message: String) {
        Task {
            let client = ServiceLocator.shared.databaseConnector
            let connector = ServiceLocator.shared.databaseConnector.current
            
            guard client.isAuthenticated, let userId = client.userProfile?.id else {
                logger.notice("[MessagesViewModel] insert not authenticated")
                return
            }
            
            let insertMessage = GlobalMessageQueueInsertData(user_id:userId, message:["command":"message", "payload":message])
            do {
                logger.notice("[MessagesViewModel] insert message:\(message)")
                try await connector
                    .from("global_message_queue")
                    .insert(insertMessage)
                    .execute()
                logger.notice("[MessagesViewModel] insert worked")
                
                fetchMessages()
            } catch {
                logger.error("[MessagesViewModel] insert error:\(error)")
            }
        }
    }
    
    func fetchMessages() {
        Task {
            let connector = ServiceLocator.shared.databaseConnector.current
            
            do {
                logger.notice("[MessagesViewModel] fetch messages")
                messages = try await connector
                    .from("read_all_messages")
                    .select("id, created_at, email, message")
                    .execute()
                    .value
                logger.notice("[MessagesViewModel] fetch messages worked")
            } catch {
                logger.error("[MessagesViewModel] insert error:\(error)")
            }
        }
    }

}
