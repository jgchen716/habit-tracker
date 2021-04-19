//
//  Habit.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/14/21.
//
import UIKit

struct Habit {
    let name: String
    let startDate: String
    let emoji: String
    let description: String
    
    // number of days habit has been tracked
    var numDays: Int
    
    // number of CONTINUOUS days habit has been tracked
    var streak: Int
    
    init(name: String, startDate: String, emoji: String, description: String) {
        self.name = name
        self.startDate = startDate
        self.emoji = emoji
        self.description = description
        self.numDays = 0
        self.streak = 0
    }
}
