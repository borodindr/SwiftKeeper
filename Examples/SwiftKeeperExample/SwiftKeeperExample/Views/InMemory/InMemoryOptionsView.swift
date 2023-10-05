//
//  InMemoryOptionsView.swift
//  SwiftKeeperExample
//
//  Created by Dmitry Borodin on 10/4/23.
//

import SwiftUI

struct InMemoryOptionsView: View {
    var body: some View {
        List {
            NavigationLink("Text Field") {
                InMemoryTextFieldView()
            }
        }
    }
}

#Preview {
    InMemoryOptionsView()
}
