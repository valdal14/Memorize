//
//  UserSelectionPropertyWrapper.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 6/2/23.
//

import Foundation

class UserSelectionPropertyWrapper: ObservableObject {
	
	@Published var player: Player?
	@Published var showError = false
	@Published var selectedName: String = ""
	@Published var showNext = false
	@Published var username: String = ""
	@Published var isTextFieldDisabled = false
	@Published var isSaveButtonDisable = true
	@Published var isNewGameDisabled = true
}
