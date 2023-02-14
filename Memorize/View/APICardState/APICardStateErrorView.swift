//
//  APICardStateErrorView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import SwiftUI

struct APICardStateErrorView: View {
	@Environment(\.dismiss) var dismiss
	@Binding var errorMessage: String
	
    var body: some View {
		ZStack {
			Image("landscape")
				.resizable()
			VStack {
				Image("LogoV2")
					.resizable()
					.frame(width: 150, height: 150)
				Spacer()
				Text(errorMessage)
					.font(.headline)
					.foregroundColor(.red)
					.padding(.bottom, 30)
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
				Spacer()
			}
			.padding(30)
		}
		.edgesIgnoringSafeArea(.all)
    }
}

struct APICardStateErrorView_Previews: PreviewProvider {
	@State static var errorMessage: String = "Error loading cards"
    static var previews: some View {
        APICardStateErrorView(errorMessage: $errorMessage)
    }
}
