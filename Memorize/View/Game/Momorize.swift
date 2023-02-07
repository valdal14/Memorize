//
//  Momorize.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 7/2/23.
//

import SwiftUI

struct Momorize: View {
	@State private var columns : [GridItem] = [GridItem(.fixed(100), spacing: 3, alignment: .center),
											   GridItem(.fixed(100), spacing: 3, alignment: .center),
											   GridItem(.fixed(100), spacing: 3, alignment: .center)]
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

struct Momorize_Previews: PreviewProvider {
	static var previews: some View {
		Momorize()
	}
}
