//
//  EditorColorView.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct EditorColorView: View {
    @State var name: String
    @Binding var color: Int

    var body: some View {
        let internalColor = Binding<Color>(
            get: { color.toNativeColorOrDefault(for: name).toColor() },
            set: { color = $0.toInt() }
        )

        return ColorPicker(name.localized(), selection: internalColor)
    }
}

struct EditorColorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorColorView(name: "backgroundColor", color: .constant(-1))
    }
}
