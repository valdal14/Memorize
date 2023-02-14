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
				Spacer()
				/// body
				DismissView(dismiss: Binding<DismissAction>(
				get: { dismiss }, set: {_ in }))
			}
			.padding(30)
			Spacer()
		}
		.edgesIgnoringSafeArea(.all)
    }
}

struct GameCreditsView_Previews: PreviewProvider {
    static var previews: some View {
        GameCreditsView()
    }
}
