//
//  UserDefaultsOptionsView.swift
//  SwiftKeeperExample
//
//  Created by Dmitry Borodin on 10/9/23.
//

import SwiftUI

struct UserDefaultsOptionsView: View {
    var body: some View {
        List {
            NavigationLink("Standard") {
                UserDefaultsStandardTextFieldView()
            }
            NavigationLink("AppGroup") {
                UserDefaultsAppGroupTextFieldView()
            }
        }
    }
}

#Preview {
    UserDefaultsOptionsView()
}
