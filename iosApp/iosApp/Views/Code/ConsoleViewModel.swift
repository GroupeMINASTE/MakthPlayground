//
//  ConsoleViewModel.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import WebKit
import Combine
import StoreKit
import DigiAnalytics

class ConsoleViewModel: NSObject, ObservableObject, MakthConsoleDelegate {

    // The environment to execute code
    private lazy var console: MakthConsole = {
        let console = MakthConsole()
        console.delegate = self
        return console
    }()

    // State for the console
    @Published var showConsole: Bool = false
    @Published var showLoading: Bool = true {
        didSet {
            refreshOutput()
        }
    }
    @Published var showExecuting: Bool = false

    // Content of the console
    @Published var output: [ConsoleEntry]?

    // Any prompt
    @Published var prompt: String?
    var promptCompletionHandler: ((String?) -> Void)?
    
    // Load the console
    func loadConsoleIfNeeded() {
        console.loadConsoleIfNeeded()
    }

    // Refresh the output
    func refreshOutput() {
        output = console.output
    }

    // Execute code
    func execute(_ source: String) {
        // Start loading
        showExecuting = true

        DispatchQueue.global(qos: .background).async {
            // Send to the console
            self.console.execute(source)
        }
    }

    // Reload console
    func reloadConsole() {
        // Reload console
        console.reloadConsole()
    }

    func didStartLoading() {
        self.showLoading = true
    }

    func didFinishLoading() {
        self.showLoading = false
    }

    func didExecute() {
        DispatchQueue.main.async {
            self.refreshOutput()
            self.showExecuting = false
            self.executed()
        }
    }

    func didRefreshOutput() {
        DispatchQueue.main.async {
            self.refreshOutput()
        }
    }

    // Run after execution
    func executed() {
        // Analytics
        DigiAnalytics.shared.send(path: "execute")

        // Retrieve the number of save and increment it
        let datas = UserDefaults.standard
        let savesCount = datas.integer(forKey: "executeCount") + 1
        datas.set(savesCount, forKey: "executeCount")
        datas.synchronize()

        // Check number of saves to ask for a review
        if savesCount == 100 || savesCount == 500 || savesCount % 1000 == 0 {
            #if os(iOS)
            // Get main app scene
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                // Request review
                SKStoreReviewController.requestReview(in: scene)
            }
            #else
            // Request review
            SKStoreReviewController.requestReview()
            #endif
        }
    }

}
