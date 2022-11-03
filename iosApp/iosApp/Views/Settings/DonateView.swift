//
//  DonateView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import DigiAnalytics

struct DonateView: View {
    @StateObject var viewModel = DonateViewModel()

    let identifiers = [
        "me.nathanfallet.makth.playground.donation1",
        "me.nathanfallet.makth.playground.donation2",
        "me.nathanfallet.makth.playground.donation3"
    ]

    #if os(iOS)
    var body: some View {
        if viewModel.donations.isEmpty {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .navigationTitle("donate_title")
                .onAppear {
                    viewModel.fetchDonations(identifiers: identifiers)
                }
        } else {
            List {
                ForEach(viewModel.donations, id: \.productIdentifier) { donation in
                    HStack {
                        Text(donation.localizedTitle)
                        Spacer()
                        Text(donation.localizedPrice ?? "")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .onTapGesture {
                        viewModel.donationSelected(id: donation.productIdentifier)
                    }
                }
            }
            .listStyleInsetGroupedIfAvailable()
            .navigationTitle("donate_title")
            .alert(isPresented: Binding<Bool>(
                    get: { viewModel.didDonationSucceed },
                    set: { viewModel.didDonationSucceed = $0 }
            )) {
                Alert(
                    title: Text("donate_thanks"),
                    message: nil,
                    dismissButton: .default(Text("button_ok"))
                )
            }
            .onAppear {
                DigiAnalytics.shared.send(path: "donate")
            }
        }
    }
    #endif

    #if os(macOS)
    var body: some View {
        if viewModel.donations.isEmpty {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    viewModel.fetchDonations(identifiers: identifiers)
                }
        } else {
            Form {
                ForEach(viewModel.donations, id: \.productIdentifier) { donation in
                    HStack {
                        Text(donation.localizedTitle)
                        Text(donation.localizedPrice ?? "")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Button("donate_title") {
                            viewModel.donationSelected(id: donation.productIdentifier)
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                DigiAnalytics.shared.send(path: "donate")
            }
        }
    }
    #endif
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
