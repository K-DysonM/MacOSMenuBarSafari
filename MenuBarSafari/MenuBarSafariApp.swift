//
//  MenuBarSafariApp.swift
//  MenuBarSafari
//
//  Created by Kiana Dyson on 3/3/22.
//

import SwiftUI

@main
struct MenuBarSafariApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	init() {
		AppDelegate.shared = self.appDelegate
	}
	var body: some Scene {
		Settings {
			ContentView()
		}
	}
}
class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
	var popover = NSPopover.init()
	var statusBarItem: NSStatusItem?
	var firstTime = true
	
	static var shared : AppDelegate!
	func applicationDidFinishLaunching(_ notification: Notification) {
		
		let contentView = ContentView().preferredColorScheme(.dark)
		popover.appearance = NSAppearance(named: .aqua)
		popover.behavior = .transient
		popover.animates = false
		//popover.setValue(true, forKeyPath: "shouldHideAnchor")
		popover.contentSize = NSSize(width: 400, height: 500)
		popover.contentViewController = NSViewController()
		popover.contentViewController?.view = NSHostingView(rootView: contentView)
		popover.contentViewController?.view.window?.makeKey()
		statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
		statusBarItem?.button?.image = NSImage(systemSymbolName: "globe", accessibilityDescription: nil)
		statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
	}
	@objc func showPopover(_ sender: NSButton) {
		if let button = statusBarItem?.button {
			if let popoverWindow = popover.contentViewController?.view.window {
				popoverWindow.setFrame(popoverWindow.frame.offsetBy(dx: 0, dy: 2), display: false)
			}
			NSApp.activate(ignoringOtherApps: true)
			popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
			
		}
	}
	func applicationWillResignActive(_ notification: Notification) {
		print(#function)
		popover.close()
	}
	
	@objc func closePopover(_ sender: NSButton) {
		print(#function)
		popover.performClose(sender)
	}
	@objc func togglePopover(_ sender: NSButton) {
		print(popover.isShown)
		if popover.isShown {
			closePopover(sender)
		} else {
			showPopover(sender)
		}
	}
}
