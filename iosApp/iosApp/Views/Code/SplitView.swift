//
//  SplitView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct SplitView<LeftView: View, RightView: View>: View {
    @Binding var showRightView: Bool

    var leftView: LeftView
    var rightView: RightView
    var rightTitle: String

    init(
        @ViewBuilder leftView: () -> LeftView,
        @ViewBuilder rightView: () -> RightView,
        rightTitle: String,
        showRightView: Binding<Bool>
    ) {
        self.leftView = leftView()
        self.rightView = rightView()
        self.rightTitle = rightTitle
        self._showRightView = showRightView
    }

    var body: some View {
        GeometryReader { geometry in
            if isForceSplitted || geometry.size.width >= 736 {
                HStack(spacing: 0) {
                    leftView
                        .frame(
                            minWidth: 0, maxWidth: .infinity,
                            minHeight: 0, maxHeight: .infinity
                        )
                    rightView
                        .frame(
                            minWidth: 0, maxWidth: .infinity,
                            minHeight: 0, maxHeight: .infinity
                        )
                        .frame(
                            width: geometry.size.width / 2
                        )
                }
            } else {
                Group {
                    leftView
                    NavigationLink(
                        destination: rightView
                            .navigationTitle(rightTitle),
                        isActive: $showRightView
                    ) {}
                }
            }
        }
    }

    var isForceSplitted: Bool {
        #if os(macOS)
        return true
        #else
        return false
        #endif
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(
            leftView: {
                Text("Left")
            }, rightView: {
                Text("Right")
            },
            rightTitle: "Title",
            showRightView: .constant(false)
        )
        .previewDevice("iPad (8th generation)")
    }
}
