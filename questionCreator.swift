//
//  getQuestions.swift
//  TriviYeah!
//
//  Created by Colby Cook on 2/7/24.
// TESTING

import Foundation
import SwiftUI

// Subcategory Lists
var moviesSub = [String]()
var musicSub = [String]()
var tvSub = [String]()
var sportsSub = [String]()
//var historySub = [String]()
//var scienceSub = [String]()
var HoSsub = [String]()
var miscSub = [String]()


// Questions Lists
var moviesQuestions = [String]()
var musicQuestions = [String]()
var tvQuestions = [String]()
var sportsQuestions = [String]()
//var historyQuestions = [String]()
//var scienceQuestions = [String]()
var HoSQuestions = [String]()
var miscQuestions = [String]()

// Answers Lists
var moviesAnswers = [String]()
var musicAnswers = [String]()
var tvAnswers = [String]()
var sportsAnswers = [String]()
//var historyAnswers = [String]()
//var scienceAnswers = [String]()
var HoSAnswers = [String]()
var miscAnswers = [String]()

// List of all answers for now
var guesses = [String]()

// Read question text file
// Create list of subcategory, question, and answer for every category
func readFile(filePath: String) {
    if let filePath = Bundle.main.path(forResource: "questions_resource", ofType: "" ){
        do {
            let textFile = try String(contentsOfFile: filePath, encoding: .utf8)
            let lines = textFile.components(separatedBy: "\n")
            
            for line in lines {
                let components = line.components(separatedBy: "|").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                guard components.count == 4 else { continue }
                
                let category = components[0]
                let subcategory = components[1]
                let question = components[2]
                let answer = components[3]
                
                switch category {
                case "Movies":
                    moviesSub.append(subcategory)
                    moviesQuestions.append(question)
                    moviesAnswers.append(answer)
                    guesses.append(answer)
                case "Music":
                    musicSub.append(subcategory)
                    musicQuestions.append(question)
                    musicAnswers.append(answer)
                    guesses.append(answer)
                case "TV":
                    tvSub.append(subcategory)
                    tvQuestions.append(question)
                    tvAnswers.append(answer)
                    guesses.append(answer)
                case "Sports":
                    sportsSub.append(subcategory)
                    sportsQuestions.append(question)
                    sportsAnswers.append(answer)
                    guesses.append(answer)
                case "History":
                   // historySub.append(subcategory)
                   // historyQuestions.append(question)
                   // historyAnswers.append(answer)
                    HoSsub.append(subcategory)
                    HoSQuestions.append(question)
                    HoSAnswers.append(answer)
                    guesses.append(answer)
                case "Science":
                    //scienceSub.append(subcategory)
                    //scienceQuestions.append(question)
                    //scienceAnswers.append(answer)
                    HoSsub.append(subcategory)
                    HoSQuestions.append(question)
                    HoSAnswers.append(answer)
                    guesses.append(answer)
                case "HoS":
                    HoSsub.append(subcategory)
                    HoSQuestions.append(question)
                    HoSAnswers.append(answer)
                    guesses.append(answer)
                case "Misc":
                    miscSub.append(subcategory)
                    miscQuestions.append(question)
                    miscAnswers.append(answer)
                    guesses.append(answer)
                default:
                    break
                }
            }
        } catch {
            print("Error reading file: \(error)")
        }
    }
}

//April 16, 2024
let launch_day = Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 24))!

// Number of days since Launch Day
//Helps get Week
func daysSinceDate() -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    let components = calendar.dateComponents([.day], from: launch_day, to: currentDate)
    guard let days = components.day else { return 0 }
    
    return days
}

//Get Week
func get_week(days: Int) -> Int {
    let num = Double(days) / 7.0
    let floored_num = floor(num)
    return Int(floored_num)
}

//Get Day
func getCurrentDay() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: Date())
}

// Assign Theme based on given day
func getTheme(day: String) -> String {
    switch day {
    case "Monday":
        return "Movies"
    case "Tuesday":
        return "Music"
    case "Thursday":
        return "TV"
    case "Saturday":
        return "Sports"
    case "Sunday":
        return "History/Science"
    default:
        return "Misc"
    }
}


func quesByWeek(week: Int) -> Int{
    if week == 0{
        return 0
    }
    else{
        let first_ques = week * 11
        return (first_ques)
    }
}

// Obtain 11 questions from the Category of the theme
func getQuestions(theme: String, week: Int) -> [Int: [String]] {
    var questions = [Int: [String]]()
    var i = quesByWeek(week: week)
   // let dummy_i = i
    let last_ques = i + 11
    print(i)
    
    switch theme {
    case "Movies":
        while i < last_ques {
            questions[i] = [moviesQuestions[i], moviesAnswers[i], moviesSub[i]]
            i += 1
        }

    case "Music":
        while i < last_ques {
            questions[i] = [musicQuestions[i], musicAnswers[i], musicSub[i]]
            i += 1
        }
    case "TV":
        while i < last_ques {
            questions[i] = [tvQuestions[i], tvAnswers[i],tvSub[i]]
            i += 1
        }
    case "Sports":
        while i < last_ques {
            questions[i] = [sportsQuestions[i], sportsAnswers[i], sportsSub[i]]
            i += 1
        }
    case "Misc":
        while i < last_ques {
            questions[i] = [miscQuestions[i], miscAnswers[i], miscSub[i]]
            i += 1
        }
        //This is bug need to fix next demo
    case "History/Science":
        while i < last_ques {
            questions[i] = [HoSQuestions[i], HoSAnswers[i], HoSsub[i]]
            i += 1
        }
    default:
        break
    }
    return questions
}



