//
//  SettingsView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import DigiAnalytics
import MyAppsiOS

struct SettingsView: View {

    @Environment(\.openURL) var openURL
    @Environment(\.backgroundColor) var backgroundColor
    @Environment(\.plainColor) var plainColor
    @Environment(\.numberColor) var numberColor
    @Environment(\.stringColor) var stringColor
    @Environment(\.identifierColor) var identifierColor
    @Environment(\.keywordColor) var keywordColor
    @Environment(\.commentColor) var commentColor

    #if os(iOS)
    var body: some View {
        List {
            Section(header: Text("editor_settings")) {
                EditorColorView(name: "backgroundColor", color: backgroundColor)
                EditorColorView(name: "plainColor", color: plainColor)
                EditorColorView(name: "numberColor", color: numberColor)
                EditorColorView(name: "stringColor", color: stringColor)
                EditorColorView(name: "identifierColor", color: identifierColor)
                EditorColorView(name: "keywordColor", color: keywordColor)
                EditorColorView(name: "commentColor", color: commentColor)
                Button("button_reset") {
                    backgroundColor.wrappedValue = -1
                    plainColor.wrappedValue = -1
                    numberColor.wrappedValue = -1
                    stringColor.wrappedValue = -1
                    identifierColor.wrappedValue = -1
                    keywordColor.wrappedValue = -1
                    commentColor.wrappedValue = -1
                }
            }

            Section(header: Text("about")) {
                Text("developer_text")
                    .onTapGesture {
                        if let url = URL(string: "https://www.nathanfallet.me/") {
                            openURL(url)
                        }
                    }
                Button("documentation") {
                    if let url = URL(string: "https://docs.makth.org") {
                        DigiAnalytics.shared.send(path: "learn")
                        openURL(url)
                    }
                }
                Button("App Store") {
                    if let url = URL(string: "https://apps.apple.com/") {
                        openURL(url)
                    }
                }
                Button("TestFlight") {
                    if let url = URL(string: "https://testflight.apple.com/") {
                        openURL(url)
                    }
                }
                NavigationLink(destination: OpenSourceView()) {
                    Text("opensource")
                }
                NavigationLink(destination: DonateView()) {
                    Text("donate_title")
                }
            }

            Section(header: MyAppHeader()) {
                ForEach(MyApp.values) { app in
                    MyAppView(app: app)
                }
            }
        }
        .navigationTitle("settings")
        .listStyleInsetGroupedIfAvailable()
        .onAppear {
            DigiAnalytics.shared.send(path: "settings")
        }
    }
    #endif

    #if os(macOS)
    var body: some View {
        TabView {
            Form {
                EditorColorView(name: "backgroundColor", color: backgroundColor)
                EditorColorView(name: "plainColor", color: plainColor)
                EditorColorView(name: "numberColor", color: numberColor)
                EditorColorView(name: "stringColor", color: stringColor)
                EditorColorView(name: "identifierColor", color: identifierColor)
                EditorColorView(name: "keywordColor", color: keywordColor)
                EditorColorView(name: "commentColor", color: commentColor)
                Button("button_reset") {
                    backgroundColor.wrappedValue = -1
                    plainColor.wrappedValue = -1
                    numberColor.wrappedValue = -1
                    stringColor.wrappedValue = -1
                    identifierColor.wrappedValue = -1
                    keywordColor.wrappedValue = -1
                    commentColor.wrappedValue = -1
                }
            }
            .tabItem {
                Label("editor_settings", systemImage: "pencil.circle")
            }

            Form {
                Text("developer_text")
                    .onTapGesture {
                        if let url = URL(string: "https://www.nathanfallet.me/") {
                            openURL(url)
                        }
                    }
            }
            .tabItem {
                Label("about", systemImage: "info.circle")
            }

            OpenSourceView()
            .tabItem {
                Label("opensource", systemImage: "chevron.left.slash.chevron.right")
            }

            DonateView()
            .tabItem {
                Label("donate_title", systemImage: "giftcard")
            }

            Form {
                ForEach(MyApp.values) { app in
                    MyAppView(app: app)
                }
            }
            .tabItem {
                Label(MyAppHeaderText.localizedString, systemImage: "app.badge")
            }
        }
        .padding()
        .frame(minWidth: 512)
        .onAppear {
            DigiAnalytics.shared.send(path: "settings")
        }
    }
    #endif
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
