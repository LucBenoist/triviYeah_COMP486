//
//  ContentView.swift
//  TriviYeah!
//


import SwiftUI

let filePath = "questions_resource"
let day = "Friday" //getCurrentDay()
var theme = getTheme(day: day)
let days_passed = daysSinceDate()
let week = get_week(days: days_passed)

func question_caller()  -> [Int: [String]] {
    readFile(filePath: filePath)
    return getQuestions(theme: theme, week: week)
}
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

func theme_name(theme: String) -> String {
    var theme = theme
    if theme == "Misc" {
        if day == "Wednesday" {
            theme = "Wild"
        }
        else{
            theme = "Frantic"
        }
    } else if day == "Sunday" {
        theme = "Hist{OR}science"
    } else if theme == "Music"{
        theme = "Tunes"
    }
    else{
        return theme
    }
    return theme
}

var theme_text = theme_name(theme: theme)
var game_played = false
var final_answer = ""
let trivi_text = "TriviYeah! Game:"
var day_num = String(format: "%03d", days_passed + 1)
var row_1 = "⬜️"
var row_2 = "⬜️⬜️"
var row_3 = "⬜️⬜️⬜️"
var row_4 = "⬜️⬜️⬜️⬜️"
var row_5 = "⬜️"
var message = ""
var pattern = """
\(theme_text) \(day)
        \(row_1)
     \(row_2)
  \(row_3)
\(row_4)
        \(row_5)
\(round_num)/5
"""

//var isButtonClicked = false // Track if the button is clicked

struct ContentView: View {
    
    init(){
           UINavigationBar.setAnimationsEnabled(false)
       }
    
