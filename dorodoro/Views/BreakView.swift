//
//  BreakView.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/12/21.
//

import SwiftUI

struct BreakView: View {
    @Binding var appState: Int
    let screen = UIScreen.main.bounds

    @State var timeRemaining: Int
    let fullTime: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var sentBreakNotification = false
    @State private var leftDateTime = Date()
    
    var body: some View {
        ZStack(alignment: .bottom) {
       
            Color(#colorLiteral(red: 0.3074240088, green: 0.6465219855, blue: 0.8867322803, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Button(action: {
                    
                }) {
                    
                  
                    
                        RoundedRectangle(cornerRadius: 26)
                            .fill(Color(#colorLiteral(red: 0.1468301713, green: 0.540907383, blue: 0.9414213896, alpha: 1)))
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
                    Text("break")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.leading, 30)
                        
                    Spacer()
                }
                
                //Play button
                Spacer()
             
                Button(action: {
                    
               
                }) {
                    
                   
                    HStack {
                        
                     
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
            
         
            
       
          
        }
        .onAppear {
            
            
            playSound(sound: "success", type: "mp3")
            sendNotification(title: "Work period is over", subtitle: "Take a short break", timeInterval: 1)
            sendNotification(title: "break is over", subtitle: "Let's get back to work", timeInterval: TimeInterval(fullTime))
            
        }
        .onReceive(self.timer) { (_) in
            if self.timeRemaining > 0 {
                
                self.timeRemaining -= 1
                print(self.timeRemaining)
                
            } else {
         
                appState = 0
            }
                      
        }
        .preferredColorScheme(.dark)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
            self.leftDateTime = Date()
            
                let formatter = DateFormatter()
                formatter.timeStyle = .long
                formatter.dateStyle = .medium
            
            print(formatter.string(from: leftDateTime))
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
            
            let currentDateTime = Date()
            
            let difference = Calendar.current.dateComponents([.second], from: leftDateTime, to: currentDateTime)
            
            if self.timeRemaining - (difference.second ?? 0) < 0 {
                self.timeRemaining = 0
            } else {
                self.timeRemaining -= difference.second ?? 0
            }
         
            
            
        })

        
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

struct BreakView_Previews: PreviewProvider {
    static var previews: some View {
        BreakView(appState: .constant(2), timeRemaining: 30, fullTime: 30)
    }
}
