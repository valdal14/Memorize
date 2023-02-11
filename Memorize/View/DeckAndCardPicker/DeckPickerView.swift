//
//  DeckPickerView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import SwiftUI

struct DeckPickerView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var deckVM: DeckViewModel
	@EnvironmentObject var audioPlayer: AudioService
	@Binding var cardTypeString: String
	@Binding var level: GameLevel
	@State private var showError: Bool = false
	
	var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
				Spacer()
				/// Select the Card
				Text("Select \(cardTypeString) Deck")
					.font(.title)
					.foregroundColor(.accentColor)
				HStack(spacing: 30) {
					/// show cards
					ShowCardOptionView(cardTypeString: $cardTypeString, level: $level)
				}
				.padding()
				
				Spacer()
				ZStack {
					Circle()
						.fill(Color.red)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
					Image(systemName: "xmark")
						.font(.system(size: 25))
						.foregroundColor(Color.white)
						.onTapGesture {
							dismiss()
						}
				}
			}
			.padding(30)
		}
		.onAppear {
			deckVM.presentDeckOption(cardType: cardTypeString)
		}
		.edgesIgnoringSafeArea(.all)
	}
}

struct DeckPickerView_Previews: PreviewProvider {
	@State static var cardType: String = "Emoji"
	@State static var level: GameLevel = .easy
	
	static var previews: some View {
		DeckPickerView(cardTypeString: $cardType, level: $level)
	}
}
