//
//  QuestionView.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/12/24.
//

import SwiftUI


struct QuestionView: View{
    var body: some View {
        
            
            VStack(spacing: 40){
                HStack(spacing: 5){
                Text("1/10")
                    .foregroundColor(Color.red)
            }
                ProgressBar(progress: 40)
                VStack(spacing: 40){
                Text("Who was one of the cofounders of Spotify?")
                    .foregroundColor(Color.red)
                AnswerRow_(answer: Answer(text: "Martin Lorenzton", isCorrect: true))
                AnswerRow_(answer: Answer(text: "Professor Kugele", isCorrect: false))
            }
                Spacer()
                PrimeButton_(text: "CONTINUE!")
                Spacer()
                
            
        }
            .navigationBarBackButtonHidden()
    
    }
}

struct QuestionView_Previews: PreviewProvider{
    static var previews: some View{
        QuestionView()
    }
}
