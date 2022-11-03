//
//  IntExtension.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Int {

    // Convert integer to NativeColor
    func toNativeColor() -> NativeColor {
        let r = (self & 0xFF0000) >> 16
        let g = (self & 0xFF00) >> 8
        let b = (self & 0xFF)
        return NativeColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }

    // Convert to color or get default
    func toNativeColorOrDefault(for key: String) -> NativeColor {
        if self == -1 {
            switch key {
            case "backgroundColor":
                return .systemBackground
            case "plainColor":
                return .label
            case "numberColor":
                return .systemBlue
            case "stringColor":
                return .systemOrange
            case "identifierColor":
                return .systemIndigo
            case "keywordColor":
                return .systemPurple
            case "commentColor":
                return .systemGray
            default:
                return .clear
            }
        }
        return toNativeColor()
    }

}
