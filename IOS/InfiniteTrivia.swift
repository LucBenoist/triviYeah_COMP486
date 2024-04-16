//
//  InfiniteTrivia.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 3/25/24.
//

import SwiftUI
import SwiftData

struct Response: Decodable{
    let response_code: Int
    let results: [Question]
}
struct Question: Decodable{
    let type: String
    let difficulty: String
    let category: String
    var question: String
    var correct_answer: String
    let incorrect_answers: [String]
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(.navy)
            .padding()
            .frame(width: 145, height: 27)
            .background(configuration.isPressed ? Color(.hotPink) : Color(.skyTeal))
            .cornerRadius(13.5)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 13.5)
                    .stroke(Color(.hotPink), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Scale effect on press
    }
}

struct InfiniteTriviaView: View {
    @State private var questions: [Question] = []
    @State private var question_index: Int?
    @State private var userAnswer: String = ""
    @State private var isCorrect: Bool? = nil
    @State private var useHint: Bool = false
    @State private var streakCount: Int = 0
    @State private var answered_correctly: Set<Int> = []
    @State private var hintUsed = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Navy")
                    .ignoresSafeArea()
                
                Rectangle()
                    .stroke(Color.hotPink, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack{
                    Text("Welcome To Infinite TriviYeah!")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(.skyTeal)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 525)
                }
                
                
                VStack{
                    Text("How many can you get??")
                        .font(Font.custom("Arial Rounded MT Bold", size: 11))
                        .fontWeight(.medium)
                        .foregroundColor(.lime)
                        .multilineTextAlignment(.center)
                    Text("Your Streak: \(streakCount)")
                        .font(Font.custom("Arial Rounded MT Bold", size: 11))
                        .fontWeight(.medium)
                        .foregroundColor(.lime)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 30){
                    Button(action: {
                        Fetches()
                        isCorrect = nil
                        useHint = false
                    }) {
                        Text("Click for Question!")
                    }
                    .buttonStyle(CustomButtonStyle())
                                 
                                 
                    if let questionIndex = question_index{
                        Text(questions[questionIndex].question)
                            .foregroundColor(.white)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 25)
                        TextField("Answer Here", text: $userAnswer)
                            .foregroundColor(.skyPurple)
                            .padding()
                    }
                    
                    Button(action: {
                        Checks()
                    }) {
                        Text("Check Answer")
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    if let isCorrect = isCorrect{
                        if isCorrect {
                            Text("CORRECT")
                                .font(Font.custom("Arial Rounded MT Bold", size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(.pathG)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        else {
                            Text("INCORRECT").font(Font.custom("Arial Rounded MT Bold", size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                        //Button(action: {
                         //   ChecksHint()
                         //   hintUsed = true
                        //}) {
                          //  if useHint{
                            //    var joined_answers = joinAnswers(incorrectAnswers: questions[question_index!].incorrect_answers, correctAnswer: questions[question_index!].correct_answer)
                                //Text(joined_answers).foregroundColor(.white).multilineTextAlignment(.center)
                                  //  .padding()
                            //}
                            //Text("Click for Hint!")
                             //   .font(Font.custom("Arial Rounded MT Bold", size: 11))
                              //  .fontWeight(.medium)
                              //  .foregroundColor(.skyPurple)
                              //  .multilineTextAlignment(.center)
                              //  .padding()
                        //}
                        //.buttonStyle(CustomButtonStyle())
                        
                        Button(action: {
                            ChecksHint()
                            //userAnswer = " "
                        }) {
                            if useHint{
                                Text(questions[question_index!].correct_answer)
                                    .foregroundColor(.white)
                            }
                            Text("Click for Answer!")
                                .font(Font.custom("Arial Rounded MT Bold", size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(.skyPurple)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .buttonStyle(CustomButtonStyle())
                        //.disabled(!hintUsed)
                    //} vstack
                    //} scroll view
                    }
                }
                .padding()
            }
        }
    }
    
    func Fetches(){
        Task {
            do {
                let fetch_questions = try await fetchRandoQuestions()
                questions = fetch_questions
                question_index = Int.random(in: 0..<questions.count)
            }
            catch {
                print(error)
            }
        }
    }
    
    func Checks(){
        if let index = question_index {
            if userAnswer == questions[index].correct_answer {
                isCorrect = true
                if !answered_correctly.contains(index) {
                    streakCount += 1
                    answered_correctly.insert(index)
                }
            }
            else {
                isCorrect = false
                streakCount = 0
            }
        }
    }
    
    func ChecksHint(){
        if isCorrect == false{
            useHint = true
        }
        else{
            useHint = false
        }
    }
    
    func fetchRandoQuestions() async throws-> [Question] {
        let url = URL(string: "https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple")!
        let(data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        
        var decodedQuestions = decoded.results
        for index in 0..<decodedQuestions.count {
            decodedQuestions[index].question = decodeHTMLEncodedString(decodedQuestions[index].question)
            decodedQuestions[index].correct_answer = decodeHTMLEncodedString(decodedQuestions[index].correct_answer)
            }
        return decodedQuestions
        
    }
    
    func decodeHTMLEncodedString(_ htmlEncodedString: String) -> String {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return htmlEncodedString 
        }
        let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attributedString?.string ?? htmlEncodedString
    }
    
    func joinAnswers(incorrectAnswers: [String], correctAnswer: String) -> String {
        var combinedAnswers = incorrectAnswers
        combinedAnswers.append(correctAnswer)
        return combinedAnswers.joined(separator: ", ")
    }
}

#Preview {
    ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
