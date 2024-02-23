//
//  ContentView.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/12/24.
// Charlie TESTING
// HUGO Testing

import SwiftUI


struct ContentView: View{
    var body: some View {
            NavigationView {
                VStack{
                    Image("Logo")
                    HStack{
                        Text("TriviYeah!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                    }
                    NavigationLink{
                        LinkView()
                    } label: {
                        PrimeButton_(text: "GO!")
                    }
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
