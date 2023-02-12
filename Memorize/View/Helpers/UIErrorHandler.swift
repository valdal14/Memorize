//
//  PromptUIError.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import Foundation
import SwiftUI

enum MemorizeError: String, Error {
	case coreDataError = "Error: 101 - Something went wrong while performing IO operation"
	case invalidPlayer = "Error: 102 - Cannot save the current game right now"
}

struct UIErrorHandler: ViewModifier {
	@Binding var showError: Bool
	var errorMessage: String
	
	func body(content: Content) -> some View {
		content
			.alert(isPresented: $showError, content: {
				Alert(title: Text("Memorize"),
					  message: Text("\(errorMessage)"),
					  dismissButton: .default(Text("OK")))
			})
	}
}

extension View {
	func presentErrorWith(state: Binding<Bool>, message: String) -> some View {
		self.modifier(UIErrorHandler(showError: state, errorMessage: message))
	}
}
