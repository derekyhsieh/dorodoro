//
//  StatsPopup.swift
//  dorodoro
//
//  Created by Derek Hsieh on 3/18/21.
//

import SwiftUI

struct StatsPopup: View {
    var body: some View {
        VStack(alignment: .leading) {
            
             Text("Total Work Minutes: 50")
                .foregroundColor(.white)
                .bold()
                .font(.title2)
                .padding(.bottom)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: UIScreen.main.bounds.width - 70, height: 5)
                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                Capsule()
                    .frame(width: UIScreen.main.bounds.width - 100, height: 5)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
            
            Text("10 minutes until next rank")
                .foregroundColor(Color.white.opacity(0.7))
               .bold()
               .font(.title3)
                .padding(.top)
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 150)
        .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.8), radius: 0.25, x: 0, y: 0)
    }
}

struct StatsPopup_Previews: PreviewProvider {
    static var previews: some View {
        StatsPopup()
    }
}
