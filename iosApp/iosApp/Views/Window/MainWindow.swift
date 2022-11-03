//
//  MainWindow.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import DigiAnalytics

struct MainWindow: View {

    @Environment(\.openURL) var openURL
    @AppStorage("firstOpen") var firstOpen = true

    @StateObject var consoleViewModel = ConsoleViewModel()
    @Binding var document: MakthFile
    @Binding var showSettings: Bool

    func initAnalytics() {
        // Send firstOpen if needed
        if firstOpen {
            DigiAnalytics.shared.send(path: "first_open")
            firstOpen = false
        }

        // Send file open
        DigiAnalytics.shared.send(path: "file")
    }
    
    func openPreferences() {
        #if os(macOS)
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        #else
        showSettings = true
        #endif
    }
    
    func reloadConsole() {
        consoleViewModel.reloadConsole()
    }
    
    func play() {
        consoleViewModel.showConsole.toggle()
        consoleViewModel.execute(document.source)
    }
    
    func onAppear() {
        initAnalytics()
        consoleViewModel.loadConsoleIfNeeded()
    }

    #if os(iOS)
    var body: some View {
        CodeView(
            consoleViewModel: consoleViewModel,
            document: $document
        )
        .onAppear(perform: onAppear)
        .toolbar {
            ToolbarItemGroup(placement: placement) {
                Button(action: openPreferences) {
                    Image(systemName: "gearshape")
                }
                Button(action: reloadConsole) {
                    Image(systemName: "arrow.clockwise")
                }
                .keyboardShortcut("k", modifiers: [.command])
                Button(action: play) {
                    Image(systemName: "play")
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
    }
    #endif
    
    #if os(macOS)
    var body: some View {
        CodeView(
            consoleViewModel: consoleViewModel,
            document: $document
        )
        .onAppear(perform: onAppear)
        .toolbar {
            ToolbarItemGroup(placement: placement) {
                Button(action: openPreferences) {
                    Image(systemName: "gearshape")
                }
                Button(action: reloadConsole) {
                    Image(systemName: "arrow.clockwise")
                }
                .keyboardShortcut("k", modifiers: [.command])
                Button(action: play) {
                    Image(systemName: "play")
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
        .touchBar {
            Button(action: openPreferences) {
                Image(systemName: "gearshape")
            }
            Button(action: reloadConsole) {
                Image(systemName: "arrow.clockwise")
            }
            Button(action: play) {
                Image(systemName: "play")
            }
        }
    }
    #endif

    var placement: ToolbarItemPlacement {
        #if os(macOS)
        return .primaryAction
        #else
        return .navigationBarTrailing
        #endif
    }

}
