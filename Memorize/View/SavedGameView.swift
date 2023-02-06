//
//  SavedGameView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import SwiftUI

struct SavedGameView: View {
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
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

struct SavedGameView_Previews: PreviewProvider {
	static var previews: some View {
		SavedGameView()
	}
}
