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
	
    var body: some View {
		LazyVGrid(columns: columns, alignment: .center, spacing: 4, content: {
			ForEach(apiImageDeckVM.newAPIDeck, id: \.self) { cardURL in
				AsyncImage(url: URL(string: cardURL)) { image in
					image.resizable()
						.scaledToFit()
				} placeholder: {
					ProgressView()
				}
			}
		})
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
