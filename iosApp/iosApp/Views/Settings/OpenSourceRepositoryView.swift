//
//  OpenSourceRepositoryView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import Kingfisher

struct OpenSourceRepositoryView: View {
    @Environment(\.openURL) var openURL
    @State var user: String
    @State var repo: String

    var body: some View {
        HStack(spacing: 12) {
            if let url = URL(string: "https://github.com/\(user).png") {
                KFImage(url)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .cornerRadius(8)
                    .padding(.vertical, 8)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("\(user)/\(repo)")
                Text("opensource_repo_\(repo)".localized())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .onTapGesture {
            if let url = URL(string: "https://github.com/\(user)/\(repo)") {
                openURL(url)
            }
        }
    }
}

struct OpenSourceRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceRepositoryView(user: "GroupeMINASTE", repo: "MakthPlayground")
    }
}
