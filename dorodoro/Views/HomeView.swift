//
//  HomeView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/10/21.
//

import SwiftUI

struct HomeView: View {
    
    
    let screen = UIScreen.main.bounds
    
    @State private var draggedOffset = CGPoint(x: 0, y: UIScreen.main.bounds.height / 2)
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
       
            Color(#colorLiteral(red: 0.3490196078, green: 0.6509803922, blue: 0.8862745098, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
              
                    Card()
                        .frame(width: screen.width, height: screen.height)
                        .offset(y: draggedOffset.y)
                        .gesture(DragGesture()
                                    .onChanged { value in
                                        self.draggedOffset = value.location
                                        print(value.location)
                                    }

                        
                        )
                        .animation(.spring())
            }
            
            VStack {
                HStack {
                    Text("dorodoro")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .padding(.leading)
                    Spacer()
                }
                
                //Play button
                Spacer()
             
                Button(action: {}) {
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
                
                
              
                
            }
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewDevice("iPhone 11")
            HomeView()
                .previewDevice("iPhone 12 Pro Max")
        }
       
    }
}

struct Card: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 26)
            .fill(Color(#colorLiteral(red: 0.168627451, green: 0.4, blue: 0.662745098, alpha: 1)))
            
            .edgesIgnoringSafeArea(.all)
    }
}


