//
//  DeckPickerView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import SwiftUI

struct DeckPickerView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var gameVM: GameViewModel
	@EnvironmentObject var onboardingVM: OnboardingViewModel
	@Binding var cardTypeString: String
	@Binding var level: GameLevel
	@State private var showError: Bool = false
	@Binding var player: Player?
	
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
					ShowCardOptionView(cardTypeString: $cardTypeString, level: $level, player: $player)
				}
				.padding()
				
				Spacer()
				DismissView(dismiss: Binding<DismissAction>(
				get: { dismiss }, set: {_ in }))
			}
			.padding(30)
		}
		.onAppear {
			gameVM.presentDeckOption(cardType: cardTypeString)
		}
		.edgesIgnoringSafeArea(.all)
	}
}

struct DeckPickerView_Previews: PreviewProvider {
	@State static var cardType: String = "Emoji"
	@State static var level: GameLevel = .easy
	@State static var player: Player?
	
	static var previews: some View {
		DeckPickerView(cardTypeString: $cardType, level: $level, player: $player)
	}
}
