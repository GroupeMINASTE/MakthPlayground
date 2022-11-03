//
//  MakthFile.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

struct MakthFile: FileDocument {

    // File content
    var source = ""

    // Supported identifiers
    static var readableContentTypes: [UTType] {
        guard let identifier = UTType("public.makth") else { return [] }
        return [identifier]
    }

    // Init a new empty file
    init(source: String = "") {
        self.source = source
    }

    // Init a file from configuration
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            source = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    // Save file
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(source.utf8)
        return FileWrapper(regularFileWithContents: data)
    }

}