    @StateObject var triviaManager = TriviaManager()
    var body: some View {
        NavigationView {
            ZStack {
                Color(Color.black)
                    .ignoresSafeArea()
                
                // outline
                Rectangle()
                    .stroke(Color.skyTeal, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Image("Logo")
                    Text("TriviYeah!")
                         .font(.system(size: 70))
                         .fontWeight(.heavy)
                         .foregroundColor(.skyYellow)
                         //.padding(.top, 150)
                 
                    
                    Text("The Daily Trivia Game")
                        .font(Font.custom("Arial Rounded MT Bold", size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.hotPink)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink {
                        DailyGameView()
                    } label: {
                        PrimeButton_(text: "Daily Game")
                    }
                    .padding()
                    
                    NavigationLink{
                        MiniGameView()
                    }label:{
                        PrimeButton_(text:"Minigames")}
                    .padding()
                    .navigationBarBackButtonHidden(true)
                    }
                }
               
            }.navigationBarBackButtonHidden(true)
        }
        //.navigationBarBackButtonHidden(true)
    }

struct DailyGameView: View{
    var body: some View {
        ZStack {
            Color(Color.black)
                .ignoresSafeArea()
            
            Rectangle()
                .stroke(Color.hotPink, lineWidth: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("Logo")
                Text("TriviYeah!")
                     .font(.system(size: 70))
                     .fontWeight(.heavy)
                     .foregroundColor(.skyYellow)
                     //.padding(.top, 150)
             
                
                Text("The Daily Trivia Game")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                
                NavigationLink{
                    if game_played == false{
                        QuestionView()
                    }
                    else {
                        GameOverView()
                    }
                }label:{
                    if game_played == false{
                        PrimeButton_(text:"Start").padding()
                    } else{
                        PrimeButton_(text:"Your Results").padding()
                    }
                }

                
                    NavigationLink{
                        InstructionsView()
                    }label:{
                        PrimeButton_(text:"Instructions")}
                
                NavigationLink{
                    ContentView()
                }label:{
                    PrimeButton_(text:"Back")}
                .padding()
                
            }.navigationBarBackButtonHidden(true)
            
            
            
        }
        
    }
}


struct MiniGameView: View{
    var body: some View {
        ZStack {
            Color(Color.black)
                .ignoresSafeArea()
            
            Rectangle()
                .stroke(Color.skyYellow, lineWidth: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("Logo")
                Text("TriviYeah!")
                    .font(.system(size: 70))
                    .fontWeight(.heavy)
                    .foregroundColor(.skyYellow)
                //.padding(.top, 150)
                
                Text("Trivia Minigames")
                    .font(Font.custom("Arial Rounded MT Bold", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.hotPink)
                    .multilineTextAlignment(.center)
                
                NavigationLink{
                    InfiniteTriviaView()
                }label:{
                    PrimeButton_(text:"Infinite Trivia")
                        .font(Font.custom("Arial Rounded MT Bold", size: 20))
                }
                .padding()
                
                NavigationLink{
                    HeadToHeadView()
                }label:{
                    PrimeButton_(text:"Multi Mode")}
                
                
                NavigationLink{
                    ContentView()
                }label:{
                    PrimeButton_(text:"Back")}
                .padding()
                
            }.navigationBarTitle("", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
        }
        
    }
}


//Question Scene and Round Play
struct QuestionView: View{
    @State private var answer = ""
    @State private var isCorrect: Bool?
    @State private var isButtonClicked: Bool?
    @State private var showSuggestions = false
    @State private var selectedSuggestion: String?
    
    var filteredSuggestions: [String] {
        if round_num == 5 {
            path_node = 10
        }
            if answer.isEmpty {
                return []
            } else if path[path_node]![2] == "Even or Odd?"{
                return even_odd//.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Adam Sandler" {
                return adamSandlerMovies.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Presidents" {
                return presidents.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "States" {
                return states.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Continents" {
                return continents.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Adult Cartoons" {
                return adultCartoons.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Snack Food" {
                return snackFoodCompanies.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Harry Potter" {
                return harryPotterCharacters.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Celebrity Couples" {
                return nflQuarterbacks.filter { $0.localizedCaseInsensitiveContains(answer) }
            } else if path[path_node]![2] == "Boston" {
                return crimeMovies.filter { $0.localizedCaseInsensitiveContains(answer) }
            }
        else {
                return guesses.filter { $0.localizedCaseInsensitiveContains(answer) }
            }
        }
    var body: some View {
        NavigationView{
            ZStack{
                Color(Color.black)
                    .ignoresSafeArea()
                
                Rectangle()
                    .stroke(Color.hotPink, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("\(theme_text) \(day)")
                        //.padding()
                        .font((theme_text.count + day.count) > 16 ? .system(size: 24) : .system(size: 35))
                        .padding()
                        .fontWeight(.heavy)
                        .textCase(.uppercase)
                        .foregroundStyle(Color.skyYellow)
                        .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.skyTeal, lineWidth: 3)
                            )
                    // Round 1
                    if round_num == 1{
                        Text("Round \(round_num)")
                            .padding()
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                            .textCase(.uppercase)
                            .foregroundStyle(Color.hotPink)
                        Text((path[0]![0])) //Q0
                            .foregroundStyle(Color.skyYellow)
                            //.padding()
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
                                    game_played = true
                                }
                            }
                            .font(Font.custom("Arial Rounded MT Bold", size: 24))
                            .foregroundColor(.skyYellow)
                            .frame(width: 128, height: 24)
                            .padding()
                            //.background(Color(.black))
                            .cornerRadius(13)
                            .shadow(radius: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color(.hotPink), lineWidth: 8)
                            )
                            .controlSize(.regular)
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
                            .textCase(.uppercase)
                            .foregroundStyle(Color.hotPink)
                        Text((path[path_node]![0])) //Question stored at path node
                            .padding()
                            .foregroundStyle(Color.skyYellow)
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
                                    colorPath[path_node]?.color = Color("PathG")
                                    colorPath[path_node]?.symbol = "🟩"
                                    
                                    isCorrect = true
                                } else {
                                    colorPath[path_node]?.color  = Color("PathR")
                                    colorPath[path_node]?.symbol = "🟥"
                                    isCorrect = false
                                    game_played = true
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
                    }
                    else{ // Final Round Branch
                        Text("FINAL ROUND")
                            .font(.system(size: 50))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.hotPink)
                        Text((path[10]![0])) // Final question
                            .padding()
                            .foregroundStyle(Color.skyYellow)
                        TextField("Enter your answer...", text: $answer, onEditingChanged: { isEditing in
                                            self.showSuggestions = isEditing
                                        }) // Text Box for user answer
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of:answer) {
                                final_answer = answer
                                if final_answer == path[10]![1]{
                                    colorPath[10]?.symbol = "🟩"
                                    message = "A Perfect TriviYeah!"
                                    round_num = 6
                                    game_played = true
                                } else{
                                    colorPath[10]?.symbol = "🟥"
                                    game_played = true
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
                    Color(Color.black)
                        .ignoresSafeArea()
                    
                    Rectangle()
                        .stroke(Color.hotPink, lineWidth: 4)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Text("\(theme_text) \(day)")
                            //.padding()
                            .font((theme_text.count + day.count) > 16 ? .system(size: 24) : .system(size: 35))
                            .padding()
                            .fontWeight(.heavy)
                            .textCase(.uppercase)
                            .foregroundStyle(Color.skyYellow)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.skyTeal, lineWidth: 3)
                                )
  
                                    
                        Text("Pick Next Round's Category!")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.skyYellow)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        
                        HStack{
                            
                            if round_num == 2{
                            
                                NavigationLink(destination: QuestionView()) {
                                    PrimeButton_(text: path[1]![2])
                                    
                                    
                                }.padding()
                                .simultaneousGesture(TapGesture().onEnded {
                                    path_node = 1
                                })
                                NavigationLink(destination: QuestionView()){
                                    PrimeButton_(text: path[2]![2])
                                }.padding()
                                .simultaneousGesture(TapGesture().onEnded {
                                    path_node = 2
                                })
                            }
                            else if round_num == 3{
                                if path_node == 1{
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[3]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 3
                                    })
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[4]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 4
                                    })
                                }
                                else{
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[4]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 4
                                    })
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[5]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 5
                                    })
                                }
                            }
                            else{
                                if path_node == 3{
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[6]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 6
                                    })
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[7]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 7
                                    })
                                }
                                else if path_node == 4{
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[7]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 7
                                    })
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[8]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 8
                                    })
                                }
                                else{
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[8]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 8
                                    })
                                    NavigationLink(destination: QuestionView()) {
                                        PrimeButton_(text: path[9]![2])
                                    }.padding()
                                    .simultaneousGesture(TapGesture().onEnded {
                                        path_node = 9
                                    })
                                }
                            }
                            
                        }
                        Spacer().frame(height: 10)}
                }
            }.navigationBarBackButtonHidden(true)
        
    }
}
    

