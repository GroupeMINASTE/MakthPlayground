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
    private var context = Context(data: [:], outputs: [])
    private var executionBuffer = ""

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
        while lastIndex < context.outputs.count {
            // Handle LaTeX
            var latex = ""
            while lastIndex < context.outputs.count && context.outputs[lastIndex] is Value {
                let content = context.outputs[lastIndex]
                if content is StringValue && (content as! StringValue).value == "\n" {
                    break
                } else {
                    latex.append((content as! Value).toLaTeXString())
                }
                lastIndex += 1
            }
            if !latex.isEmpty {
                output.append(ConsoleEntry(id: output.count, span: "latex", content: latex))
            }
            
            // Handle... (nothing more for now)
            
            // Next output
            lastIndex += 1
        }
        
        delegate?.didRefreshOutput()
    }

    // Execute code
    func execute(_ source: String) {
        for line in source.split(separator: "\n") {
            output.append(ConsoleEntry(id: output.count, span: "code", content: String(line)))
            executionBuffer += "\(line)\n"
            
            if executionBuffer.filter({ $0 == "{" }).count == executionBuffer.filter({ $0 == "}" }).count {
                privateExecute()
                refreshOutput()
            }
        }
        
        refreshOutput()
        delegate?.didExecute()
    }
    
    private func privateExecute() {
        do {
            let actions = try AlgorithmLexer(content: executionBuffer).execute()
            context = try context.execute(actions: actions)
            //output.append(ConsoleEntry(id: output.count, span: "context", content: context.description()))
        } catch {
            output.append(ConsoleEntry(id: output.count, span: "stderr", content: error.localizedDescription))
        }
        executionBuffer = ""
    }

    // Reload console
    func reloadConsole() {
        // Just create a new context
        context = Context(data: [:], outputs: [])
        output = []
        lastIndex = 0
        refreshOutput()
        delegate?.didFinishLoading()
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
