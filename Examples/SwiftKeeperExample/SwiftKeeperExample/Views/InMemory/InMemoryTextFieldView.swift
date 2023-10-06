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
    
//    @Storage(.inMemory, key: "in-memory")
//    var thirdInMemory: String?
    
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
                Text("Third value: \(secondInMemory)")
            }
        }
        .navigationTitle("In-Memory")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        InMemoryTextFieldView()
    }
}
