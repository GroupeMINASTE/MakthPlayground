//
//  MakthLexer.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Sourceful

public class MakthLexer: SourceCodeRegexLexer {
    
    lazy var generators: [TokenGenerator] = {
        var generators = [TokenGenerator?]()
        
        // Numbers
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        // Keywords
        let keywords = "if else print set while".components(separatedBy: " ")
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        // Line comment
        //generators.append(regexGenerator("//(.*)", tokenType: .comment))
        
        // Block comment
        //generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))

        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))

        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
