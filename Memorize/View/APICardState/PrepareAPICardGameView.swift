//
//  PrepareAPICardGameView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import SwiftUI

struct PrepareAPICardGameView: View {
	@EnvironmentObject var audioPlayer: AudioService
	@EnvironmentObject var gameVM: GameViewModel
	@EnvironmentObject var onboardingVM: OnboardingViewModel
	@EnvironmentObject var apiCardStateVM: APICardStateViewModel
	@StateObject var apiImageDeckVM: ApiImageDeckViewModel
	
	@State private var columns : [GridItem] = [GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center),
											   GridItem(.fixed(90), spacing: 3, alignment: .center)]
	
	@State var isFaceUp : Bool = false
	@State var cardBackground = Color.accentColor
	@State var degree : Double = 0
	var cardW : CGFloat = 90.0
	var cardH : CGFloat = 110
	@State private var startNewGame: Bool = false
	@State private var downloadedCounter: Int = 0
	@State private var wasGameLoaded: Bool = false
	
    var body: some View {
		ZStack {
			LazyVGrid(columns: columns, alignment: .center, spacing: 4, content: {
				ForEach(0..<(apiImageDeckVM.level.rawValue * 2)) { index in
					AsyncImage(url: URL(string: apiImageDeckVM.newAPIDeck[index])) { image in
						image.resizable()
							.scaledToFit()
							.onAppear {
								if downloadedCounter != (apiImageDeckVM.level.rawValue * 2) {
									downloadedCounter += 1
								}
								gameVM.setupDeckFromImages(dowloadedImage: image, imageName: apiImageDeckVM.newAPIDeck[index])
							}
							.opacity(0.7)
					} placeholder: {
						ProgressView()
					}
				}
			})
			Spacer()
			VStack {
				Button {
					gameVM.gameWithDownloadedImages = true
					gameVM.isCurrentFromDownloadedImages = true
					gameVM.shuffleImageDeck()
					startNewGame.toggle()
					
				} label: {
					Text(downloadedCounter != (apiImageDeckVM.level.rawValue * 2) ? "Please Waint..." : "Start a new game")
				}
				.disabled(downloadedCounter != (apiImageDeckVM.level.rawValue * 2))
				.buttonStyle(.borderedProminent)
				.controlSize(.large)
				.padding()
			}
			.fullScreenCover(isPresented: $startNewGame) {
				Memorize(cardType: $apiImageDeckVM.cardType, level: $apiImageDeckVM.level, player: $apiImageDeckVM.player, wasNewGameComingFromALoadingGame: $wasGameLoaded)
			}
		}
		.edgesIgnoringSafeArea(.all)
    }
}

struct PrepareAPICardGameView_Previews: PreviewProvider {
	@State static var cards: [String] = []
	@State static var cardType: CardType = .picture(.image)
	@State static var level: GameLevel = .easy
	@State static var player: Player = Player(context: PersistenceController.shared.container.viewContext)
    static var previews: some View {
		PrepareAPICardGameView(apiImageDeckVM: ApiImageDeckViewModel(newAPIDeck: cards, cardType: cardType, level: level, player: player))
    }
}
