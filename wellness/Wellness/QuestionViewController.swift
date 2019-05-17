//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by iBrent on 12/13/18.
//  Copyright © 2018 iBrent. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    var questions: [Question] = [
        Question(text: "How many Vegges do you eat a month?",
                 type: .single,
                 answers: [
                    Answer(text: "Every Day", type: .thanks),
                    Answer(text: "A few times a week", type: .thanks),
                    Answer(text: "Once a week", type: .thanks),
                    Answer(text: "Less then once a week", type: .thanks)
            ]),
        Question(text: "How Often do you eat Fast food?",
                 type: .single,
                 answers: [
                    Answer(text: "Every day", type: .thanks),
                    Answer(text: "Every week", type: .thanks),
                    Answer(text: "Every month", type: .thanks),
                    Answer(text: "Ever so often", type: .thanks)
            ]),
        Question(text: "How active were you today?",
                 type: .ranged,
                 answers: [
                    Answer(text: "Very active", type: .thanks),
                    Answer(text: "Farly active", type: .thanks),
                    Answer(text: "Not really active", type: .thanks),
                    Answer(text: "Not at all active", type: .thanks)
            ]),

            Question(text: "So what race are you?",
                     type: .single,
                     answers: [
                        Answer(text: "Black or afican american", type: .thanks),
                        Answer(text: "White", type: .thanks),
                        Answer(text: "Asian", type: .thanks),
                        Answer(text: "Other", type: .thanks)
                ]),
            Question(text: "What gender are you?",
                     type: .single,
                     answers: [
                        Answer(text: "Female", type: .thanks),
                        Answer(text: "Male", type: .thanks),
                        Answer(text: "Non binary", type: .thanks),
                        Answer(text: "Other", type: .thanks)
            
]),
            Question(text: "Have you been listening to music?",
                     type: .single,
                     answers: [
                        Answer(text: "A lot", type: .thanks),
                        Answer(text: "Some", type: .thanks),
                        Answer(text: "Kind of ", type: .thanks),
                        Answer(text: "Not really", type: .thanks)
                        
                ]),
            Question(text: "How much water have you drink today?",
                     type: .single,
                     answers: [
                        Answer(text: "a lot", type: .thanks),
                        Answer(text: "some", type: .thanks),
                        Answer(text: "kind of", type: .thanks),
                        Answer(text: "not really", type: .thanks)
                        
                ]),
            Question(text: "Have you been able to get your work done?",
                     type: .single,
                     answers: [
                        Answer(text: "Some of it", type: .thanks),
                        Answer(text: "yes", type: .thanks),
                        Answer(text: "no", type: .thanks),
                        Answer(text: "Other", type: .thanks)
                        
                ]),

    ]
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() {
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex+1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false

        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if  multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if  multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if  multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if  multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
        
    }
    
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }


}
