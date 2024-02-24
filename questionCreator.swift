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


// Questions Lists
var moviesQuestions = [String]()
var musicQuestions = [String]()
var tvQuestions = [String]()
var sportsQuestions = [String]()

// Answers Lists
var moviesAnswers = [String]()
var musicAnswers = [String]()
var tvAnswers = [String]()
var sportsAnswers = [String]()

// Read question text file
// Create list of subcategory, question, and answer for every category
func readFile(filePath: String) {
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
            case "Music":
                musicSub.append(subcategory)
                musicQuestions.append(question)
                musicAnswers.append(answer)
            case "TV":
                tvSub.append(subcategory)
                tvQuestions.append(question)
                tvAnswers.append(answer)
            case "Sports":
                sportsSub.append(subcategory)
                sportsQuestions.append(question)
                sportsAnswers.append(answer)
            default:
                break
            }
        }
    } catch {
        print("Error reading file: \(error)")
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
    default:
        return "Sports"
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
    default:
        break
    }
    
    return questions
    
}

let filePath = "questions_resource"
func question_caller()  -> [Int: [String]] {
    // Fix this
    var theme = getTheme(day:"Wednesday")
    readFile(filePath: filePath)
    return getQuestions(theme: theme)
}



