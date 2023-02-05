//
//  UserSelectionView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 5/2/23.
//

import SwiftUI

struct UserSelectionView: View {
	@State private var username: String = ""
	@FocusState private var isFocused: Bool
	
	var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
				Spacer()
				TextField(text: $username, label: {
					Text("enter your name")
				})
				.foregroundColor(.accentColor)
				.focused($isFocused)
				.padding()
				Button {
					//
				} label: {
					Text("Start New Game")
				}
				.cornerRadius(15)
				.frame(width: 200, height: 250, alignment: .center)
				.buttonStyle(.borderedProminent)
				.tint(.accentColor)
				Spacer()
				
			}
			.onAppear {
				DispatchQueue.main.async {
					isFocused = true
				}
			}
			.padding(30)
		}
		.edgesIgnoringSafeArea(.all)
	}
}

struct UserSelectionView_Previews: PreviewProvider {
	static var previews: some View {
		UserSelectionView()
	}
}
