// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct LoginScreen: View {
    @Environment(DatabaseConnectorViewModel.self) var connector
    
    // from a recently used list or similar maybe
    let signIns = [
        "useralice@codebasedlearning.com",
        "userbob@codebasedlearning.com",
    ]

    @State private var didLoadOnce = false
    @State private var selectedEmail: String = ""
    @State private var email = ""
    @State private var password = ""
 
    var body: some View {
        AlternativeStatusScreen(title: "Login", image: "lego_background") {
            VStack(spacing: 10) {
                Picker("recently used", selection: $selectedEmail) {
                    ForEach(signIns, id: \.self) { signIn in
                        Text(signIn).tag(signIn)
                    }
                }
                .onChange(of: selectedEmail) {
                        email = selectedEmail
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
                .padding(.bottom,20)
                
                TextField("email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: .infinity)
                    
                SecureField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)

                Button(action: {
                    connector.signIn(email: email, password: password)
                }) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom,20)
                
                Button(action: {
                    connector.broadcast(message:"Help! 🤷")
                }) {
                    Text("Helpdesk")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(CblTheme.dark, lineWidth: 2)
            )
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                if !didLoadOnce {
                    didLoadOnce = true
                    selectedEmail = signIns[0]
                }
            }
        }
        
    }
}
