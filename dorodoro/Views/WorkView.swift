//
//  WorkView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/11/21.
//

import SwiftUI

struct WorkView: View {
    @Binding var appState: Int
    let screen = UIScreen.main.bounds
    @State private var draggedOffset = CGPoint(x: 0, y: UIScreen.main.bounds.height / 1.2)
    
    var body: some View {
        ZStack(alignment: .bottom) {
       
            Color(#colorLiteral(red: 0.931381166, green: 0.3872834444, blue: 0.3862845302, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Button(action: {
                    
                }) {
                    
                  
                    
                        RoundedRectangle(cornerRadius: 26)
                                    .fill(Color(#colorLiteral(red: 0.9375395775, green: 0.2406340539, blue: 0.2395618856, alpha: 1)))
                                    .edgesIgnoringSafeArea(.all)
                            .frame(width: screen.width, height: screen.height/8)
                                    
                            
                            .overlay(
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 50, weight: .bold, design: .rounded))
                                            
                                }
                            )
                        
                        
                        
                        
                    }
                   
                        
                        
 
                    
                }
                      
                       
            
            
            VStack {
                HStack {
                    Text("work")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.leading, 30)
                        
                    Spacer()
                }
                
                //Play button
                Spacer()
             
                Button(action: {
                    
                    self.appState = 1
                }) {
                    Text("24 : 59")
                        .foregroundColor(.white)
                        .font(.system(size: 65, design: .rounded))
                        .bold()
                        
                        .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .frame(width: 300, height: 300)
                                
                                   
                            )
                }
                
                
                Spacer()
                
                Text("")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .padding(.bottom, 50)
                
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(appState: .constant(1))
    }
}
