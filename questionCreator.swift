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
var historySub = [String]()
var scienceSub = [String]()
var HoSsub = [String]()
var miscSub = [String]()


// Questions Lists
var moviesQuestions = [String]()
var musicQuestions = [String]()
var tvQuestions = [String]()
var sportsQuestions = [String]()
var historyQuestions = [String]()
var scienceQuestions = [String]()
var HoSQuestions = [String]()
var miscQuestions = [String]()

// Answers Lists
var moviesAnswers = [String]()
var musicAnswers = [String]()
var tvAnswers = [String]()
var sportsAnswers = [String]()
var historyAnswers = [String]()
var scienceAnswers = [String]()
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
                    historySub.append(subcategory)
                    historyQuestions.append(question)
                    historyAnswers.append(answer)
                    guesses.append(answer)
                case "Science":
                    scienceSub.append(subcategory)
                    scienceQuestions.append(question)
                    scienceAnswers.append(answer)
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

// Obtain 11 questions from the Category of the theme
func getQuestions(theme: String) -> [Int: [String]] {
    var questions = [Int: [String]]()
    var i = 0
    
    switch theme {
    case "Movies":
        while i < 11 {
            questions[i] = [moviesQuestions[0], moviesAnswers[0], moviesSub[0]]
            moviesQuestions.removeFirst()
            moviesAnswers.removeFirst()
            moviesSub.removeFirst()
            i += 1
        }
    case "Music":
        while i < 11 {
            questions[i] = [musicQuestions[0], musicAnswers[0], musicSub[0]]
            musicQuestions.removeFirst()
            musicAnswers.removeFirst()
            musicSub.removeFirst()
            i += 1
        }
    case "TV":
        while i < 11 {
            questions[i] = [tvQuestions[0], tvAnswers[0], tvSub[0]]
            tvQuestions.removeFirst()
            tvAnswers.removeFirst()
            tvSub.removeFirst()
            i += 1
        }
    case "Sports":
        while i < 11 {
            questions[i] = [sportsQuestions[0], sportsAnswers[0], sportsSub[0]]
            sportsQuestions.removeFirst()
            sportsAnswers.removeFirst()
            sportsSub.removeFirst()
            i += 1
        }
    case "Misc":
        while i < 11 {
            questions[i] = [miscQuestions[0], miscAnswers[0], miscSub[0]]
            miscQuestions.removeFirst()
            miscAnswers.removeFirst()
            miscSub.removeFirst()
            i += 1
        }
        //This is bug need to fix next demo
    case "History/Science":
        while i < 11 {
            if i == 0 || i == 4 || i == 10 {
                questions[i] = [HoSQuestions[i], HoSAnswers[i], HoSsub[i]]
                HoSQuestions.remove(at : i)
                HoSAnswers.remove(at: i)
                HoSsub.remove(at: i)
                i += 1
            }
            else if i == 1 || i == 3 || i == 6 || i == 7 {
                questions[i] = [historyQuestions[i], historyAnswers[i], historySub[i]]
                historyQuestions.remove(at : i)
                historyAnswers.remove(at: i)
                historySub.remove(at: i)
                i += 1
            }
            else {
                questions[i] = [scienceQuestions[i], scienceAnswers[i], scienceSub[i]]
                scienceQuestions.remove(at : i)
                scienceAnswers.remove(at: i)
                scienceSub.remove(at: i)
                i += 1
            }
        }
    default:
        break
    }
    
    return questions
    
}

let filePath = "questions_resource"
func question_caller()  -> [Int: [String]] {
    // Fix this
    let theme = getTheme(day:"Saturday")
    readFile(filePath: filePath)
    return getQuestions(theme: theme)
}



