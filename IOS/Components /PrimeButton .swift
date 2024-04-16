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
            .font(Font.custom("Arial Rounded MT Bold", size: 22))
            .foregroundColor(.skyYellow)
            .frame(width: 135, height: 27)
            .padding()
            .background(background)
            .cornerRadius(cornerRadius)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(.hotPink), lineWidth: 7)
            )
            .buttonStyle(.bordered)
            .controlSize(.regular)
    }
}

struct PrimeButton_Previews: PreviewProvider{
    static var previews: some View{
        PrimeButton_(text: "Next")
    }
}
