//
//  ViewExtension.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

#if os(macOS)
public typealias NativeViewRepresentable = NSViewRepresentable
#endif

#if os(iOS)
public typealias NativeViewRepresentable = UIViewRepresentable
#endif

extension View {

    func listStyleInsetGroupedIfAvailable() -> some View {
        #if os(macOS)
        return Form { self }
        #else
        return self.listStyle(InsetGroupedListStyle())
        #endif
    }

    func autocapitalizationNoneIfAvailable() -> some View {
        #if os(iOS)
        return self.autocapitalization(UITextAutocapitalizationType.none)
        #else
        return self
        #endif
    }
    
    func toolbarRoleAutomaticIfAvailable() -> some View {
        if #available(iOS 16.0, *) {
            // See https://developer.apple.com/forums/thread/714430
            return self.toolbarRole(.automatic)
        } else {
            return self
        }
    }

}

#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { super.focusRingType = newValue }
    }
}
#endif
