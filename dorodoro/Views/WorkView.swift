//
//  WorkView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/11/21.
//

import SwiftUI
import UserNotifications

struct WorkView: View {
    @Binding var appState: Int
    let screen = UIScreen.main.bounds
    @State var showCancelView = false

    @State var timeRemaining: Int
    let fullTime: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var sleep = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
       
            Color(sleep > 10 ? .black : #colorLiteral(red: 0.931381166, green: 0.3872834444, blue: 0.3862845302, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Button(action: {
                    showCancelView = true
                }) {
                    
                  
                    
                        RoundedRectangle(cornerRadius: 26)
                            .fill(Color(sleep > 10 ? .black : #colorLiteral(red: 0.9375395775, green: 0.2406340539, blue: 0.2395618856, alpha: 1)))
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
                    
                    if self.sleep > 10 {
//                        sleep = 0
                    }
                }) {
                    
                   
                    HStack {
                        
                        if sleep > 10 {
                            if timeRemaining > 60 {
                                Text("\(secondsToMinutes(seconds: self.timeRemaining))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 70, design: .rounded))
                                    .bold()
                            } else {
                                Text("\(secondsToMinutesAndSeconds(seconds: self.timeRemaining))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 70, design: .rounded))
                                    .bold()
                            }
                          
                        } else {
                            Text("\(secondsToMinutes(seconds: self.timeRemaining))")
                                .foregroundColor(.white)
                                .font(.system(size: 70, design: .rounded))
                                .bold()
                            Text(":")
                                .foregroundColor(.white)
                                .font(.system(size: 65, design: .rounded))
                                .bold()
                            
                            Text("\(secondsToMinutesAndSeconds(seconds: self.timeRemaining))")
                                .foregroundColor(.white)
                                .font(.system(size: 70, design: .rounded))
                                .bold()
                        }
                
                        
                            
                    }
                    .animation(fullTime > timeRemaining ? .none : .spring())
                            .overlay(
                                    Circle()
                                        .trim(from: CGFloat(Float(fullTime - timeRemaining)/Float(fullTime)), to: 1)
                                        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round))
                                        .foregroundColor(.white)
                                        .rotationEffect(.degrees(270), anchor: .center)
                                        .frame(width: 300, height: 300)
                                        
                                       
                        )
                    
                }
                
                
                Spacer()
                
                Text("")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .padding(.bottom, 50)
                
            }
            
         
            
            if showCancelView {
                CancelAlertView(appState: $appState, show: $showCancelView, workMinutes: Int(secondsToMinutes(seconds: fullTime - timeRemaining)) ?? 0)
                    .edgesIgnoringSafeArea(.all)
            }
       
          
        }
        .onReceive(self.timer) { (_) in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.sleep += 1
            } else {
                UIApplication.shared.isIdleTimerDisabled = false
                appState = 2
               
            }
                      
        }
        .preferredColorScheme(.dark)
        .onTapGesture {
            if self.sleep > 10 {
                sleep = 0
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
            print("user left")
            sendNotification(title: "Stay Focused", subtitle: "Please stay in the app until the work period is over", timeInterval: 2)
        })
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        
    }
    
    
    
    func secondsToMinutes(seconds: Int) -> String {
        let min = Int(seconds/60)
        return "\(min)"
    }
    
    func secondsToMinutesAndSeconds(seconds: Int) -> String {
        let min = Int(seconds/60)
        let secs = seconds - (min * 60)
        
        if secs == 0 {
            return "00"
        } else if secs < 10 {
            return "0\(secs)"
        }
        
        return "\(secs)"
    }
    
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(appState: .constant(1), timeRemaining: 5, fullTime: 5)
    }
}
