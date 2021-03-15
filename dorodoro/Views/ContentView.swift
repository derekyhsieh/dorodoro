//
//  ContentView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/10/21.
//

import SwiftUI

struct ContentView: View {
    @State var appState: Int = 0
    @State var workTime: Int = 25
    @State var breakTime: Int = 6
    var body: some View {
        
        VStack {
        
            switch appState {
                case 0:
                    HomeView(appState: $appState, workTime: $workTime, breakTime: $breakTime)
                        .transition(AnyTransition.slide)
                        .animation(.spring())
                        
            case 1:
                WorkView(appState: $appState, timeRemaining: (workTime * 60), fullTime: (workTime * 60))
                    .transition(AnyTransition.slide)
                    .animation(.spring())
            case 2:
                BreakView(appState: $appState, workTime: $workTime, timeRemaining: (breakTime * 60), fullTime: (breakTime * 60))
                    .transition(AnyTransition.slide)
                    .animation(.spring())

                default:
                    HomeView(appState: $appState, workTime: $workTime, breakTime: $breakTime)
            }
          
        }
        
      
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
