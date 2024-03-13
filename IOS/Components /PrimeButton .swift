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
            .font(Font.custom("Arial Rounded MT Bold", size: 30)) // Using custom font
            .foregroundColor(.letterGreen)
            .frame(width: 80, height: 28) // Set width and height
            .padding()
            .background(background)
            .cornerRadius(0) // Remove corner radius
            .shadow(radius: 5) // Adjust shadow radius
    }
}

struct PrimeButton_Previews: PreviewProvider{
    static var previews: some View{
        PrimeButton_(text: "Next")
    }
}
