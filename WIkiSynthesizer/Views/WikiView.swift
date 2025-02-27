//
//  WikiView+.swift
//  WIkiSynthesizer
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI

struct WikiView: View {
    
    //Vid 477
    var search : String
    @State private var viewModel = VoiceViewModel()
    //Vid 478
    @Environment(VoiceViewModel.self) var voice
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            ScrollView{
                Text(viewModel.wikiResult)
            }
            HStack(alignment: .center, spacing: 30){
                ButtonIcon(icon: "speaker.circle.fill") {
                    //Vid 480
                    viewModel.speak(lang: voice.lang)
                }
                ButtonIcon(icon: "stop.circle.fill") {
                    viewModel.stopSpeak()
                }
                ButtonIcon(icon: "arrowshape.backward.circle.fill") {
                    viewModel.stopSpeak()
                    dismiss()
                }
            }
        }.padding(.all)
        //Vid 478
        .navigationTitle(search)
        .navigationBarBackButtonHidden()
        .onAppear{
            viewModel.fetchWiki(search: search, lang: voice.lang)
        }
    }
}
//Vid 479

struct ButtonIcon: View {
    var icon :  String
    var action : () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: icon)
                .font(.title)
                .frame(width: 50, height: 50)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(Circle())
        })
    }
}


#Preview {
    WikiView(search: "SwiftUI")
        .environment(VoiceViewModel()) // Asegura que tenga un ViewModel en la vista previa
}
