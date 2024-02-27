//
//  GameOverView.swift
//  TriviYeah!
//
//  Created by Hugo Baroody on 2/25/24.
//

import Foundation
import SwiftUI


struct GameOverView: View{
    var body: some View {
        VStack{
            Text("Game Over!")
                .font(.title)
                .padding()
            
            //Figure out a way to  present tree results
            //Ideas(dumb) have an image of the tree for every possible combinations of right and wrong squares and insert the image based on player preformance
            //Have a changeable "game object"?? that changes as the user plays 
        }
    }
}

struct GameOverView_Previews: PreviewProvider{
    static var previews: some View{
        GameOverView()
    }
}
