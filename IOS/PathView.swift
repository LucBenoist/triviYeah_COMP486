//
//  PathView.swift
//  TriviYeah!
//
//  Created by Colby Cook on 4/14/24.
//

import SwiftUI

struct PathView: View {
    var body: some View {
        ZStack{
            Color(Color.black)
                .ignoresSafeArea()
            Rectangle()
                .stroke(Color.hotPink, lineWidth: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Here are two examples of Gameplay results. The trees are made of five rows, where each row represents a round. After you progress through each round you can choose between two subcategories. The first round and final round will have one question with no other choices.")
                    .foregroundColor(.skyYellow)
                    .multilineTextAlignment(.center)
                HStack{
                    VStack{
                        Image("Path Results")
                        Text("Here is the result of game where user failed in the third round.")
                            .foregroundColor(.skyYellow)
                            .multilineTextAlignment(.center)
                    }
                    VStack{
                        Image("Perfect Path")
                        Text("Here is the user got a perfect game, a TriviYeah!")
                            .foregroundColor(.skyYellow)
                            .multilineTextAlignment(.center)
                    }
                }
                NavigationLink(destination: InstructionsView()) {
                    PrimeButton_(text: "Back")
                    
                }.navigationBarBackButtonHidden(true)
                    .padding()
            }
        }
    }
}

#Preview {
    PathView()
}
