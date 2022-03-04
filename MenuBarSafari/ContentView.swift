//
//  ContentView.swift
//  MenuBarSafari
//
//  Created by Kiana Dyson on 3/3/22.
//

import SwiftUI

struct ContentView: View {
	
	@State var searchField : String = ""
	@State var searchUrl : String =  "https://www.google.com"
	
    var body: some View {
		
		ZStack {
			Color.black
				.ignoresSafeArea()
			VStack(spacing: 10.0){
				SearchBarView(text: $searchField).padding(.top)
				WebView(urlString: searchUrl)
			}.onChange(of: searchField) { newValue in
				if let url = URL(string: newValue) {
					url.isReachable { result in
						if result {
							searchUrl = newValue
						}
					}
				} else {
					print("its not a real url")
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
	var isValidURL: Bool {
		let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
		if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
				// it is a link, if the match covers the whole string
			return match.range.length == self.utf16.count
		} else {
			return false
		}
	}
}
extension URL {
	func isReachable(completion: @escaping (Bool) -> ()) {
		var request = URLRequest(url: self)
		request.httpMethod = "HEAD"
		URLSession.shared.dataTask(with: request) { _, response, _ in
			completion((response as? HTTPURLResponse)?.statusCode == 200)
		}.resume()
	}
}
