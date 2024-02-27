//
//  QuestionView.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/12/24.
//

import SwiftUI
// Path Tree has a total of 11 questions possible to reach
// 0 being the tip of the tree
// 1 and 2 Being the option from 0
// 3 and 4 are the options from 1
// 4 and 5 are the options from 2
// 6 and 7 are options from 3
// 7 and 8 are options from 4
// 8 and 9 are options from 5
// 10 is the final question no matter what, it is the stump


//     0
//    1 2
//   3 4 5
//  6 7 8 9
//    10


//Questions are pulled at index 0 of all lists stored in the path dictionary
    // ex) question 1 will be found at path[0]![0]
    // ex) question 5 will be found at path[4]![0]

//Answers are pulled at index 1 of all lists stored in the path dictionary
    // ex) answer 1 will be found at path[0]![1]
    // ex) answer 5 will be found at path[4]![1]

//Subcategories are pulled at index 2 of all lists stored in the path dictionary
    // ex) subcategory of question 1 will be found at path[0]![2]
    // ex) subcategory of question 5 will be found at path[4]![2]


//ROUND ONE
    // question will always come from the list at path[0]
    // If correct, user can choose:
        //Option 1: path[1], display for them the subcat here: path[1]![2]
        //Option 2: path[2], display for them the subcat here: path[2]![2]

//ROUND TWO
    // question will be either:
        //Option 1: path[1]![0]
            //Get question right, user can choose:
              //Option 1 of path[1]: path[3], display for them the subcat here: path[3]![2]
              //Option 2 of path[1]: path[4], display for them the subcat here: path[4]![2]

        //Option 2: path[2]![0]
            //Get question right, user can choose:
               //Option 1 of path[2]: path[4], display for them the subcat here: path[4]![2]
               //Option 2 of path[2]: path[5], display for them the subcat here: path[5]![2]

//ROUND THREE
    // questions will either be:
        //if user chose path[3], then path[3]![0] for q:
            //Get this correct, user can choose:
              //Option 1 of path[3]: path[6], display subcat
              //Option 2 of path[3]: path[7], display subcat

        //if user chose path[4], then path[4]![0] for q:
            //Get this correct, user can choose:
              //Option 1 of path[4]: path[7], display subcat
              //Option 2 of path[4]: path[8], display subcat

       //if user chose path[5], then path[5]![0] for q:
            //Get this correct, user can choose:
              //Option 1 of path[5]: path[8], display subcat
              //Option 2 of path[5]: path[9], display subcat

//ROUND FOUR
  // questions will either be:
    // path[6]![0]
    // path[7]![0]
    // path[8]![0]
    // path[9]![0]
    
    //If they get correct, there will be no options to choose, maybe display congrats and ask to go to final round


//FINAL ROUND
    //Will always be path[10]![0]
    //correct or wrong go to results page, display their path, and congrat them on getting a TriviYeah or like a
    //oh no you were so close

    
//If users get it wrong, game ends, update the color node stored at the colorpath to red, send them to results page

//whenever get round question right, update the color node stored at the colorpath as green


// can use gamePLay function and script as reference if stuck on anything


// Get Day of Week
// Testing so right now it is Saturday
var theme = getTheme(day:"Saturday")
var questions_dict = question_caller()


//Replica Path used for assigning color
var colorPath: [Int: UIColor] = [0: .gray,
                                 1: .gray,
                                 2: .gray,
                                 3: .gray,
                                 4: .gray,
                                 5: .gray,
                                 6: .gray,
                                 7: .gray,
                                 8: .gray,
                                 9: .gray,
                                10: .gray]

// Create Path process
var daily_path = [Int: [String]]()
func create_path() -> [Int: [String]] {
    for i in 0...10 {
        if let value = questions_dict[i] {
            daily_path[i] = value
        }
    }
    questions_dict.removeAll()
    return daily_path
}



//creates path with question_dict that has the 11 questions, answers, subcats ready for the day
var path = create_path()






let randomRow = Int.random(in:0..<path.count)
let randomQuestion = path[randomRow]![0]
var count: Int = 0

struct QuestionView: View{
    @State private var answer = ""
    @State private var isCorrect = false
    var body: some View {
        VStack {
            
            Text("Round: \(count + 1)")
                .font(.title)
                .padding()
            
            
            Text("Question: \(randomQuestion)") //Change so it iterates over all the questions instead of hard code
                .padding()
            
            TextField("Enter your answer", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Submit") {
                //Change logic so the right answer is checked and its not hard coded
                if answer == "\(path[randomRow]![1])"{
                    isCorrect = true}
                else{
                    isCorrect = false}
                
                }
            .padding()
            .disabled(answer.isEmpty)
            
            if isCorrect {
                //Tells user they are correct and moves to the sub cat selection screen
                Text("Correct!")
                    .foregroundColor(.green)
                NavigationLink(destination: CategoryView()){
                    PrimeButton_(text: "Continue")
                }
                
            }
            else{
                //Finishes the game and shows tree progress
                Text("Incorrect!")
                    .foregroundColor(.red)
                NavigationLink(destination: GameOverView()){
                    PrimeButton_(text: "Continue")
                    
                }
                }
            }
            }
            
            
            
        }

    

struct QuestionView_Previews: PreviewProvider{
    static var previews: some View{
        QuestionView()
    }
    
    
    
}
