// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct ImagesScreen: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        CblScreen(title: "Images", image: "Background") {
            VStack(spacing: 5) {
                VStack(spacing: 5) {
                    Text("– Original –").asLine
                    Image("LegoImage")     // from xcassets
                        .border(CblTheme.light)
                }.padding(5)
                
                VStack(spacing: 5) {
                    Text("– Resized –").asLine
                    HStack {
                        Spacer()
                        Image("LegoImage")
                            .resizable()
                            .frame(width: 120, height: 60)
                            .border(CblTheme.light)
                        Spacer()
                        Image("LegoImage")
                            .resizable()
                            .frame(height: 60)
                            .border(CblTheme.light)
                        Spacer()
                    }
                }.padding(5)
                
                VStack(spacing: 5) {
                    Text("– Keep aspect ratio, clipped –").asLine
                    HStack {
                        Spacer()
                        Image("LegoImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 60)
                            .clipped()
                            .border(CblTheme.light)
                        Spacer()
                        Image("LegoImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 60)
                            .offset(y: 15) // x: 20,
                            .clipped()
                            .border(CblTheme.light)
                        Spacer()
                    }
                }.padding(5)
                
                VStack(spacing: 5) {
                    Text("– Drag –").asLine
                    HStack {
                        Spacer()
                        Image("LegoImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 80)
                            .offset(x: dragAmount.width, y: dragAmount.height+15)
                            .gesture(
                                DragGesture()
                                    .onChanged { drag in
                                        self.dragAmount = drag.translation
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            self.dragAmount = .zero
                                        }
                                    }
                            )
                            .clipped()
                            .border(CblTheme.light)
                            .shadow(radius: 10)
                        Spacer()
                    }
                }.padding(5)
                Spacer()
            }
        }
    }
}
