//
//  WorkView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/11/21.
//

import SwiftUI

struct WorkView: View {
    @Binding var appState: Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(appState: .constant(1))
    }
}
