//
//  MakthConsole.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import StoreKit
import DigiAnalytics
import shared

class MakthConsole {

    // The environment to execute code
    private var context = Context(data: [:], logs: [])

    // Content of the console
    var output = [ConsoleEntry]()
    var lastIndex = 0

    // Any prompt
    var prompt: String?
    var promptCompletionHandler: ((String?) -> Void)?

    // Delegate
    weak var delegate: MakthConsoleDelegate?
    
    // Load the console
    func loadConsoleIfNeeded() {
        delegate?.didFinishLoading()
    }

    // Refresh the output
    func refreshOutput() {
        while lastIndex < context.logs.count {
            output.append(ConsoleEntry(id: output.count, span: "logs", content: context.logs[lastIndex]))
            lastIndex += 1
        }
        
        delegate?.didFinishLoading()
        delegate?.didExecute()
    }

    // Execute code
    func execute(_ source: String) {
        for line in source.split(separator: "\n") {
            output.append(ConsoleEntry(id: output.count, span: "code", content: String(line)))
        }
        
        do {
            let actions = try AlgorithmLexer(content: source).execute()
            context = try context.execute(actions: actions)
        } catch {
            output.append(ConsoleEntry(id: output.count, span: "stderr", content: error.localizedDescription))
        }
        
        refreshOutput()
    }

    // Reload console
    func reloadConsole() {
        // Just create a new context
        context = Context(data: [:], logs: [])
        output = []
        lastIndex = 0
        refreshOutput()
    }

}

protocol MakthConsoleDelegate: AnyObject {

    func didStartLoading()
    func didFinishLoading()
    func didExecute()
    func didRefreshOutput()

}

struct ConsoleEntry: Equatable {

    var id: Int
    var span: String
    var content: String

}
