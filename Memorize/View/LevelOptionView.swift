//
//  LevelOptionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 7/2/23.
//

import SwiftUI

struct LevelOptionView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var gameVM: GameViewModel
	@EnvironmentObject var onboardingVM: OnboardingViewModel
	@State private var selectedDifficulty: GameLevel = .easy
	@State private var presentLevelView: Bool = false
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
				Text("Select Number of Cards")
					.font(.title)
					.foregroundColor(.accentColor)
					.padding(.bottom, 5)
				Text("easy - medium - hard")
					.kerning(4)
					.fontWeight(.ultraLight)
					.font(.callout)
					.foregroundColor(.accentColor)
				/// Difficulty Level
				HStack(spacing: 30) {
					ForEach(gameVM.difficulties, id: \.self) { value in
						Circle()
							.fill(Color.accentColor)
							.frame(width: 70, height: 70)
							.shadow(radius: 10)
							.overlay {
								Text("\(value * 2)")
									.font(.headline)
									.foregroundColor(.white)
							}
							.onTapGesture {
								switch value {
								case 2:
									selectedDifficulty = .easy
								case 4:
									selectedDifficulty = .medium
								case 8:
									selectedDifficulty = .hard
								default:
									selectedDifficulty = .easy
								}
								presentLevelView.toggle()
							}
					}
				}
				Spacer()
				DismissView(dismiss: Binding<DismissAction>(
				get: { dismiss }, set: {_ in }))
			}
			.padding(30)
		}
		/// present new screens
		.fullScreenCover(isPresented: $presentLevelView, content: {
			GameOptionView(level: $selectedDifficulty, player: $player)
		})
		.edgesIgnoringSafeArea(.all)
	}
}

struct LevelOptionView_Previews: PreviewProvider {
	@State static var player: Player?
	static var previews: some View {
		LevelOptionView(player: $player)
	}
}
