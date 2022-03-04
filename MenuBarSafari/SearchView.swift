//
//  SearchView.swift
//  MenuBarSafari
//
//  Created by Kiana Dyson on 3/3/22.
//

import SwiftUI

struct SearchBarView: View {
	
	@Binding var text: String
	@State  var isEditing: Bool = false
	
	var body: some View {
		HStack {
			TextField("Search or enter website url", text: $text)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding(8)
				.padding(.horizontal, 25)
				.background (Color.black)
				.cornerRadius(8)
				.padding(.horizontal, 10)
				.onChange(of: text, perform: { newValue in
					if !newValue.isEmpty {
						self.isEditing = true
					} else {
						self.isEditing = false
					}
				})
				.overlay(content: {
					Image(systemName: "magnifyingglass")
						.padding(.leading)
						.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
						.padding(.leading, 8)
					if isEditing {
							//print("I realize I am editing")
						Button {
							self.isEditing = false
							self.text = ""
						} label: {
							Image(systemName: "x.circle.fill")
						}.buttonStyle(PlainButtonStyle())
							.frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
							.padding(.trailing, 20)
							.transition(.move (edge: .trailing))
							.animation(.default, value: isEditing)
					}
				})
		}.cornerRadius(10.0)
	}
}
