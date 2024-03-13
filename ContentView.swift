//
//  ContentView.swift
//  TriviYeah!
//


import SwiftUI
var theme = getTheme(day:"Saturday")
var questions_dict = question_caller()
var path_rectangle = Rectangle()


//Replica Path used for assigning color
var colorPath: [Int: Color] = [0: Color("Path Gray"),
                                 1: Color("Path Gray"),
                                 2: Color("Path Gray"),
                                 3: Color("Path Gray"),
                                 4: Color("Path Gray"),
                                 5: Color("Path Gray"),
                                 6: Color("Path Gray"),
                                 7: Color("Path Gray"),
                                 8: Color("Path Gray"),
                                 9: Color("Path Gray"),
                                10: Color("Path Gray")]

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

// Establish Startting at Path 0 and Round 1
var path_node: Int = 0
var round_num: Int = 1
var final_answer = ""

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("Navy")
                    .ignoresSafeArea()
                VStack {
                    Text("TriviYeah!")
                        .font(Font.custom("Arial Rounded MT Bold", size: 60)) // Custom font and increased size
                        .fontWeight(.heavy)
                        .foregroundColor(.letterGreen)
                        .multilineTextAlignment(.center)
                    Spacer() // Pushes everything else to the bottom
                    Text("The Daily Trivia Game")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.letterGreen)
                        .multilineTextAlignment(.center)
                    NavigationLink {
                        // Start Daily Trivia Game
                        QuestionView()
                    } label: {
                        PrimeButton_(text: "Play")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}




//Question Scene and Round Play
struct QuestionView: View{
    @State private var answer = ""
    @State private var isCorrect: Bool?
    var body: some View {
        NavigationView{
            ZStack{
                Color("Navy")
                    .ignoresSafeArea()
                VStack {
                    // Round 1
                    // Round 1
                    if round_num == 1{
                        Text("Round: \(round_num)")
                            .font(.title)
                            .padding()
                            .foregroundStyle(Color("Lime"))
                        Text((path[0]![0])) //Q0
                            .foregroundStyle(Color("Lime"))
                            .padding()
                        TextField("Enter your answer...", text: $answer) // Text Box for user answer
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        // Upon Submitting, check if user answer is correct
                        Button("Submit") {
                            if answer == "\(path[0]![1])"{
                                colorPath[path_node] = Color("PathG") // Update color at path node to green
                                isCorrect = true}
                            // Got it wrong
                            else{
                                colorPath[path_node] = Color("PathR") // Update color at path node to red
                                isCorrect = false}
                        }
                        .padding()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .disabled(answer.isEmpty) // look into
                        
                        
                        if isCorrect == true { //Tells user they are correct and moves to the sub cat selection screen
                            Text("Correct!")
                                .foregroundColor(.green)
                            NavigationLink(destination: CategoryView()){
                                
                                PrimeButton_(text: "Continue")
                            }.onAppear {
                                    round_num += 1
                                }
                        }
                        else if isCorrect == false{
                            // Their game is over and are taken to GameOverView
                            Text("Incorrect!")
                                .foregroundColor(.red)
                            NavigationLink(destination: GameOverView()){
                                PrimeButton_(text: "Continue")
                            }
                        }
                        
                    }
                    // As long as not starting or final round
                    // As long as not starting or final round
                    else if round_num != 5 {
                        Text("Round: \(round_num)")
                            .font(.title)
                            .padding()
                            .foregroundStyle(Color("Lime"))
                        Text((path[path_node]![0])) //Question stored at path node
                            .padding()
                            .foregroundStyle(Color("Lime"))
                        TextField("Enter your answer...", text: $answer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        // Checking user's answer
                        Button("Submit") {
                            if answer == "\(path[path_node]![1])"{
                                colorPath[path_node] = Color("PathG")
                                isCorrect = true}
                            else{
                                colorPath[path_node] = Color("PathR")
                                isCorrect = false}
                            
                        }
                        
                        
                        .padding()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/) //look into
                        .disabled(answer.isEmpty)
                        
                        
                        if round_num != 4{ // Not Round 4, then if correct answer go to CategoryView
                            if isCorrect == true { //Tells user they are correct and moves to the sub cat selection screen
                            Text("Correct!")
                                .foregroundColor(.green)
                            NavigationLink(destination: CategoryView()){
                                
                                PrimeButton_(text: "Continue")
                            }.onAppear {
                                round_num += 1
                            }
                        }
                        else if isCorrect == false{
                            // Their game is over and are taken to GameOverView
                            Text("Incorrect!")
                                .foregroundColor(.red)
                            NavigationLink(destination: GameOverView()){
                                PrimeButton_(text: "Continue")
                            }
                        }
                    }
                        else{ // If correct at Round 4, go to final round
                            if isCorrect == true {
                                Text("Correct!")
                                    .foregroundColor(.green)
                                NavigationLink(destination: QuestionView()){
                                    PrimeButton_(text: "Let's Go to the Final Round")
                                }.onAppear {
                                        round_num += 1
                                    }
                                
                            }
                            else if isCorrect == false { // Incorrect, gameplay is over
                                Text("Incorrect!")
                                    .foregroundColor(.red)
                                NavigationLink(destination: GameOverView()){
                                    PrimeButton_(text: "Continue")
                                }
                            }
                        
                        }
                        //Jon Rahm
                    }
                    else{ // Final Round Branch
                        Text("FINAL ROUND")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color("Lime"))
                        Text((path[10]![0])) // Final question
                            .padding()
                            .foregroundStyle(Color("Lime"))
                        TextField("Enter your answer...", text:$answer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of:answer) {
                                    final_answer = answer
                                }
                        
                        // Checking final answer
                       // Button("Results") {
                        NavigationLink(destination: GameOverView()){
                            PrimeButton_(text: "Results")
                        }
                            .padding()
                            .foregroundColor(.blue)
                            
                        }
                    }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
        



struct CategoryView: View{
    var body: some View {
            NavigationView {
                ZStack{
                    Color("Navy")
                        .ignoresSafeArea()
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
                }
            }.navigationBarBackButtonHidden(true)
        
    }
}





//Game Over scene
struct GameOverView: View{
    var body: some View {
        NavigationView{
            ZStack{
                Color("Navy")
                    .ignoresSafeArea()
                VStack{
                    Text("Game Over!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.purple)
                    
                    if final_answer == path[10]![1] {
                        Text("Congratulations, You got a TriviYeah!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("PathG"))
                    }
                    else{
                        Text("Maybe next time Sport!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("PathR"))
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
                    if final_answer == path[10]![1]{
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(Color("PathG"))
                    }
                    
                    else if final_answer != path[10]![1] && round_num == 5{
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(Color("PathR"))
                    }
                    else{
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(Color(.gray))
                    }
                    
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
