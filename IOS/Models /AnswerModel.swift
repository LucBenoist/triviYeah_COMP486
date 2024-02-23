//
//  AnswerModel.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/9/24.
//

import Foundation


struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
