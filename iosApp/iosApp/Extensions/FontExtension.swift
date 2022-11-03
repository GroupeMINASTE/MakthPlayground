//
//  FontExtension.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

#if canImport(UIKit)
import UIKit
typealias NativeFont = UIFont
#elseif canImport(AppKit)
import AppKit
typealias NativeFont = NSFont
#endif
