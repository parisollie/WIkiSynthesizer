//
//  VoiceViewModel.swift
//  WIkiSynthesizer
//
//  Created by Paul F on 08/10/24.
//

import Foundation
import WikipediaKit
import Observation
import Speech

@Observable
//Vid 476, lo inicializamos 
class VoiceViewModel {
    var lang = "es"
    //Vid 478
    var wikiResult = ""
    //Vid 480
    let synthesizer = AVSpeechSynthesizer()
    //Vid 481, nos sirve para continuar con la lectura o no
    var speaking = false
    var fragmentos : [Substring] = []
    
    //Vid 480
    func speak(lang: String){
        if !speaking{
            //Vid 481
            speaking = true
            fragmentos = wikiResult.split(separator: ",")
            //Vid 482 add lang: lang
            speakFragment(fragment: fragmentos, lang: lang)
        }
    }
    
    
    /*
       voces
       en: com.apple.voice.compact.en-US.Samantha
       fr: com.apple.voice.compact.fr-FR.Thomas
       it: com.apple.voice.compact.it-IT.Alice
       es: com.apple.voice.compact.es-MX.Paulina
       */

    //Vid 481
    func speakFragment(fragment: [Substring], lang: String){
        var voiceLang = ""
        //Vid 482
        switch lang {
        case "en" :
            voiceLang = "com.apple.voice.compact.en-US.Samantha"
        case "fr":
            voiceLang = "com.apple.voice.compact.fr-FR.Thomas"
        case "it":
            voiceLang = "com.apple.voice.compact.it-IT.Alice"
        default :
            voiceLang = "com.apple.voice.compact.es-MX.Paulina"
        }
        
        let voice = AVSpeechSynthesisVoice(identifier: voiceLang)
        if let firstFragment = fragment.first, !firstFragment.isEmpty{
            //Vid 481  String(firstFragment)
            let utterance = AVSpeechUtterance(string: String(firstFragment))
            utterance.rate = 0.5
            utterance.voice = voice
            synthesizer.speak(utterance)
        }
        
        if fragment.count > 1 {
            let fragmentArray = Array(fragment.dropFirst())
            //es la pausa que hay entre cada fragmente de texto
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.speakFragment(fragment: fragmentArray, lang: lang)
            }
        }else{
            speaking = false
        }
        
    }
    //Vid 480
    func stopSpeak(){
        //para que remueva todos los fragmentos.
        fragmentos.removeAll()
        synthesizer.pauseSpeaking(at: .immediate)
        speaking = false
    }
    //Vid 482
    func printVoices(){
        let voice = AVSpeechSynthesisVoice.speechVoices()
        print(voice)
    }
    
    //Vid 478
    func fetchWiki(search: String, lang: String){
        let _ = Wikipedia.shared.requestOptimizedSearchResults(language: WikipediaLanguage(lang), term: search) { searchResult, error in
            guard error == nil else { return }
            guard let searchResult = searchResult else { return }
            for article in searchResult.items {
                self.wikiResult.append(article.displayText)
            }
        }
    }
}
