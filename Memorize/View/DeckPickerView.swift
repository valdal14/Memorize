//
//  DeckPickerView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import SwiftUI

struct DeckPickerView: View {
	@Environment(\.dismiss) var dismiss
	@Binding var cardType: String
	
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
					Circle()
						.fill(Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
						.overlay {
							Text("🐶")
								.font(.title2)
						}
						.onTapGesture {
							
						}
					Circle()
						.fill(Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
						.overlay {
							Image(systemName: "playstation.logo")
								.foregroundColor(.white)
								.font(.title2)
						}
						.onTapGesture {
						
						}
					Circle()
						.fill(Color.accentColor)
						.frame(width: 70, height: 70)
						.shadow(radius: 10)
						.overlay {
							Image("images")
								.resizable()
								.scaledToFit()
								.frame(width: 45, height: 45)
								.foregroundColor(.white)
								.font(.title2)
						}
						.onTapGesture {
							
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
		.edgesIgnoringSafeArea(.all)
    }
}

struct DeckPickerView_Previews: PreviewProvider {
	@State static var cardType: String = "Emoji"
	
    static var previews: some View {
		DeckPickerView(cardType: $cardType)
    }
}
