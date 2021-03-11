//
//  HomeView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/10/21.
//

import SwiftUI

 struct HomeView: View {
    
    
    let screen = UIScreen.main.bounds
    @Binding var appState: Int
    
    @State private var draggedOffset = CGPoint(x: 0, y: UIScreen.main.bounds.height / 1.2)
    @State private var workTime: Int = 25
    @State private var breakTime: Int = 6
    var body: some View {
        
        ZStack(alignment: .bottom) {
       
            Color(#colorLiteral(red: 0.3490196078, green: 0.6509803922, blue: 0.8862745098, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
              
                    Card()
                        .frame(width: screen.width, height: screen.height)
                        .offset(y: draggedOffset.y)
                        .gesture(DragGesture()
                                    .onChanged { value in
                                        
                                        if value.location.y <= screen.height / 1.2 {
                                            self.draggedOffset = value.location
                                            print(value.location)
                                            self.workTime = Int((screen.height + 100 - self.draggedOffset.y)/10.2)
                                            self.breakTime = Int(workTime/4)
                                        }
                                        
                                    }

                        
                        )
                      
                       
            }
            
            VStack {
                HStack {
                    Text("dorodoro")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding()
                        .padding(.leading)
                        .padding(.top)
                    Spacer()
                }
                
                //Play button
                Spacer()
             
                Button(action: {
                    
                    self.appState = 1
                }) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 110))
                        .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .frame(width: 150, height: 150)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 4)
                                            .frame(width: 200, height: 200)
                                    )
                                   
                            )
                }
                
                
                Spacer()
                
                Text("\(workTime)min work / \(breakTime)min")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .padding(.bottom, 50)
                
              
                
            }
        }
        .preferredColorScheme(.dark)
 
     
       
    }
}


struct Card: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 26)
            .fill(Color(#colorLiteral(red: 0.168627451, green: 0.4, blue: 0.662745098, alpha: 1)))
            
            .edgesIgnoringSafeArea(.all)
    }
}


