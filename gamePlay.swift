//
//  gamePlay.swift
//  TriviYeah!
//
//  Created by Colby Cook on 2/7/24.
// TESTING

import Foundation
import UIKit


// Get Day of Week
// Testing so right now it is Wednesday
var theme = getTheme(day:"Wednesday")

//Get questions
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

// Create Path
var path = [Int: [String]]()
func create_path() -> [Int: [String]] {
    for i in 0...10 {
        if let value = questions_dict[i] {
            path[i] = value
        }
    }
    questions_dict.removeAll()
    return path
}

//User progresses through game until answer all five questions correctly or gets one wrong
func game_process(){
    path = create_path()
    var round_number = 1
    var path_number = 0
    var result = game_play(r: round_number, p: path_number)
    if result == 1{
        //User won and got a TriviYeah
        //Congratulate and show them their path result
    }
    else{
        //User lost
        //Inform them they have a lost and still present them their path result
    }
}


//Goes through game play until game is over
//r is round number
//p is path node key
//returns 1 or 0 for win or loss
//Recursively calls itself until game is over, either user misses question or completes all 5 questions
func game_play(r: Int, p: Int) -> Int{
    //round 1
    if r == 1{
        //Display first question: path[0]![0]
        // Provide text box for user to put their answer
        var user_answer = readLine()
        
        //answer is correct
        if user_answer == path[p]![1]{
            //Display UI telling user is correct
            //Then give them subcategory option 1 or subcategory option 2 to choose from option_1 = path[0+1]![2], option_2 = path[0+2]![2]
            var user_choice = 2//Whichever is selected, this will not be 0, when fixed it will be based off user selection and UI
            var option_1 = 1
            var option_2 = 2
            if user_choice == option_1 {
                var path_index = p + 1 //User chose left subcategory
                var round_num = 2
                colorPath[p] = .green
                return game_play(r: round_num, p: path_index)
            } else{
                var path_index = p + 2 //User chose right subcategory
                var round_num = 2
                colorPath[p] = .green
                return game_play(r: round_num, p: path_index)
            }
        } 
        //Answer is wrong
        else{
            colorPath[p] = .red
            return 0
        }
            
    }
    //Final round
    else if r == 5{
        //Display final question: path[10]![0]
        // Provide text box for user to put their answer
        var user_answer = readLine()
        if user_answer == path[10]![1]{
            colorPath[10] = .green
            return 1
        } else{
            colorPath[10] = .red
            return 0
        }
        
    }
    //Fourth round
    else if r == 4{
        //Display Round 4 question, path[p]![0]
        // Provide text box for user to put their answer
        var user_answer = readLine()
        if user_answer == path[p]![1]{
            colorPath[p] = .green
            return game_play(r: 5, p: 10)
        } else{
            colorPath[p] = .red
            return 0
        }
    }
    //Round 2 and 3
    else{
        //Display question: path[p]![0]
        // Provide text box for user to put their answer
        var user_answer = readLine()
        
        //answer is correct
        if user_answer == path[p]![1]{
            //Display UI telling user is correct
            //Then give them subcategory option 1 or subcategory option 2 to choose from option_1 = path[0+1]![2], option_2 = path[0+2]![2]
            var user_choice = 1//Whichever is selected, this will not be 0, when fixed it will be based off user selection and UI
            var option_1 = 1
            var option_2 = 2
            if user_choice == option_1 {
                if r == 2{ //Round 2 option 1
                    var path_index = p + 2
                    var round_num = r + 1
                    colorPath[p] = .green
                    return game_play(r: round_num, p: path_index)
                }
                else { //Round 3 option 1
                    var path_index = p + 3
                    var round_num = r + 1
                    colorPath[p] = .green
                    return game_play(r: round_num, p: path_index)
                }
                
            } else{ // Option 2
                if r == 2{ //Round 2 option 2
                    var path_index = p + 3
                    var round_num = r + 1
                    colorPath[p] = .green
                    return game_play(r: round_num, p: path_index)
                }
                else { //Round 3 option 2
                    var path_index = p + 4
                    var round_num = r + 1
                    colorPath[p] = .green
                    return game_play(r: round_num, p: path_index)
                }
            }
        }
        //Answer is wrong
        else{
            colorPath[p] = .red
            return 0
        }
    }
}
