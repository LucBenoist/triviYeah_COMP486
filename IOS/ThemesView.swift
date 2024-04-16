//
//  ThemesView.swift
//  TriviYeah!
//
//  Created by Colby Cook on 4/2/24.
//

import SwiftUI

struct ThemesView: View {
    var body: some View {
        ZStack{
            Color(Color.black)
                .ignoresSafeArea()
            
            Rectangle()
                .stroke(Color.hotPink, lineWidth: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("DAILY THEMES")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.skyYellow)
                    .padding()
                    
                
                Text("Movie Monday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                Text("Tuesday Tunes")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.skyYellow)
                    .multilineTextAlignment(.center)
                Text("Wednesday Wild")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                Text("TV Thursday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.skyYellow)
                    .multilineTextAlignment(.center)
                Text("Frantic Friday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                Text("Sports Saturday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.skyYellow)
                    .multilineTextAlignment(.center)
                Text("Hist{or}Science Sunday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: DailyGameView()) {
                    PrimeButton_(text: "Back")
                    
                }.navigationBarBackButtonHidden(true)
                    .padding()
            }
        }
    }
}

#Preview {
    ThemesView()
}

