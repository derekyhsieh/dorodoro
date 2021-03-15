//
//  HomeView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/10/21.
//

import SwiftUI
import PermissionsSwiftUI

 struct HomeView: View {
    
    
    let screen = UIScreen.main.bounds
    @Binding var appState: Int
    @State var showPermissions = false
    @State private var draggedOffset = CGPoint(x: 0, y: UIScreen.main.bounds.height / 1.2)
    @Binding var workTime: Int
    @Binding var breakTime: Int
    @ObservedObject var savedDefaults = SavedDefaults()
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
       
            Color(#colorLiteral(red: 0, green: 0.8212131262, blue: 0.328142643, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                    Card()
                        .frame(width: screen.width, height: screen.height)
                        .offset(y: self.draggedOffset.y)
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
                    savedDefaults.updateDraggedOffset(offset: Float(draggedOffset.y))
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
        .onAppear {
            
            self.draggedOffset.y = CGFloat(savedDefaults.draggedOffset)
            showPermissions = true
            self.workTime = Int((screen.height + 100 - self.draggedOffset.y)/10.2) < 25 ? 25 :  Int((screen.height + 100 - self.draggedOffset.y)/10.2)
            
               
            
                
            self.breakTime = Int(workTime/4)
            
            
            
        }
        .JMModal(showModal: $showPermissions, for: [.notification])
        
       
    }
}


struct Card: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 26)
            .fill(Color(#colorLiteral(red: 0, green: 0.6584398746, blue: 0.07515304536, alpha: 1)))
            
            .edgesIgnoringSafeArea(.all)
    }
}


