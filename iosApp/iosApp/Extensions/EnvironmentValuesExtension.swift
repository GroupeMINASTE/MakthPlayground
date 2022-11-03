//
//  EnvironmentValuesExtension.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

private struct BackgroundColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct PlainColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct NumberColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct StringColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct IdentifierColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct KeywordColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct CommentColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}

extension EnvironmentValues {
    var backgroundColor: Binding<Int> {
        get { self[BackgroundColorKey.self] }
        set { self[BackgroundColorKey.self] = newValue }
    }
    var plainColor: Binding<Int> {
        get { self[PlainColorKey.self] }
        set { self[PlainColorKey.self] = newValue }
    }
    var numberColor: Binding<Int> {
        get { self[NumberColorKey.self] }
        set { self[NumberColorKey.self] = newValue }
    }
    var stringColor: Binding<Int> {
        get { self[StringColorKey.self] }
        set { self[StringColorKey.self] = newValue }
    }
    var identifierColor: Binding<Int> {
        get { self[IdentifierColorKey.self] }
        set { self[IdentifierColorKey.self] = newValue }
    }
    var keywordColor: Binding<Int> {
        get { self[KeywordColorKey.self] }
        set { self[KeywordColorKey.self] = newValue }
    }
    var commentColor: Binding<Int> {
        get { self[CommentColorKey.self] }
        set { self[CommentColorKey.self] = newValue }
    }
}
