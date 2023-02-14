//
//  APICardStateView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import SwiftUI

struct APICardStateView: View {
	@StateObject var apiCardStateVM: APICardStateViewModel
    var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
				Spacer()
				switch apiCardStateVM.state {
				case .loading:
					VStack {
						Text("Please wait... 🚦")
							.font(.headline)
							.foregroundColor(.accentColor)
							.padding()
						ProgressView()
					}
				case .success(let model):
					if let player = model.player {
						PrepareAPICardGameView(apiImageDeckVM: .init(newAPIDeck: model.newAPIDeck,
																	 cardType: model.cardType,
																	 level: model.level,
																	 player: player))
					}
				case .error(let error):
					APICardStateErrorView(errorMessage: Binding<String>(get: { error }, set: {_ in}))
				}
				Spacer()
			}
			.padding(30)
		}
		.edgesIgnoringSafeArea(.all)
		.environmentObject(apiCardStateVM)
    }
}
