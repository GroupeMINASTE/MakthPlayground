//
//  LaTeXView.swift
//  Makth Playground
//
//  Created by Nathan Fallet on 07/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import WebKit

struct LaTeXView: UIViewRepresentable {
    
    // LaTeX storage and HTML generator
    
    var content: String
    
    var raw: String {
        content
            .replacingOccurrences(of: "\n", with: "<br/>\n")
    }
    
    var html: String {
        return """
            <html>
            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width">
                <title>MathJax example</title>
                <style>
                    :root {
                        color-scheme: light dark;
                    }
                    html, body, p {
                        margin: 0;
                        padding: 0;
                    }
                </style>
                <script>MathJax = {
                    tex: {
                        inlineMath: [['$', '$']],
                        tags: 'ams'
                    },
                    svg: {
                        fontCache: 'global'
                    }
                };
                </script>
                <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
                <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
                </script>
            </head>
            <body>
                <p>$\(raw)$</p>
            </body>
            </html>
        """
    }
    
    // Web view magic
    
    @Binding var dynamicHeight: CGFloat
    
    var maxHeight: CGFloat? = nil
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        var parent: LaTeXView
        
        init(_ parent: LaTeXView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight") { height, error in
                DispatchQueue.main.async {
                    let height = height as! CGFloat
                    if let maxHeight = self.parent.maxHeight {
                        self.parent.dynamicHeight = min(height, maxHeight)
                    } else {
                        self.parent.dynamicHeight = height
                    }
                }
            }
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.isOpaque = false
        webview.navigationDelegate = context.coordinator
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
    
}

struct LaTeXViewView_Previews: PreviewProvider {
    
    static var previews: some View {
        LaTeXView(content: "Hello $a^2 + b^2$ there", dynamicHeight: .constant(0))
    }
    
}
