//
//  HomeView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/10/21.
//

import SwiftUI
import PermissionsSwiftUI
import SSToastMessage

 struct HomeView: View {
    
    
    let screen = UIScreen.main.bounds
    let capsuleWidth = UIScreen.main.bounds.width - 100
    @Binding var appState: Int
    @State var showPermissions = false
    @State var draggedOffset = Double(UIScreen.main.bounds.height / 1.2)
    @AppStorage("WorkMinutesTotal") var WorkMinutesTotal = 0
    @Binding var workTime: Int
    @Binding var breakTime: Int
    @State var showToast = false
    @State var showTutorialOne = false
    @State var showTutorialTwo = false
    
    
    
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
                        .onTapGesture {
                            showToast.toggle()
                        }
                    Spacer()
                    
                    if !showTutorialOne && !showTutorialTwo {
                        Button(action: {
                            
                            showTutorialOne = true
                            
                        }) {
                            Image(systemName: "questionmark")
                                .padding()
                                .padding(.trailing)
                                .padding(.top)
                                .foregroundColor(WorkMinutesTotal > 150 && WorkMinutesTotal < 501 ? .black : .white)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                
                        }
                    }
                    
         
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
        .present(isPresented: self.$showToast, type: .floater(), position: .top,  animation: Animation.spring(), closeOnTapOutside: true) {
                 self.createTopFloaterView()
             }
        
        .present(isPresented: self.$showTutorialOne, type: .toast, position: .top,  animation: Animation.spring(), autohideDuration: Double.greatestFiniteMagnitude, closeOnTap: true, onTap: {
            self.showTutorialTwo = true
        }, closeOnTapOutside: false) {
                
            self.createTopTutorialToast()
             }
        
        .present(isPresented: self.$showTutorialTwo, type: .toast, position: .bottom,  animation: Animation.spring(), autohideDuration: Double.greatestFiniteMagnitude, closeOnTap: true, closeOnTapOutside: false) {
                
            self.createBottomTutorialToast()
             }
        
        .onAppear {
            
            // check if is first time logging in
            
            let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
            if !launchedBefore  {
                
                UserDefaults.standard.setValue(Double(UIScreen.main.bounds.height / 1.2), forKey: "draggedOffset")
             
                self.showTutorialOne = true
                UserDefaults.standard.set(true, forKey: "launchedBefore")
            } else {
                self.draggedOffset = UserDefaults.standard.double(forKey: "draggedOffset")
            }
         
            
           
            self.workTime = Int((Double(screen.height + 100) - self.draggedOffset)/10.2) < 25 ? 25 :  Int((Double(screen.height) + 100 - self.draggedOffset)/10.2)
           
               
            
            showPermissions = true
            self.breakTime = Int(workTime/4)
           
            
            
            
        }
        .JMModal(showModal: $showPermissions, for: [.notification])
        


       
    }
    
    func createTopTutorialToast() -> some View {
        VStack(alignment: .leading) {
            
            Spacer(minLength: 30)
            
                Text("Drag the Bottom Tab to change work and break time")
                    .bold()
                    .foregroundColor(.white)
            Text("Tap to dismiss")
                .foregroundColor(.white.opacity(0.8))
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: 130)
        .background(Color(#colorLiteral(red: 0.2511832416, green: 0.6168131232, blue: 0.8950596452, alpha: 1)))
    }
    
    func createBottomTutorialToast() -> some View {
        VStack(alignment: .leading) {
            
            
            
                Text("Tap 'dorodoro' to get your total work stats")
                    .bold()
                    .foregroundColor(.white)
                    
            Text("Tap to dismiss")
                .foregroundColor(.white.opacity(0.8))
            
            Spacer(minLength: 50)
            
        }
        .padding()
        .padding(.top, 40)
        .frame(width: UIScreen.main.bounds.width, height: 150)
        .background(Color(#colorLiteral(red: 0.2511832416, green: 0.6168131232, blue: 0.8950596452, alpha: 1)))
    }
    
    func createTopFloaterView() -> some View {
        VStack(alignment: .leading) {
            
             Text("Total Work Minutes: \(WorkMinutesTotal)")
                .foregroundColor(.white)
                .bold()
                .font(.title2)
                .padding(.bottom)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: capsuleWidth, height: 5)
                    .foregroundColor(Color(returnColorForTotalWorkTime(totalWorkTime: WorkMinutesTotal)[0]))
                Capsule()
                    .frame(width: CGFloat(Double(WorkMinutesTotal) / Double(WorkMinutesTotal + returnMinutesUntilNextRank(totalWorkTime: WorkMinutesTotal))) * capsuleWidth, height: 5)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
            
            Text(WorkMinutesTotal > 1001 ? "Already at highest rank" : "\(returnMinutesUntilNextRank(totalWorkTime: WorkMinutesTotal)) minutes until next rank")
                .foregroundColor(Color.white.opacity(0.7))
               .bold()
               .font(.title3)
                .padding(.top)
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 150)
        .background(Color(returnColorForTotalWorkTime(totalWorkTime: WorkMinutesTotal)[1]))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.8), radius: 0.25, x: 0, y: 0)
    }
    
    private func returnMinutesUntilNextRank(totalWorkTime: Int) -> Int {
        switch totalWorkTime {
        case 0...60:
            return 61 - totalWorkTime
        case 61...150:
            return 151 - totalWorkTime
        case 151...500:
            return 501 - totalWorkTime
        case 501...1000:
            return 1001 - totalWorkTime
        default:
            return -1
        }

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




