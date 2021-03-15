//
//  CustomAlertView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/15/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct CustomAlertView: View {
    @Binding var appState: Int
    @Binding var show: Bool
    var workMinutes: Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
            VStack (spacing: 25) {
                Image("star")
                Text("Good Job!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.pink)
                Text("You've Done \(workMinutes) Minutes of Work")
                    .bold()
                
                Button(action: {
                    
                    appState = 0
                    
                }) {
                    Text("Back To Home")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background(Color.purple)
                        .clipShape(Capsule())
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
            
    
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.8)
                        .onTapGesture {
                            withAnimation {
                                
                                
                                appState = 0
                                show.toggle()
                            }
                        }
            )
        }
    }
}
