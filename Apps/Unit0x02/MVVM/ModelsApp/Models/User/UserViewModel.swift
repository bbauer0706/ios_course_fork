// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import Foundation

@Observable
class UserViewModel {
    var user = "Bob"
    
    func login() {
        user = ["Alice", "Bob", "Charly"].filter { $0 != user }.randomElement()!
    }
}
