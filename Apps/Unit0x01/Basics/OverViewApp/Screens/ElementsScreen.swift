// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct ElementsScreen: View {
    // this is not a good design, but why?
    // (that is enough for now, we will discuss this in the lecture on models and life cycles)
    @State var actionDelayWorkItem: DispatchWorkItem?
    @State private var lastAction = "-" //{
//        didSet {
//            actionDelayWorkItem?.cancel()
//            actionDelayWorkItem = DispatchWorkItem { lastAction = "-" }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: actionDelayWorkItem!)
//    }
    
    @State private var input = "-"
    @State private var isOn = false
// also not good... {
//        didSet { lastAction = "toggle" }
//    }
    
    @State private var value = 0.5
    @State private var quantity = 0
    @State private var selectedOption = "Beer"
        
    var body: some View {
        CblScreen(title: "Texts", image: "Background") {
            VStack(spacing: 5) {
                //Divider()
                VStack(spacing: 5) {
                    Text("– Action –").asLine
                    Text("Action: \(lastAction)")
                }.padding()
                
                VStack(spacing: 5) {
                Text("– Input –").asLine
                TextField("Enter your name", text: $input)
                        .background(Color.pink.opacity(0.2))
                }.padding()
                
                VStack(spacing: 5) {
                Text("– Buttons –").asLine
                HStack {
                    Button(action: {
                        //lastAction = "Button 1 clicked"
                        setAction("Button 1 clicked")
                    }) {
                        Text("Button 1")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }
                    Button(action: {
                        setAction("Button 2 clicked")
                        //lastAction = "Button 2 clicked"
                    }) {
                        Text("Button 2")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    Button("Button 3") {
                        setAction("Button 3 clicked")
                    }
                    .buttonStyle(CustomButtonStyle())
                } //.padding()
                }.padding()
                
                VStack(spacing: 5) {
                Text("– Toggle, Slider, Stepper –").asLine
                Toggle("Enable Feature", isOn: $isOn)
                    .onChange(of: isOn) { setAction("toggle") }
                
                //Text("– Slider –").asLine
                Slider(value: $value, in: 0...1) { start in
                    if !start {
                        setAction("slider \(value)")
                    }
                }
                
                //Text("– Stepper –").asLine
                Stepper {               // or Stepper("Quantity", value: $quantity, in: 0...10)
                    Text("Quantity")
                } onIncrement: {
                    setAction("quantity inc \(quantity)")
                    quantity+=1
                    //incrementStep()
                } onDecrement: {
                    quantity-=1
                    setAction("quantity dec \(quantity)")
                }
                }.padding()
                
                VStack(spacing: 5) {
                // or DatePicker
                Text("– Picker –").asLine
                Picker("Options", selection: $selectedOption) {
                    Text("Beer").tag("Beer")
                    Text("Juice").tag("Juice")
                }
                .onChange(of: selectedOption) { setAction("pick \(selectedOption)") }
                
                Picker("Options", selection: $selectedOption) {
                    Text("Beer").tag("Beer")
                    Text("Juice").tag("Juice")
                }
                .pickerStyle(SegmentedPickerStyle())
                }.padding()
                Spacer()
            }.onDisappear {
                // this is a good place for...
                actionDelayWorkItem?.cancel()
                // print("end of view")
            }
        }
    }
    
    func setAction(_ action: String) {
        lastAction = action

        actionDelayWorkItem?.cancel()
        let workItem = DispatchWorkItem { self.lastAction = "-" }
        actionDelayWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: workItem)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut, value: configuration.isPressed)
    }
}
