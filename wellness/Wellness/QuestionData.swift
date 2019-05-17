//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by iBrent on 12/13/18.
//  Copyright © 2018 iBrent. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: WellnessType
}

enum WellnessType: String {
    case thanks = ""
    
    var definition: String {
        switch self {
        case .thanks:
            return "Your results have been saved!! You are now able to move to the next section!"
        }
        }
        }

