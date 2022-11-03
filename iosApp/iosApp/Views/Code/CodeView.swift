//
//  CodeView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct CodeView: View {
    @ObservedObject var consoleViewModel: ConsoleViewModel
    @Binding var document: MakthFile

    var body: some View {
        SplitView(
            leftView: {
                CodeEditorView(text: $document.source)
                    .ignoresSafeArea(.container, edges: .bottom)
            }, rightView: {
                ConsoleView(viewModel: consoleViewModel)
            },
            rightTitle: "console".localized(),
            showRightView: $consoleViewModel.showConsole
        )
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CodeView(consoleViewModel: ConsoleViewModel(), document: .constant(MakthFile()))
                .previewDevice("iPad (8th generation)")
        }
    }
}
