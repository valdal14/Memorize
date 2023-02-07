//
//  LevelOptionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 7/2/23.
//

import SwiftUI

struct LevelOptionView: View {
	@Environment(\.dismiss) var dismiss
	@StateObject var deckVM: DeckViewModel = DeckViewModel(deckGenerator: DeckGenerator())
	@State private var selectedDifficulty: Int = 0
	@State private var presentLevelView: Bool = false
	
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
				Text("Select Number of Cards")
					.font(.title)
					.foregroundColor(.accentColor)
					.padding(.bottom, 5)
				/// Difficulty Level
				HStack(spacing: 30) {
					ForEach(deckVM.difficulties, id: \.self) { value in
						Circle()
							.fill(Color.accentColor)
							.frame(width: 70, height: 70)
							.shadow(radius: 10)
							.overlay {
								Text("\(value)")
									.font(.headline)
									.foregroundColor(.white)
							}
							.onTapGesture {
								selectedDifficulty = value
								presentLevelView.toggle()
							}
					}
				}
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
		/// present new screens
		.fullScreenCover(isPresented: $presentLevelView, content: {
			GameOptionView(level: $selectedDifficulty)
		})
		.edgesIgnoringSafeArea(.all)
		.environmentObject(deckVM)
	}
}

struct LevelOptionView_Previews: PreviewProvider {
	static var previews: some View {
		LevelOptionView()
	}
}
