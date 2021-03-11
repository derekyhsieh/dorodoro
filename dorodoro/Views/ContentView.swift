//
//  ContentView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/10/21.
//

import SwiftUI

struct ContentView: View {
    @State var appState: Int = 0
    var body: some View {
        
        VStack {
        
            switch appState {
                case 0:
                    HomeView(appState: $appState)
                        .transition(.slide)
                        .animation(.spring())
                        
            case 1:
                WorkView(appState: $appState)
                    
                default:
                HomeView(appState: $appState)
            }
          
        }
        
      
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
