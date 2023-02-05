//
//  OnboardingView.swift
//  Memorize
//
//  Created by Valerio D'ALESSIO on 4/2/23.
//

import SwiftUI

struct OnboardingView: View {
	@State private var currentTab = 0
	@State var showNext: Bool = false
	
	var body: some View {
		TabView(selection: $currentTab,
				content:  {
			UserSelectionView()
				.tag(0)
			if showNext {
				Text("Second View")
					.tag(1)
				Text("Third View")
					.tag(2)
			}
		})
		.edgesIgnoringSafeArea(.all)
		.tabViewStyle(PageTabViewStyle())
		.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
	}
}

struct OnboardingView_Previews: PreviewProvider {
	@State static var showNext: Bool = false
	static var previews: some View {
		OnboardingView(showNext: showNext)
			.preferredColorScheme(.light)
	}
}

struct DarkOnboardingView_Previews: PreviewProvider {
	@State static var showNext: Bool = false
	static var previews: some View {
		OnboardingView(showNext: showNext)
			.preferredColorScheme(.dark)
	}
}

