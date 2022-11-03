import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@main
struct iOSApp: App {
	
    // MARK: - App properties

    @AppStorage("backgroundColor") var backgroundColor = -1
    @AppStorage("plainColor") var plainColor = -1
    @AppStorage("numberColor") var numberColor = -1
    @AppStorage("stringColor") var stringColor = -1
    @AppStorage("identifierColor") var identifierColor = -1
    @AppStorage("keywordColor") var keywordColor = -1
    @AppStorage("commentColor") var commentColor = -1

    @State var showSettings = false

    // MARK: - Scenes

    #if os(iOS)
    var body: some Scene {
        // Main document group
        DocumentGroup(newDocument: MakthFile()) { file in
            MainWindow(document: file.$document, showSettings: $showSettings)
                .toolbarRoleAutomaticIfAvailable()
                .environment(\.backgroundColor, $backgroundColor)
                .environment(\.plainColor, $plainColor)
                .environment(\.numberColor, $numberColor)
                .environment(\.stringColor, $stringColor)
                .environment(\.identifierColor, $identifierColor)
                .environment(\.keywordColor, $keywordColor)
                .environment(\.commentColor, $commentColor)
                .fullScreenCover(isPresented: $showSettings) {
                    NavigationView {
                        SettingsView()
                            .environment(\.backgroundColor, $backgroundColor)
                            .environment(\.plainColor, $plainColor)
                            .environment(\.numberColor, $numberColor)
                            .environment(\.stringColor, $stringColor)
                            .environment(\.identifierColor, $identifierColor)
                            .environment(\.keywordColor, $keywordColor)
                            .environment(\.commentColor, $commentColor)
                            .toolbar {
                                ToolbarItemGroup(placement: .cancellationAction) {
                                    Button(
                                        action: {
                                            showSettings = false
                                        },
                                        label: {
                                            Image(systemName: "xmark.circle")
                                        }
                                    )
                                }
                            }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                }
        }
    }
    #endif

    #if os(macOS)
    var body: some Scene {
        // Main document group
        DocumentGroup(newDocument: MakthFile()) { file in
            MainWindow(document: file.$document, showSettings: $showSettings)
                .toolbarRoleAutomaticIfAvailable()
                .environment(\.backgroundColor, $backgroundColor)
                .environment(\.plainColor, $plainColor)
                .environment(\.numberColor, $numberColor)
                .environment(\.stringColor, $stringColor)
                .environment(\.identifierColor, $identifierColor)
                .environment(\.keywordColor, $keywordColor)
                .environment(\.commentColor, $commentColor)
        }

        // Settings
        Settings {
            SettingsView()
                .environment(\.backgroundColor, $backgroundColor)
                .environment(\.plainColor, $plainColor)
                .environment(\.numberColor, $numberColor)
                .environment(\.stringColor, $stringColor)
                .environment(\.identifierColor, $identifierColor)
                .environment(\.keywordColor, $keywordColor)
                .environment(\.commentColor, $commentColor)
        }
    }
    #endif
    
}
