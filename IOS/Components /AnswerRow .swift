//
//  AnswerRow .swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/9/24.
//

import SwiftUI

struct AnswerRow_: View {
    var answer: Answer
    @State private var isSelected = false
    
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.711)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "square.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: answer.isCorrect ? "checkmark.seal.fill" : "x.circle.fill")
                    .foregroundColor(answer.isCorrect ? green : red) 
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            isSelected = true
        }
        
    }
}

#Preview {
    AnswerRow_(answer: Answer(text: "Martin Lorenzton", isCorrect: false))
}
