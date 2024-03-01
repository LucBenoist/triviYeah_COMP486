//
//  ContentView.swift
//  TriviYeah!
//
//  Created by Luc Benoist on 2/12/24.
// Charlie TESTING
// HUGO Testing

import SwiftUI
var theme = getTheme(day:"Saturday")
var questions_dict = question_caller()
var path_rectangle = Rectangle()


//Replica Path used for assigning color
var colorPath: [Int: Color] = [0: .gray,
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



var path_node: Int = 0
var round_num: Int = 1
struct ContentView: View{
    var body: some View {
            NavigationView {
                VStack{
                    HStack{
                        Text("TriviYeah!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.purple)
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



//LinkView
struct LinkView: View {
    var body: some View {
        QuestionView()
    }
}






//Question Scene
//Round Play
struct QuestionView: View{
    @State private var answer = ""
    @State private var isCorrect: Bool?
    var body: some View {
        VStack {
            
            
            if round_num == 1{
                Text("Round: \(round_num)")
                    .font(.title)
                    .padding()
                Text("Question: \(path[0]![0])")
                    .padding()
                TextField("Enter your answer", text: $answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Submit") {
                    //Change logic so the right answer is checked and its not hard coded
                    if answer == "\(path[0]![1])"{
                        colorPath[path_node] = .green
                        isCorrect = true}
                    else{
                        colorPath[path_node] = .red
                        isCorrect = false}
                    
                    }
                .padding()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .disabled(answer.isEmpty)
                
            }
                else if round_num != 5 {
                        Text("Round: \(round_num)")
                            .font(.title)
                            .padding()
                        Text("Question: \(path[path_node]![0])")
                            .padding()
                        TextField("Enter your answer", text: $answer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button("Submit") {
                            //Change logic so the right answer is checked and its not hard coded
                            if answer == "\(path[path_node]![1])"{
                                colorPath[path_node] = .green
                                isCorrect = true}
                            else{
                                colorPath[path_node] = .red
                                isCorrect = false}
                            
                        }
                        .padding()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/) //look into
                        .disabled(answer.isEmpty)
                    
                }
            else{
                Text("FINAL ROUND")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.purple)
                Text("Question: \(path[10]![0])")
                    .padding()
                TextField("Enter your answer", text: $answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Submit") {
                    //Change logic so the right answer is checked and its not hard coded
                    if answer == "\(path[10]![1])"{
                        path_node = 10
                        colorPath[path_node] = .green
                        isCorrect = true}
                    else{
                        path_node = 10
                        colorPath[path_node] = .red
                        isCorrect = false}
                    
                }
                .padding()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .disabled(answer.isEmpty)
            
        }
            
                
            }
            
            
        if round_num != 4 && round_num != 5{
            if isCorrect == true {
                //Tells user they are correct and moves to the sub cat selection screen
                Text("Correct!")
                    .foregroundColor(.green)
                NavigationLink(destination: CategoryView()){

                    PrimeButton_(text: "Continue")
                }.navigationBarBackButtonHidden(true)
                .onAppear {
                        round_num += 1
                    }
                
            }
            else if isCorrect == false{
                //Finishes the game and shows tree progress
                Text("Incorrect!")
                    .foregroundColor(.red)
                NavigationLink(destination: GameOverView()){
                    PrimeButton_(text: "Continue")
                    
                }.navigationBarBackButtonHidden(true)
                }
        }
        else if round_num == 4{
            if isCorrect == true {
                //Tells user they are correct and moves to the sub cat selection screen
                Text("Correct!")
                    .foregroundColor(.green)
                NavigationLink(destination: QuestionView()){

                    PrimeButton_(text: "Continue")
                }.navigationBarBackButtonHidden(true)
                .onAppear {
                        round_num += 1
                    }
                
            }
            else if isCorrect == false {
                //Finishes the game and shows tree progress
                Text("Incorrect!")
                    .foregroundColor(.red)
                NavigationLink(destination: GameOverView()){
                    PrimeButton_(text: "Continue")
                    
                }.navigationBarBackButtonHidden(true)
                }
        } else{
            if isCorrect == true {
                //Tells user they are correct and moves to the sub cat selection screen
                Text("Correct!")
                    .foregroundColor(.green)
                NavigationLink(destination: GameOverView()){

                    PrimeButton_(text: "Continue")
                }.navigationBarBackButtonHidden(true)
                .onAppear {
                        round_num += 1
                    }
                
            }
            else if isCorrect == false {
                //Finishes the game and shows tree progress
                Text("Incorrect!")
                    .foregroundColor(.red)
                NavigationLink(destination: GameOverView()){
                    PrimeButton_(text: "Continue")
                    
                }.navigationBarBackButtonHidden(true)
                }
        }

            }
            }
        



struct CategoryView: View{
    var body: some View {
            NavigationView {
                VStack{
                    Text("Pick Next Round's Category!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.purple)
                        
                    HStack{
                        
                        if round_num == 2{
                            NavigationLink(destination: QuestionView()) {
                                PrimeButton_(text: path[1]![2])
                                
                                
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                path_node = 1
                            })
                            NavigationLink(destination: QuestionView()){
                                PrimeButton_(text: path[2]![2])
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                path_node = 2
                            })
                        }
                        else if round_num == 3{
                            if path_node == 1{
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[3]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 3
                                })
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[4]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 4
                                })
                            }
                            else{
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[4]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 4
                                })
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[5]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 5
                                })
                            }
                        }
                        else{
                            if path_node == 3{
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[6]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 6
                                })
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[7]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 7
                                })
                            }
                            else if path_node == 4{
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[7]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 7
                                })
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[8]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 8
                                })
                            }
                            else{
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[8]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 8
                                })
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[9]![2])
                                }.simultaneousGesture(TapGesture().onEnded {
                                    path_node = 9
                                })
                            }
                        }
                        
                    }
                }
            }.navigationBarHidden(true)
        
    }
}





//Game Over scene
struct GameOverView: View{
    var body: some View {
        VStack{
            Text("Game Over!")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.purple)
            
           if round_num == 6{
                Text("Congratulations, You got a TriviYeah!")
                   .font(.largeTitle)
                   .fontWeight(.heavy)
                   .foregroundColor(Color.green)
            }
            else{
                Text("Maybe next time Sport!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.red)
            }
                // Row 1 (Round 1)
                path_rectangle
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(colorPath[0])
                // Row 2 (Round 2)
                HStack{
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[1])
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[2])
                }
                // Row 3 (Round 3)
                HStack{
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[3])
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[4])
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[5])
                    
                }
                // Row 4 (Round 4)
                HStack{
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[6])
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[7])
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[8])
                    path_rectangle .frame(width: 50.0, height: 50.0)
                        .foregroundColor(colorPath[9])
                }
                // Row 5 (Round 5)
                path_rectangle .frame(width: 50.0, height: 50.0)
                    .foregroundColor(colorPath[10])
                
            }
            //Figure out a way to  present tree results
            //Ideas(dumb) have an image of the tree for every possible combinations of right and wrong squares and insert the image based on player preformance
            //Have a changeable "game object"?? that changes as the user plays
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
