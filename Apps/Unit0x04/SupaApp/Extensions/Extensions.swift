// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

extension String {
    /// Extracts the part before '@' and capitalizes it if it starts with "user"
    var displayname: String {
        guard !self.isEmpty else { return "(Anonymous)" }
        guard let atIndex = self.firstIndex(of: "@") else { return self }
        let namePart = self[..<atIndex]
        
        if namePart.hasPrefix("user") {
            let suffix = namePart.dropFirst(4)  // Remove "user"
            guard let first = suffix.first else { return String(namePart) }
            let capitalized = first.uppercased() + suffix.dropFirst()
            return String(capitalized)
        } else {
            return String(namePart)
        }
    }
}

