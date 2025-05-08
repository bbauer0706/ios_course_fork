// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import Foundation

// data model
struct Comment: Codable, Identifiable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}

@Observable
class CommentsViewModel {
    var comments: [Comment] = []
    var isLoading = false

    private var repository = ServiceLocator.shared.commentsRepository

    func fetchComments(forPostId postId: Int) {
        comments = []
        isLoading = true
        print("fetch 1")
        repository.fetchComments(forPostId: postId) { [weak self] newComments in
            self?.isLoading = false
            self?.comments = newComments ?? []
        }
    }
}

class CommentsRepository {
    func fetchComments(forPostId postId: Int, completion: @escaping ([Comment]?) -> Void) {
        let manager = ServiceLocator.shared.offlineModeManager

        guard manager.isOnline, let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments") else {
            completion(OfflineData.getComments(forPostId: postId, state: manager.state))
            return
        }
        
        print("start URLRequest Comments")
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode([Comment].self, from: data) {
                        completion(decodedResponse)
                        return
                    }
                    print("data available, but could not be decoded")
                } else if let error = error {
                    print(error.localizedDescription)
                }
                manager.goError()
                completion(OfflineData.getComments(forPostId: postId, state: manager.state))
            }
        }.resume()
    }
}
