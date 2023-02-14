//
//  DismissView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 14/2/23.
//

import SwiftUI

struct DismissView: View {
	@Binding var dismiss: DismissAction
	var body: some View {
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
}
