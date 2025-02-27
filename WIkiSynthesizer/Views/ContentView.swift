//
//  ContentView.swift
//  WIkiSynthesizer
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI

struct ContentView: View {
    
    //Vid 477
    @State private var search = ""
    @Environment(VoiceViewModel.self) var voice
    var body: some View {
        NavigationStack{
            VStack{
                Text("Wiki").font(.system(size: 70))
                Text("Synthesizer").font(.largeTitle)
                
                TextField("Buscar", text: $search)
                    .textFieldStyle(.roundedBorder)
                
                Spacer().frame(height: 20)
                
                Picker("Idioma", selection: Bindable(voice).lang) {
                    Text("Español").tag("es")
                    Text("Ingles").tag("en")
                    Text("Italiano").tag("it")
                    Text("Frances").tag("fr")
                }.pickerStyle(.segmented)
                
                Spacer().frame(height: 20)
                
                NavigationLink(value: search) {
                    Text("Buscar")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                
                Button(action: {
                    voice.printVoices()
                }, label: {
                    Text("Button")
                })

                Spacer()
            }.padding(.all)
                .navigationDestination(for: String.self) { value in
                    WikiView(search: value)
                }
        }
    }
}



#Preview {
    ContentView().environment(VoiceViewModel()) 
}
