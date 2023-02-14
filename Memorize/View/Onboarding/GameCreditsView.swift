//
//  GameCreditsView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import SwiftUI

struct GameCreditsView: View {
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			Spacer()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
					.padding()
				Text("To my favourite gamer")
					.font(.headline)
					.foregroundColor(.accentColor)
				Image("Memorize-Grazia")
					.resizable()
					.scaledToFit()
					.frame(width: 200, height: 200, alignment: .center)
					.padding(.bottom, 30)
				/// body
				HStack {
					Text("Memorize version:")
						.font(.headline)
					if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
						Text(version)
							.font(.headline)
							.foregroundColor(.accentColor)
					}
					Spacer()
				}
				.padding(5)
				HStack{
					Text("Card API:")
						.font(.headline)
					Link("Deck of Cards", destination: URL(string: "https://deckofcardsapi.com/")!)
						.font(.headline)
					Spacer()
				}
				.padding(5)
				HStack {
					Text("Audio:")
						.font(.headline)
					Text("Fluffing a Duck K.MacLeod")
						.font(.headline)
						.foregroundColor(.accentColor)
					Spacer()
				}
				.padding(5)
				Spacer()
				/// end body
				DismissView(dismiss: Binding<DismissAction>(
				get: { dismiss }, set: {_ in }))
			}
			.padding(30)
		}
		.edgesIgnoringSafeArea(.all)
    }
}

struct GameCreditsView_Previews: PreviewProvider {
    static var previews: some View {
        GameCreditsView()
    }
}
