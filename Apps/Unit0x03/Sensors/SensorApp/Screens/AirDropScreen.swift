// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct AirDropScreen: View {
    @State var sendText: String = "This is a test string for AirDrop."

    var body: some View {
        CblScreen(title: "AirDrop", image: "airdrop2") {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Text:").padding(0)
                    TextField("Enter text here", text: $sendText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                        .frame(maxWidth: .infinity)
                }
                HStack {
                    Spacer()
                    Button("Drop as Text") { shareText() }
                        .buttonStyle(ScreenButtonStyle())
                    Spacer()
                    Button("Drop as File") { shareTextFile() }
                        .buttonStyle(ScreenButtonStyle())
                    Spacer()
                }
            }.padding(.leading, 10)
        }
    }
    
    func shareText() {
        // create controller for sharing
        let activityViewController = UIActivityViewController(activityItems: [sendText], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.postToFacebook, .postToTwitter, .message, .mail]
        
        // present the activity view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func shareTextFile() {
        let fileName = "ios_course_air_drop_test.txt"
        
        // save the text to a temporary file
        if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
            do {
                try sendText.write(to: filePath, atomically: true, encoding: .utf8)
                
                // as before
                let activityViewController = UIActivityViewController(activityItems: [filePath], applicationActivities: nil)
                activityViewController.excludedActivityTypes = [.postToFacebook, .postToTwitter, .message, .mail]
                
                // as before
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(activityViewController, animated: true, completion: nil)
                }
            } catch {
                print("Error writing file: \(error)")
            }
        }
    }
}
