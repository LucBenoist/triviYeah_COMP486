//
//  CategoryView.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/26/24.
//

import SwiftUI


struct CategoryView: View{
    var body: some View {
            NavigationView {
                VStack{
                    Image("Logo")
                    HStack{
                        
                    }
                    NavigationLink{
                        LinkView()
                    } label: {
                        PrimeButton_(text: "Category1")
                        PrimeButton_(text: "Category2")
                    }
                }
            }
        
    }
}

struct CategoryView_Previews: PreviewProvider{
    static var previews: some View{
        CategoryView()
    }
}


