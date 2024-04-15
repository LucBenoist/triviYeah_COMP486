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
            Color("Navy")
                .ignoresSafeArea()
            Rectangle()
                .stroke(Color.hotPink, lineWidth: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
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
