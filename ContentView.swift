//
//  ContentView.swift
//  TriviYeah!
//


import SwiftUI
var day = "Thursday"
var theme = getTheme(day: day)

var questions_dict = question_caller()
var path_rectangle = Rectangle()

struct PathData {
    var color: Color
    var symbol: String
}

//Replica Path used for assigning color
var colorPath: [Int: PathData] = [
    0: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    1: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    2: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    3: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    4: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    5: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    6: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    7: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    8: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    9: PathData(color: Color("Path Gray"), symbol: "⬜️"),
    10: PathData(color: Color("Path Gray"), symbol: "⬜️")
]

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
var row_1 = "⬜️"
var row_2 = "⬜️⬜️"
var row_3 = "⬜️⬜️⬜️"
var row_4 = "⬜️⬜️⬜️⬜️"
var row_5 = "⬜️"
var pattern = """
\(theme) \(day)
        \(row_1)
     \(row_2)
  \(row_3)
\(row_4)
        \(row_5)
n/5: Message!
"""

//var isButtonClicked = false // Track if the button is clicked

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()
    var body: some View {
        NavigationView {
            ZStack {
                Color("Navy")
                    .ignoresSafeArea()
                
                // outline
                Rectangle()
                    .stroke(Color.hotPink, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("TriviYeah!")
                         .font(.system(size: 70))
                         .fontWeight(.heavy)
                         .foregroundColor(.skyTeal)
                         .padding(.top, 150)
                 
                    
                    Text("The Daily Trivia Game")
                        .font(Font.custom("Arial Rounded MT Bold", size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.lime)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink {
                        QuestionView()
                    } label: {
                        PrimeButton_(text: "Daily Game")
                    }
                    .padding()
                    
                    NavigationLink{
                        HeadToHeadView()
                    }label:{
                        PrimeButton_(text:"Head 2 Head")}
                    .padding()
                    
                    NavigationLink{
                        InfiniteTriviaView()
                    }label:{
                        PrimeButton_(text:"Infinite Trivia")}
                    .padding()
                    
                    NavigationLink{
                        ThemesView()
                    }label:{
                        PrimeButton_(text:"Daily Themes")}
                    .padding()
                    
                    
                    }
                }
               
            }.navigationBarBackButtonHidden(true)
        }
        //.navigationBarBackButtonHidden(true)
    }


//Question Scene and Round Play
struct QuestionView: View{
    @State private var answer = ""
    @State private var isCorrect: Bool?
    @State private var isButtonClicked: Bool?
    @State private var showSuggestions = false
    @State private var selectedSuggestion: String?
    
