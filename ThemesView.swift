//
//  ThemesView.swift
//  TriviYeah!
//
//  Created by Colby Cook on 4/1/24.
//

import SwiftUI

struct ThemesView: View {
    var body: some View {
        ZStack{
            Color("Navy")
                .ignoresSafeArea()
            VStack{
                Text("DAILY THEMES")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.skyTeal)
                    .padding()
                    
                
                Text("Movie Monday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                Text("Tuesday Tunes")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.lime)
                    .multilineTextAlignment(.center)
                Text("Wednesday Wild")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                Text("TV Thursday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.lime)
                    .multilineTextAlignment(.center)
                Text("Frantic Friday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                Text("Sports Saturday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.lime)
                    .multilineTextAlignment(.center)
                Text("Hist{or}Science Sunday")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: ContentView()) {
                    PrimeButton_(text: "Home Screen")
                    
                }.navigationBarBackButtonHidden(true)
                    .padding()
            }
        }
    }
}

#Preview {
    ThemesView()
}
