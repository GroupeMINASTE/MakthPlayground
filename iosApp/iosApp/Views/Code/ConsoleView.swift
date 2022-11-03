//
//  ConsoleView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct ConsoleView: View {
    @ObservedObject var viewModel: ConsoleViewModel
    @State var currentLine: String = ""
    let id = UUID()

    var body: some View {
        if viewModel.showLoading {
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Text("console_load")
            }
        } else {
            VStack(spacing: 0) {
                ScrollView {
                    ScrollViewReader { value in
                        VStack(alignment: .leading) {
                            HStack {
                                if let out = viewModel.output {
                                    VStack(alignment: .leading, spacing: 0) {
                                        ForEach(out, id: \.id) { line in
                                            switch line.span {
                                            case "code":
                                                Text("> \(line.content)").foregroundColor(.gray)
                                            case "context":
                                                Text(line.content).foregroundColor(.blue)
                                            case "stderr":
                                                Text(line.content).foregroundColor(.red)
                                            default:
                                                Text(line.content)
                                            }
                                        }
                                    }
                                } else {
                                    Text("console_failed")
                                }
                                Spacer()
                            }
                            if viewModel.showExecuting {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                    Spacer()
                                }
                            }
                        }
                        .id(id)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .onChange(of: viewModel.output, perform: { _ in
                            withAnimation {
                                value.scrollTo(id, anchor: .bottom)
                            }
                        })
                    }
                }
                HStack(alignment: .top) {
                    Text(">")
                    TextField("", text: $currentLine, onCommit: {
                        viewModel.execute(currentLine)
                        currentLine = ""
                    })
                    .autocapitalizationNoneIfAvailable()
                    .disableAutocorrection(true)
                    .background(Color.clear)
                }
                .padding()
                .background(NativeColor.systemBackground.toColor())
            }
            .font( .system(size: 14, design: .monospaced))
            .alert(isPresented: Binding<Bool>(
                get: {
                    viewModel.prompt != nil
                },
                set: {
                    if !$0 {
                        viewModel.prompt = nil
                    }
                }
            )) {
                Alert(
                    title: Text(viewModel.prompt ?? ""),
                    message: nil,
                    primaryButton: .default(Text("button_ok"), action: {
                        viewModel.promptCompletionHandler?(nil)
                    }),
                    secondaryButton: .destructive(Text("button_cancel"), action: {
                        viewModel.promptCompletionHandler?(nil)
                    })
                )
            }
        }
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView(viewModel: ConsoleViewModel())
    }
}
