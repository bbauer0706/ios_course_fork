[© 2025, Alexander Voß, FH Aachen, codebasedlearning.dev](mailto:info@codebasedlearning.dev)

# iOS Course – Persistence


## Unit 0x05 - Swift Data

> In this unit, we take a brief look at the SwiftData ORM (Object-Relational Mapper).


### What is an ORM?

An Object-Relational Mapper bridges:
- The relational database world (tables, rows, SQL).
- The object-oriented programming world (classes, objects, properties).

It handles:
- Mapping database rows ⇆ objects,
- Managing relationships and joins as object references,
- CRUD operations abstracted to object methods.
  
    
### Core Data as an ORM

Core Data does:
- Map entities (tables) to objects (NSManagedObject)
- Map relationships (to-many, to-one)
- Use fetch descriptors, predicates, etc.
- Abstracts persistence (though it’s more than just a database)

Data is often called a “graph management framework”, an object graph with 
change tracking, undo, faulting, etc.


### SwiftData as an ORM

SwiftData simplifies the same concepts:
- @Model = mapped class,
- Relationships via @Relationship,
- Queries via @Query and #Predicate,
- Persistence handled under the hood (via Core Data + SQLite).

(no NSManagedObject, no model editor, just classes and attributes)


### Feature Comparison: SQLite vs Core Data vs SwiftData

Feature / Aspect        SQLite (Raw)            Core Data                   SwiftData (iOS 17+)
Storage engine          SQLite                  SQLite (under the hood)     SQLite (via Core Data)
Schema management       Manual (CREATE TABLE)   .xcdatamodeld + code        @Model macros
Query language          SQL                     NSPredicate + NSFetch       #Predicate + @Query
Reactive UI update      Manual                  With @FetchRequest only     Built-in with @Query
Type safety             None (text-based SQL)   Limited (runtime strings)   Compile-time with Swift
Swift-native types      No                      Bridged (@NSManaged)        Native Swift types
Relations (1:1,1:n,m:n) Manual via foreign keys Yes (with tooling)          Yes (with @Relationship)
Cascade delete / rules  Manual                  Built-in                    Built-in via modifiers
Undo support            You build it            Yes                         Yes via modelContext.undoManager
CloudKit / sync support None                    With CloudKit setup         Not yet supported
Migration support       Manual SQL scripts      Versioned models            Minimal (some, limited customization)
Ease of use             Low-level               Medium complexity           Very high (declarative)
Best use cases          Maximum ctrl, low-level Complex data models, legacy SwiftUI apps, modern iOS/macOS dev
Learning curve          Steep (SQL, no safety)  Medium (model editor, APIs) Easy (pure Swift, very intuitive)


## Tasks


### 👉 Task 'iOS-Project'

Think about 
- Do you have a need for any of these technologies in your application?

