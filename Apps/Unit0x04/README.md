[© 2025, Alexander Voß, FH Aachen, codebasedlearning.dev](mailto:info@codebasedlearning.dev)

# iOS Course – Supabase


## Unit 0x04 - Content

> In this unit we are looking at a Managed Realtime SQL Platform - Supabase.

Supabase is an open-source backend-as-a-service (BaaS) that provides PostgreSQL with instant REST and Realtime APIs, Authentication, Storage, and Edge Functions—aiming to be an open alternative to Firebase, but built on top of SQL and open standards.

Almost every project requires a database or node for exchanging data and, potentially, messages. A pure database connection is insecure, so we look for a framework or service that offers secure database functionality. Supabase and Firebase, among others, offer this functionality.

ChatGPT compares it as follows

| Feature                             | **Supabase** (Open Source)                     | **Firebase** (Google Cloud)                        |
|-------------------------------------|------------------------------------------------|---------------------------------------------------|
| **Database**                        | **PostgreSQL (SQL)**                           | **Firestore (NoSQL)** / Realtime Database (NoSQL) |
| **Query Language**                  | SQL (full relational, joins, functions)        | NoSQL-style querying (collections/documents)      |
| **Data Consistency**                | Strong ACID guarantees                        | Eventually consistent (Firestore), Realtime DB is weakly consistent |
| **Authentication**                  | Built-in with RLS integration (email, OAuth)   | Built-in Firebase Authentication (email, OAuth, etc.) |
| **Realtime**                        | **Postgres Realtime (WebSockets)**             | **Realtime Database (WebSockets)** / Firestore listeners |
| **APIs**                            | Auto-generated REST, GraphQL (via extension), Realtime | Client SDKs with custom API |
| **Storage**                         | File/object storage with access control       | Firebase Storage (Google Cloud Storage)          |
| **Functions**                       | Edge Functions (Deno runtime, JavaScript/TypeScript) | Firebase Cloud Functions (Node.js, Google Cloud)  |
| **Self-Hosting**                    | ✅ Yes, fully open-source                      | ❌ No, fully proprietary                          |
| **Pricing Model**                   | Usage-based, free self-hosting option          | Usage-based, no self-hosting                      |
| **Data Ownership**                  | Full (self-host or managed PostgreSQL)         | Google Cloud-hosted only                         |
| **Maturity & Ecosystem**            | Young but rapidly growing                     | Mature, large ecosystem, deep Google integration  |
| **Community & Licensing**           | Open Source (Apache 2.0)                       | Proprietary                                      |

### Summaries

- **Supabase**
  > SQL-first, open-source Firebase alternative with Realtime, Auth, Storage, and Edge Functions on top of PostgreSQL.  
  > Great for teams that want **SQL + Open Source + Flexibility**.

- **Firebase**
  > Google’s proprietary BaaS with NoSQL databases, Realtime capabilities, and seamless Google Cloud integration.  
  > Great for **rapid prototyping** and **scaling with Google Cloud**, but **vendor-locked**.
  

## Supabase

https://supabase.com
https://supabase.com/docs/guides


## SupaApp

> Our focus here has been on implementing essential communication channels and a reasonably sensible architecture. There are many other topics that could have been covered, but we will start here.

We have taken the following into account:
- sign in/out;
- user and security concepts;
- database connection and operations;
- messaging

### SQL operations

```
select Q.id, Q.created_at, U.email, Q.message from global_message_queue Q
left outer join auth.users U on Q.user_id = U.id
order by created_at desc;

-- select * from read_all_messages;

```

## Tasks


### 👉 Task 'iOS-Project'

Think about 
- Do you have a need for any of these technologies in your application?

