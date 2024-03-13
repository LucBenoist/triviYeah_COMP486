//
//  PrimeButton .swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/9/24.
//

import SwiftUI

struct PrimeButton_: View {
    var text: String
    var background: Color = Color(.hotPink)
    
    var body: some View {
        Text(text)
            .font(Font.custom("Arial Rounded MT Bold", size: 20)) // Using custom font
            .padding(10) // Adjust padding
            .background(background)
            .foregroundColor(.letterGreen)
            .shadow(radius: 5) // Adjust shadow radius
    }
}

struct PrimeButton_Previews: PreviewProvider{
    static var previews: some View{
        PrimeButton_(text: "Next")
    }
}
