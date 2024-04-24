//
//  PrimeButton .swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/9/24.
//

import SwiftUI

struct PrimeButton_: View {
    var text: String
    var background: Color = Color(.black)
    let cornerRadius: CGFloat = 13.5 // Half of the button's height
    

    var body: some View {
        Text(text)
            .font(text.count <= 10 ? Font.custom("Arial Rounded MT Bold", size: 26) : text.count <= 12 ? Font.custom("Arial Rounded MT Bold", size: 17) : text.count <= 16 ? Font.custom("Arial Rounded MT Bold", size : 16) : Font.custom("Arial Rounded MT Bold", size : 13))
            .foregroundColor(.skyYellow)
            .frame(width: 128, height: 27)
            .padding()
            .background(background)
            .cornerRadius(cornerRadius)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(.hotPink), lineWidth: 8)
            )
            .buttonStyle(.bordered)
            .controlSize(.regular)
    }
}

struct PrimeButton_Previews: PreviewProvider{
    static var previews: some View{
        ZStack{
                Color(Color.black)
                    .ignoresSafeArea()
            Rectangle()
                .stroke(Color.hotPink, lineWidth: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    PrimeButton_(text: "Back").padding()
                    PrimeButton_(text: "Daily Games").padding()
                }
                PrimeButton_(text: "Better Call Saul").padding()
                PrimeButton_(text: "Saturday Night Live").padding()
                
            }
        }
    }
}
