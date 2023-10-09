//
//  ContentView.swift
//  SwiftKeeperExample
//
//  Created by Dmitry Borodin on 10/4/23.
//

import SwiftUI
import SwiftKeeper

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("In-Memory") {
                    InMemoryOptionsView()
                }
                NavigationLink("UserDefaults") {
                    UserDefaultsOptionsView()
                }
            }
            .navigationTitle("SwiftKeeperExample")
        }
    }
}

#Preview {
    ContentView()
}