    var filteredSuggestions: [String] {
            if answer.isEmpty {
                return []
            } else {
                return guesses.filter { $0.localizedCaseInsensitiveContains(answer) }
            }
        }
    var body: some View {
        NavigationView{
            ZStack{
                Color("Navy")
                    .ignoresSafeArea()
                
                Rectangle()
                    .stroke(Color.hotPink, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Round 1
                    if round_num == 1{
                        Text("Round \(round_num)")
                            .padding()
                            .font(.system(size: 50))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.skyTeal)
                        Text((path[0]![0])) //Q0
                            .foregroundStyle(Color.lime)
                            .padding()
                        TextField("Enter your answer...", text: $answer, onEditingChanged: { isEditing in
                                            self.showSuggestions = isEditing
                                        }) // Text Box for user answer
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        if showSuggestions && !filteredSuggestions.isEmpty {
                            List(filteredSuggestions, id: \.self) { suggestion in
                                Button(action: {
                                    self.selectedSuggestion = suggestion
                                    self.answer = suggestion
                                    self.showSuggestions = false
                                }) {
                                    Text(suggestion)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .frame(maxHeight: 200)
                        }
                        
                        if isButtonClicked != true {
                            // Show the "Submit" button only if it's not clicked
                            Button("Submit") {
                                // Your submit logic here
                                isButtonClicked = true // Set the flag to true when clicked
                                if answer == "\(path[path_node]![1])" {
                                    colorPath[path_node]?.color  = Color("PathG")
                                    colorPath[path_node]?.symbol = "🟩"
                                    isCorrect = true
                                } else {
                                    colorPath[path_node]?.color  = Color("PathR")
                                    colorPath[path_node]?.symbol = "🟥"
                                    isCorrect = false
                                }
                            }
                            .padding()
                            .foregroundColor(.blue)
                            .disabled(answer.isEmpty)
                        }
                        
                        if isCorrect == true { //Tells user they are correct and moves to the sub cat selection screen
                            Text("Correct!")
                                .foregroundColor(.green)
                            NavigationLink(destination: CategoryView()) {
                                PrimeButton_(text: "Continue")
                            }
                            .onTapGesture {
                                isButtonClicked = false // Reset the button clicked state
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
                    else if round_num != 5 {
                        Text("Round \(round_num)")
                            .font(.system(size: 50))
                            .fontWeight(.heavy)
                            .padding()
                            .foregroundStyle(Color.skyTeal)
                        Text((path[path_node]![0])) //Question stored at path node
                            .padding()
                            .foregroundStyle(Color.lime)
                        TextField("Enter your answer...", text: $answer, onEditingChanged: { isEditing in
                                            self.showSuggestions = isEditing
                                        }) // Text Box for user answer
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        if showSuggestions && !filteredSuggestions.isEmpty {
                            List(filteredSuggestions, id: \.self) { suggestion in
                                Button(action: {
                                    self.selectedSuggestion = suggestion
                                    self.answer = suggestion
                                    self.showSuggestions = false
                                }) {
                                    Text(suggestion)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .frame(maxHeight: 200)
                        }

                        // Is this needed?
                        //.padding()
                        //.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/) //look into
                        //.disabled(answer.isEmpty)
                        
                        if isButtonClicked != true {
                            // Show the "Submit" button only if it's not clicked
                            Button("Submit") {
                                // Your submit logic here
                                isButtonClicked = true // Set the flag to true when clicked
                                if answer == "\(path[path_node]![1])" {
                                    colorPath[path_node]?.color = Color("PathG")
                                    colorPath[path_node]?.symbol = "🟩"
                                    
                                    isCorrect = true
                                } else {
                                    colorPath[path_node]?.color  = Color("PathR")
                                    colorPath[path_node]?.symbol = "🟥"
                                    isCorrect = false
                                }
                            }
                            .padding()
                            .foregroundColor(.blue)
                            .disabled(answer.isEmpty)
                        }
                
                        if round_num != 4{ // Not Round 4, then if correct answer go to CategoryView
                            if isCorrect == true { //Tells user they are correct and moves to the sub cat selection screen
                                Text("Correct!")
                                    .foregroundColor(.green)
                                NavigationLink(destination: CategoryView()) {
                                    PrimeButton_(text: "Continue")
                                }
                                .onTapGesture {
                                    isButtonClicked = false // Reset the button clicked state
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
                                NavigationLink(destination: QuestionView()) {

                                    PrimeButton_(text: "Final Round!")
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    path_node = 1
                                })
                                .onTapGesture {
                                    isButtonClicked = false // Reset the button clicked state
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
                            .font(.system(size: 50))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.skyTeal)
                        Text((path[10]![0])) // Final question
                            .padding()
                            .foregroundStyle(Color.lime)
                        TextField("Enter your answer...", text: $answer, onEditingChanged: { isEditing in
                                            self.showSuggestions = isEditing
                                        }) // Text Box for user answer
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of:answer) {
                                final_answer = answer
                                if final_answer == path[10]![1]{
                                    colorPath[10]?.symbol = "🟩"
                                } else{
                                    colorPath[10]?.symbol = "🟥"
                                }
                            }
                        if showSuggestions && !filteredSuggestions.isEmpty {
                            List(filteredSuggestions, id: \.self) { suggestion in
                                Button(action: {
                                    self.selectedSuggestion = suggestion
                                    self.answer = suggestion
                                    self.showSuggestions = false
                                }) {
                                    Text(suggestion)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .frame(maxHeight: 200)
                        }
                        
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
                    
                    Rectangle()
                        .stroke(Color.hotPink, lineWidth: 4)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Text("Pick Next Round's Category!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.skyTeal)
                            .multilineTextAlignment(.center)
                        
                        
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
                Rectangle()
                    .stroke(Color.hotPink, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("Game Over!")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.skyTeal)
                    
                    if final_answer == path[10]![1] {
                        Text("Congratulations, \nYou got a TriviYeah!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("PathG"))
                            .multilineTextAlignment(.center)
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
                        .foregroundColor(colorPath[0]?.color )
                    // Row 2 (Round 2)
                    HStack{
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[1]?.color )
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[2]?.color )
                    }
                    // Row 3 (Round 3)
                    HStack{
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[3]?.color )
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[4]?.color )
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[5]?.color )
                        
                    }
                    // Row 4 (Round 4)
                    HStack{
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[6]?.color )
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[7]?.color )
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[8]?.color )
                        path_rectangle .frame(width: 50.0, height: 50.0)
                            .foregroundColor(colorPath[9]?.color )
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
                    ShareLink(item: """
\(theme) \(day)
        \(colorPath[0]!.symbol)
     \(colorPath[1]!.symbol)\(colorPath[2]!.symbol)
  \(colorPath[3]!.symbol)\(colorPath[4]!.symbol)\(colorPath[5]!.symbol)
\(colorPath[6]!.symbol)\(colorPath[7]!.symbol)\(colorPath[8]!.symbol)\(colorPath[9]!.symbol)
        \(colorPath[10]!.symbol)
\(round_num)/5: Message!
""")
                        .foregroundStyle(Color(.systemBlue))
                        .padding()
                    
                    NavigationLink(destination: ContentView()) {
                        PrimeButton_(text: "Home Screen")
                        
                    }.navigationBarBackButtonHidden(true)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
struct HeadToHeadView: View{
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Navy")
                    .ignoresSafeArea()
                
                Rectangle()
                    .stroke(Color.hotPink, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 5) {
                    HStack {
                       Text("Head to Head")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.skyTeal)
                        .padding(.top, 5)
                       Spacer()
                        Text("\(triviaManager.index + 1) out of \(triviaManager.length)")
                    }
                    ProgressBar(progress: triviaManager.progress)
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text(triviaManager.question)
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .padding()
                            .foregroundStyle(Color.skyYellow)
                        
                        ForEach(triviaManager.answerChoices, id:\.id){ answer in AnswerRow_(answer: answer)
                                .environmentObject(triviaManager)
                        }
                       
                    }
                    
                
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
