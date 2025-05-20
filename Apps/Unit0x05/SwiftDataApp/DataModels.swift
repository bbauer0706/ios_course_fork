// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import SwiftData

/*
 When you add @Model to a class, it generates:
 - Schema metadata (what fields exist, types, relationships)
 - Persistence glue (automatic database syncing)
 - Conformance to required protocols (like Identifiable)
 - Support for SwiftUI’s @Query and $book bindings
 
 Requirements
 - Only classes — not structs or enums.
 - Must conform to reference semantics (i.e., pass by reference).
 - Properties must be Swift-supported types: String, Date, Int, relationships, etc.
 
 Features
 - Schema generation
 - Persistence
 - SwiftUI-friendly bindings (@Query, $book)
 - Replaces NSManagedObject
 - Integrates with .modelContainer

 SwiftData implicitly gives your model a property like:
    var id: PersistentIdentifier
 It’s unique per object, like a UUID.
 - It conforms to Identifiable, so you can use it in ForEach, List, etc.
 - You don’t need to declare it manually unless you want control over the ID format.
 
 Relations
 - These are a bidirectional syncs — you can safely modify either side, and SwiftData keeps them in sync.
 */

@Model
class Author {
    var name: String
    
    // define a 1-to-many relationship where:
    // - One Author has many Books
    // - Each Book references one Author
    // - When the Author is deleted, all associated Books are also deleted
    //
    // SwiftData also supports many-to-many relationships
    @Relationship(deleteRule: .cascade) var books: [Book] = []
    
    // not stored, will not trigger persistence updates or participate in save/load cycles
    @Transient var temporaryNote: String = ""

    init(name: String) {
        self.name = name
    }
}

@Model
class Book {
    var title: String
    var timestamp: Date
    var author: Author?     // Inverse reference
    
    init(title: String, author: Author, timestamp: Date = .now) {
        self.title = title
        self.timestamp = timestamp
        self.author = author
    }
}

