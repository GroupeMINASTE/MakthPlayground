//
//  ColorExtension.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
typealias NativeColor = UIColor
#elseif canImport(AppKit)
import AppKit
typealias NativeColor = NSColor
#endif

extension Color {

    // Convert Color to integer
    func toInt() -> Int {
        // Get colors as floats
        var rf: CGFloat = 0
        var gf: CGFloat = 0
        var bf: CGFloat = 0
        var af: CGFloat = 0
        NativeColor(self).getRed(&rf, green: &gf, blue: &bf, alpha: &af)

        // Convert to integers
        let r = Int(rf * 255)
        let g = Int(gf * 255)
        let b = Int(bf * 255)
        return r << 16 | g << 8 | b
    }

}

extension NativeColor {

    // Convert (NS/UI)Color to integer
    func toInt() -> Int {
        // Get colors as floats
        var rf: CGFloat = 0
        var gf: CGFloat = 0
        var bf: CGFloat = 0
        var af: CGFloat = 0
        getRed(&rf, green: &gf, blue: &bf, alpha: &af)

        // Convert to integers
        let r = Int(rf * 255)
        let g = Int(gf * 255)
        let b = Int(bf * 255)
        return r << 16 | g << 8 | b
    }

    // Convert (NS/UI)Color to Color
    func toColor() -> Color {
        Color(self)
    }

    #if os(macOS)
    // Define some unavailable colors for macOS
    static var systemBackground: NativeColor { windowBackgroundColor }
    static var label: NativeColor { labelColor }
    static var tertiaryLabel: NativeColor { tertiaryLabelColor }
    #endif

}
