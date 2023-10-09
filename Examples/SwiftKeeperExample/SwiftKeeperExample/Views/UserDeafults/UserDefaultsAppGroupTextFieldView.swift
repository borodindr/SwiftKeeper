//
//  UserDefaultsAppGroupTextFieldView.swift
//  SwiftKeeperExample
//
//  Created by Dmitry Borodin on 10/9/23.
//

import SwiftKeeper
import SwiftUI

extension StorageType {
    static var myAppGroupStorage: Self {
        .userDefaults(.appGroup("group.com.borodindr.SwiftKeeperExample"))
    }
}

struct UserDefaultsAppGroupTextFieldView: View {
    @Storage(.myAppGroupStorage, key: "user-defaults", defaultValue: "")
    var firstUserDefaults: String
    @Storage(.myAppGroupStorage, key: "user-defaults", defaultValue: "")
    var secondUserDefaults: String
    @Storage(.myAppGroupStorage, key: "user-defaults-two", defaultValue: "")
    var thirdUserDefaults: String
    
    var body: some View {
        List {
            Section("UserDefaults storage") {
                VStack(alignment: .leading) {
                    Text("UserDefaults storage")
                    TextField("Type", text: $firstUserDefaults)
                }
                VStack(alignment: .leading) {
                    Text("UserDefaults storage")
                    TextField("Type", text: $secondUserDefaults)
                }
                Text("Second value: \(secondUserDefaults)")
                Text("Third value: \(thirdUserDefaults)")
            }
        }
        .navigationTitle("UserDefaults")
#if os(iOS) || os(watchOS) || os(tvOS)
        // Not available in macOS
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    UserDefaultsAppGroupTextFieldView()
}