//Game Over scene
struct GameOverView: View{
    var body: some View {
        NavigationView{
            ZStack{
                Color(Color.black)
                    .ignoresSafeArea()
                Rectangle()
                    .stroke(Color.hotPink, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("Game Over!")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.skyYellow)
                    
                    if final_answer == path[10]![1] {
                        Text("Congratulations, \nYou got a TriviYeah!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("PathG"))
                            .multilineTextAlignment(.center)
                    }
                    else{
                        Text("Oh no! Maybe next time!")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
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
\(trivi_text) \(day_num)
\(theme_text) \(day)
                \(colorPath[0]!.symbol)
             \(colorPath[1]!.symbol)\(colorPath[2]!.symbol)
          \(colorPath[3]!.symbol)\(colorPath[4]!.symbol)\(colorPath[5]!.symbol)
        \(colorPath[6]!.symbol)\(colorPath[7]!.symbol)\(colorPath[8]!.symbol)\(colorPath[9]!.symbol)
                \(colorPath[10]!.symbol)
                \(round_num-1)/5
\(message)
""")
                        .foregroundStyle(Color(.systemBlue))
                        .padding()
                    
                    NavigationLink(destination: ContentView()) {
                        PrimeButton_(text: "Home")
                        
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
                Color(Color.black)
                    .ignoresSafeArea()
                
                Rectangle()
                    .stroke(Color.skyYellow, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 5) {
                    HStack {
                        Text("Multi Mode")
                            .font(.system(size: 60))
                            .fontWeight(.heavy)
                            .foregroundColor(.skyYellow)
                            .padding(.top, 5)
                        Spacer()
                        
                        Text("\(triviaManager.index + 1) out of \(triviaManager.length)")
                            .font(Font.custom("Arial Rounded MT Bold", size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.hotPink)
                            //.multilineTextAlignment(.center)
                    }
                    ProgressBar(progress: triviaManager.progress)
                    
                    VStack(){
                        Text(triviaManager.question)
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.skyYellow)
                        
                        Spacer()
                        
                        ForEach(triviaManager.answerChoices, id:\.text){ answer in AnswerRow_(answer: answer)
                                .environmentObject(triviaManager)
                            
                        }
                    }
                    Button {
                        triviaManager.goToNextQuestion()
                    } label: {
                        PrimeButton_(text: "Next", background: triviaManager.answerSelected ? Color(Color.skyTeal) : Color(hue: 1.0, saturation: 0.00, brightness: 0.564, opacity: 0.327))
                    }
                    .disabled(!triviaManager.answerSelected)
                    
                    NavigationLink{
                        HHOver()
                    }label:{
                        PrimeButton_(text: "End Game")
                    }
                    .padding()
                    
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }.navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
    }
}
struct HHOver: View {
    @StateObject var triviaManager = TriviaManager()
    var body: some View {
        NavigationView{
            ZStack{
                Color(Color.black)
                    .ignoresSafeArea()
                
                Rectangle()
                    .stroke(Color.skyYellow, lineWidth: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 5) {
                    HStack {
                        Text("Game Over")
                            .font(.system(size: 60))
                            .fontWeight(.heavy)
                            .foregroundColor(.skyYellow)
                            .padding(.top, 5)
                        Spacer()
                        
                        //Text("Your score: \(triviaManager.score) out of \(triviaManager.length)")
                            //.font(Font.custom("Arial Rounded MT Bold", size: 20))
                            //.fontWeight(.medium)
                            //.foregroundColor(.hotPink)
                            //.multilineTextAlignment(.center)
                        
                    }
                    
                    VStack(){
                        
                        
                        
                        
                        NavigationLink{
                            ContentView()
                        }label:{
                            PrimeButton_(text:"Main Menu")}
                        .padding()
                        .disabled(triviaManager.reachedEnd)
                        
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
            }.navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
    }
}


    
struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
        }
    }

