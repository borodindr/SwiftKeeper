//
//  InMemoryView.swift
//  SwiftKeeperExample
//
//  Created by Dmitry Borodin on 10/4/23.
//

import SwiftUI
import SwiftKeeper

struct InMemoryTextFieldView: View {
    @Storage(.inMemory, key: "in-memory", defaultValue: "")
    var firstInMemory: String
    @Storage(.inMemory, key: "in-memory", defaultValue: "")
    var secondInMemory: String
    @Storage(.inMemory, key: "in-memory-two", defaultValue: "")
    var thirdInMemory: String
    
    var body: some View {
        List {
            Section("In-memory storage") {
                VStack(alignment: .leading) {
                    Text("In-memory storage")
                    TextField("Type", text: $firstInMemory)
                }
                VStack(alignment: .leading) {
                    Text("In-memory storage")
                    TextField("Type", text: $secondInMemory)
                }
                Text("Second value: \(secondInMemory)")
                Text("Third value: \(thirdInMemory)")
            }
        }
        .navigationTitle("In-Memory")
#if os(iOS) || os(watchOS) || os(tvOS)
        // Not available in macOS
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    NavigationStack {
        InMemoryTextFieldView()
    }
}
