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
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

struct InfiniteTriviaView: View {
    @State private var questions: [Question] = []
    @State private var question_index: Int?
    @State private var userAnswer: String = ""
    @State private var isCorrect: Bool? = nil
    @State private var useHint: Bool = false
    @State private var Streak_count: Int = 0
    
    var body: some View {
        VStack(spacing: 20){
            Text("Welcome To Infinite TriviYeah!").foregroundColor(.purple).font(.system(size: 30))
            Text("How many can you get??").foregroundColor(.purple)
        Text("Your Streak: \(Streak_count)").foregroundColor(.green)
    }
        
        VStack(spacing: 30){
            Button("Click for Question!"){
                Fetches()
                isCorrect = nil
                useHint = false
                
            }
            
            if let question_index = question_index{
                Text(questions[question_index].question)
                    
            }
            
            TextField("Answer Here", text: $userAnswer).padding()
            Button("Check Answer"){
                Checks()
                
            }
            if let isCorrect = isCorrect{
                if isCorrect {
                    Text("CORRECT").foregroundColor(.green)
                        .padding()
                    
                }
                else {
                    
                    Text("INCORRECT").foregroundColor(.red)
                        .padding()
                }
                Button(action: {
                    ChecksHint()
                    
                    }) {
                        if useHint{
                                Text(questions[question_index!].correct_answer)
                                    }
                                Text("Click for Answer!").foregroundColor(.purple)
                    }
            }
        }.padding()
        
    }
    
    func Fetches(){
        Task{
                do {
                    let fetch_questions = try await fetchRandoQuestions()
                    questions = fetch_questions
                    
                    question_index = Int.random(in: 0..<questions.count)
                }catch {
                    print(error)
                }
        }
    }
    
    func Checks(){
        if userAnswer == questions[question_index!].correct_answer{
            isCorrect = true
            Streak_count+=1
        }
        else {
            isCorrect = false
            Streak_count = 0
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
        
        return decoded.results
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
