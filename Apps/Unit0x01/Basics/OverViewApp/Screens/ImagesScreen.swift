// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct ImagesScreen: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        //ZStack {
        //    HomeBackground()
        CblScreen(title: "Images", image: "Background") {
            VStack(spacing: 5) {
                //Divider()
                VStack(spacing: 5) {
                    Text("– Original –").asLine
                    Image("LegoImage")     // from xcassets
                        //.resizable()
                        //.scaleEffect(0.8)
                        //.frame(width: 100, height: 100)
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
                            //.border(Color.orange, width: 2)
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
/*
struct HomeBackground: View {
    var body: some View {
        ZStack {
            Color.indigo.opacity(0.5)
                .edgesIgnoringSafeArea(.all)    // .top .bottom
            GeometryReader { geo in             // we need the real size
                Image("Background")             // from xcassets
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    // .clipped()
                    .opacity(0.1)               // combines indigo with image
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: 0, y: 0)
            }
        }
    }
}
*/

