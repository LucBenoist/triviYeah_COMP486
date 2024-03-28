//
//  PrimeButton .swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/9/24.
//

import SwiftUI

struct PrimeButton_: View {
    var text: String
    var background: Color = Color(.skyTeal)
    

    var body: some View {
        Text(text)
            .font(Font.custom("Arial Rounded MT Bold", size: 22))
            .foregroundColor(.navy)
            .frame(width: 145, height: 27)
            .padding()
            .background(background)
            .cornerRadius(0)
            .shadow(radius: 5)
            .buttonStyle(.bordered)
            .controlSize(.regular)
            .border(Color(.hotPink))
            
    }
}

struct PrimeButton_Previews: PreviewProvider{
    static var previews: some View{
        PrimeButton_(text: "Next")
    }
}
