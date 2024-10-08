//
//  WIkiSynthesizerApp.swift
//  WIkiSynthesizer
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI
import WikipediaKit
@main
struct WIkiSynthesizerApp: App {
    
    //Vid 477
    @State private var voices = VoiceViewModel()
        
    init(){
        //Vid 476, lo inicializamos
        WikipediaNetworking.appAuthorEmailForAPI = "petirrojo1718@gmail.com"
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(voices)
        }
    }
}
