//
//  OpenSourceView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct OpenSourceView: View {
    let data: [(String, [(String, String)])] = [
        ("", [
            ("GroupeMINASTE", "MakthPlayground")
        ]),
        ("opensource_swiftpackages", [
            ("twostraws", "Sourceful"),
            ("onevcat", "Kingfisher"),
            ("GroupeMINASTE", "DigiAnalytics")
        ]),
        ("opensource_others", [
            ("GroupeMINASTE", "Makth")
        ])
    ]

    #if os(iOS)
    var body: some View {
        List {
            ForEach(data, id: \.0) { section in
                if section.0.isEmpty {
                    Section() {
                        ForEach(section.1, id: \.1) { repo in
                            OpenSourceRepositoryView(user: repo.0, repo: repo.1)
                        }
                    }
                } else {
                    Section(header: Text(section.0.localized())) {
                        ForEach(section.1, id: \.1) { repo in
                            OpenSourceRepositoryView(user: repo.0, repo: repo.1)
                        }
                    }
                }
            }
        }
        .navigationTitle("opensource")
        .listStyleInsetGroupedIfAvailable()
    }
    #endif

    #if os(macOS)
    var body: some View {
        Form {
            ForEach(data, id: \.0) { section in
                if !section.0.isEmpty {
                    Text(section.0.localized())
                        .padding(.top)
                }
                ForEach(section.1, id: \.1) { repo in
                    OpenSourceRepositoryView(user: repo.0, repo: repo.1)
                }
            }
        }
    }
    #endif
}

struct OpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceView()
    }
}
