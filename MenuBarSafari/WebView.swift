//
//  WebView.swift
//  MenuBarSafari
//
//  Created by Kiana Dyson on 3/3/22.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
	
	let urlString: String?
	
	func makeNSView(context: Context) -> WKWebView {
		return WKWebView()
	}
	
	func updateNSView(_ nsView: WKWebView, context: Context) {
		
		if let url = URL(string: urlString ?? "https://www.google.com") {
			let request = URLRequest(url: url)
			DispatchQueue.main.async {
				nsView.load(request)
			}
		}
	}
	
}
