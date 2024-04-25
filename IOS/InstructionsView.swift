//
//  InstructionsView.swift
//  TriviYeah!
//
//  Created by Colby Cook on 4/2/24.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ZStack{
            Color(Color.black)
                .ignoresSafeArea()
            Rectangle()
                .stroke(Color.hotPink, lineWidth: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("TRIVIYEAH! GAMEPLAY")
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
                    .foregroundColor(.skyYellow)
                    .padding()
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.skyTeal, lineWidth: 3)
                        )
                    
                
                Text("""
                
                -Every day has a theme: Movie Monday, Sports Saturday,etc

                -You will progress through a 5 question gauntlet.

                -Get a question, right, you move to the next round, 
                get a wrong and your game is over for the day.

                -After getting a question right, you will be able to
                choose the subcategory for the next question,
                until the final round.

                -If you get the final question right, you got a
                perfect game, a TriviYeah!.

                -At the end, whether you got a question wrong or
                got a TriviYeah!, a path will be displayed
                that reflects your gameplay that can be
                shared with friends.
                """).multilineTextAlignment(.center)
                    .font(Font.custom("Arial Rounded MT Bold", size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.skyYellow)
                    .multilineTextAlignment(.center)
                
                HStack{
                    NavigationLink(destination: PathView()) {
                        PrimeButton_(text: "Path?")
                        
                    }.navigationBarBackButtonHidden(true)
                        .padding()
                        
                    
                    NavigationLink(destination: ThemesView()) {
                        PrimeButton_(text: "Themes")
                        
                    }.navigationBarBackButtonHidden(true)
                        .padding()
                        
                }.padding()
                NavigationLink(destination: DailyGameView()) {
                    PrimeButton_(text: "Back")
                    
                }.navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    InstructionsView()
}

