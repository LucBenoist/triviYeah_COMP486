//
//  Category2.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/26/24.
//

import Foundation
import SwiftUI
struct Category2View: View{
    var body: some View {
            NavigationView {
                VStack{
                    Image("Logo")
                    HStack{
                        
                    }
                    NavigationLink{
                        LinkView()
                    } label: {
                        PrimeButton_(text: "Category3")
                        PrimeButton_(text: "Category4")
                        PrimeButton_(text: "Category5")
                    }
                }
            }
        
    }
}

struct Category2View_Previews: PreviewProvider{
    static var previews: some View{
        Category2View()
    }
}
