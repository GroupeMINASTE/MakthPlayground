//
//  DonateViewModel.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

/*
*
* Adapted from
* https://github.com/GroupeMINASTE/DonateViewController
* for SwiftUI
*
*/

import Foundation
import StoreKit

class DonateViewModel: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    /// Donations
    @Published var donations = [SKProduct]()

    /// Status of success alert
    @Published var didDonationSucceed = false
    @Published var didDonationFailed = false

    /// Payment queue
    private let paymentQueue = SKPaymentQueue()

    /// Strong reference to request
    private var request: SKProductsRequest?

    /// Initializer
    public override init() {
        super.init()

        // Add the observer
        paymentQueue.add(self)
    }

    /// Update donation datas
    public func fetchDonations(identifiers: [String]) {
        // Create a request
        request = SKProductsRequest(productIdentifiers: Set(identifiers))
        request?.delegate = self
        request?.start()
    }

    /// Handle when a row is selected
    public func donationSelected(id: String) {
        // Get the product
        guard let product = donations.first(where: { $0.productIdentifier == id }) else { return }

        // Create a payment
        let payment = SKPayment(product: product)

        // Add it to queue
        paymentQueue.add(payment)
    }

    /// Handle response from product request
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            // Save products
            self.donations = response.products
        }
    }

    /// Handle fail from product request
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }

    /// Handle when transactions are updated
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // Iterate transactions
        for transaction in transactions {
            // Get the corresponding donation
            if donations.first(where: { $0.productIdentifier == transaction.payment.productIdentifier }) != nil {
                // Check the transaction state
                if transaction.transactionState == .purchased {
                    // Donation succeed
                    self.didDonationSucceed = true
                } else if transaction.transactionState == .failed {
                    // Donation failed
                    self.didDonationFailed = true
                }

                // End the transaction if needed
                if transaction.transactionState != .purchasing {
                    // Finish transaction if not purchasing state
                    queue.finishTransaction(transaction)
                }
            }
        }
    }

}
