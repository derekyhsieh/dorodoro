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
    @State var draggedOffset = Double(UIScreen.main.bounds.height / 1.2)
    @AppStorage("WorkMinutesTotal") var WorkMinutesTotal = 0
    @Binding var workTime: Int
    @Binding var breakTime: Int
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
       
            Color(returnColorForTotalWorkTime(totalWorkTime: WorkMinutesTotal).first!).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                RoundedRectangle(cornerRadius: 26)
                        .fill(Color(returnColorForTotalWorkTime(totalWorkTime: WorkMinutesTotal)[1]))
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: screen.width, height: screen.height)
                        .offset(y: CGFloat(self.draggedOffset))
                        .gesture(DragGesture()
                                    .onChanged { value in
                                        
                                        if value.location.y <= screen.height / 1.2 {
                                            draggedOffset = Double(value.location.y)
                                            
                                            self.workTime = Int((Double(screen.height + 100) - self.draggedOffset)/10.2)
                                            self.breakTime = Int(workTime/4)
                                        }
                                        
                                    }

                        
                        )
                      
                       
            }
            
            VStack {
                HStack {
                    Text("dorodoro")
                        .foregroundColor(WorkMinutesTotal > 150 && WorkMinutesTotal < 501 ? .black : .white)
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
                    UserDefaults.standard.setValue(draggedOffset, forKey: "draggedOffset")
                    print("user defaults is \(UserDefaults.standard.double(forKey: "draggedOffset"))")
                    self.appState = 1
                }) {
                    Image(systemName: "play")
                        .foregroundColor(WorkMinutesTotal > 150 && WorkMinutesTotal < 501 ? .black : .white)
                        .font(.system(size: 110))
                        .overlay(
                                Circle()
                                    .stroke(Color(WorkMinutesTotal > 150 && WorkMinutesTotal < 501 ? .black : .white), lineWidth: 8)
                                    .frame(width: 200, height: 200)
                        )
                                  
                            
                }
                
                
                Spacer()
                
                Text("\(workTime)min work / \(breakTime)min")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .padding(.bottom, 50)
                    .foregroundColor(WorkMinutesTotal > 150 && WorkMinutesTotal < 501 ? .black : .white)
                
              
                
            }
        }
 
        .onAppear {
            
            // check if is first time logging in
            
            if UserDefaults.standard.bool(forKey: "First Launch") == true {
                self.draggedOffset = UserDefaults.standard.double(forKey: "draggedOffset")
            } else {
                UserDefaults.standard.setValue(true, forKey: "First Launch")
            }
            
           
            showPermissions = true
            self.workTime = Int((Double(screen.height + 100) - self.draggedOffset)/10.2) < 25 ? 25 :  Int((Double(screen.height) + 100 - self.draggedOffset)/10.2)
           
               
            
                
            self.breakTime = Int(workTime/4)
            
            
            
        }
        .JMModal(showModal: $showPermissions, for: [.notification])
        
       
    }
    
    private func returnColorForTotalWorkTime(totalWorkTime: Int) -> [UIColor] {
        switch totalWorkTime {
        case 0...60:
            return [#colorLiteral(red: 0, green: 0.9742360711, blue: 0.4932131767, alpha: 1), #colorLiteral(red: 0, green: 0.8495182395, blue: 0.3787478805, alpha: 1)]
        case 61...150:
            return [#colorLiteral(red: 1, green: 0.5692248344, blue: 0, alpha: 1), #colorLiteral(red: 0.9939569831, green: 0.4086410701, blue: 0, alpha: 1)]
        case 151...500:
            return [#colorLiteral(red: 1, green: 0.9513885379, blue: 0, alpha: 1), #colorLiteral(red: 0.9040049911, green: 0.8368050456, blue: 0, alpha: 1)]
        case 501...1000:
            return [#colorLiteral(red: 0.6624877453, green: 0.5958624482, blue: 1, alpha: 1), #colorLiteral(red: 0.5398910642, green: 0.4785549045, blue: 0.868490696, alpha: 1)]
        default:
            return [#colorLiteral(red: 0.7325866818, green: 0.9595095515, blue: 0, alpha: 1), #colorLiteral(red: 0.6896815896, green: 0.8837340474, blue: 0, alpha: 1)]
        }
    }
}




