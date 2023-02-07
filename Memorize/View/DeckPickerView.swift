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
	
	@Binding var cardType: String
	@Binding var level: Int
	
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
				Text("Select \(cardType) Deck")
					.font(.title)
					.foregroundColor(.accentColor)
				HStack(spacing: 30) {
					/// show cards
					if cardType == "Emoji" {
						ForEach(deckVM.deckOptions, id: \.self) { str in
							Circle()
								.fill(Color.accentColor)
								.frame(width: 70, height: 70)
								.shadow(radius: 10)
								.overlay {
									Text(str)
										.font(.title2)
								}
								.onTapGesture {
									// Start a new game
								}
						}
					}
					
					if cardType == "Symbol" {
						ForEach(deckVM.deckOptions, id: \.self) { str in
							Circle()
								.fill(Color.accentColor)
								.frame(width: 70, height: 70)
								.shadow(radius: 10)
								.overlay {
									Image(systemName: "\(str)")
										.foregroundColor(.white)
										.font(.title2)
								}
								.onTapGesture {
									// Start a new game
								}
						}
					}
					/// API toDO
					if cardType == "Image" {
						Text(cardType)
					}
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
			deckVM.presentDeckOption(cardType: cardType)
		}
		.edgesIgnoringSafeArea(.all)
    }
}

struct DeckPickerView_Previews: PreviewProvider {
	@State static var cardType: String = "Emoji"
	@State static var level: Int = 6
	
    static var previews: some View {
		DeckPickerView(cardType: $cardType, level: $level)
    }
}
