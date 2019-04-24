//
//  QuestionViewController.swift
//  realize your personality
//
//  Created by Michael Sidoruk on 14/04/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //MARK: - IBOutlets Properties
    
    @IBOutlet weak var questionLabel: UILabel!
   
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multiSwitch: [UISwitch]!
    @IBOutlet weak var multiAnswerButton: UIButton!
    @IBOutlet weak var labelsStackView: UIStackView!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK: - Properties
    
    var questions: [Question] = [
        Question(text: "Which person do you like more?", type: .single, answer: [
            Answer(text: "Elon Musk", type: .cosmonaut),
            Answer(text: "Robocop", type: .policeman),
            Answer(text: "Hippocrates", type: .doctor),
            Answer(text: "Cara Delevingne", type: .model),
            ]),
        Question(text: "What do you like?", type: .multiple, answer: [
            Answer(text: "Blood", type: .doctor),
            Answer(text: "Space", type: .cosmonaut),
            Answer(text: "Fashion", type: .model),
            Answer(text: "Guns", type: .policeman),
            ]),
        Question(text: "How much do you like to travel?", type: .ranged, answer: [
            Answer(text: "I hate", type: .policeman),
            Answer(text: "A little bit", type: .doctor),
            Answer(text: "I like", type: .cosmonaut),
            Answer(text: "I love", type: .model),
            ]),
    ]
    
    static var answersChosen: [Answer] = []
    
    var questionIndex = 0
    
    //MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - Methods
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question № \(questionIndex + 1)"
        
        let question = questions[questionIndex]
        questionLabel.text = question.text
        
        let answers = question.answer
       
        let progress = Float(questionIndex) / Float(questions.count)
        progressView.progress = progress
        
        switch question.type {
        case .single:
            updateSingleStack(using: answers)
        case .multiple:
            updateMultipleStack(using: answers)
        case .ranged:
            updateRangedStack(using: answers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButtons.forEach { $0.isHidden = true }
        for index in 0..<min(singleButtons.count, answers.count) {
            singleButtons[index].isHidden = false
            singleButtons[index].setTitle(answers[index].text, for: .normal)
        }
    }
    
    // changing status of the multianswerbutton to help to turn ON or OFF this one
    func multiAnswerButtonIsOn(_ value: Bool) {
        if value == true {
            multiAnswerButton.isEnabled = true
            multiAnswerButton.backgroundColor = .black
            multiAnswerButton.tintColor = .white
        } else {
            multiAnswerButton.isEnabled = false
            multiAnswerButton.backgroundColor = .gray
            multiAnswerButton.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleLabels.forEach { $0.superview!.isHidden = true }
        for index in 0..<min(multipleLabels.count, answers.count) {
            multipleLabels[index].superview!.isHidden = false
            multipleLabels[index].text = answers[index].text
        }
        
        for index in 0..<min(multiSwitch.count, answers.count) {
            multiSwitch[index].isHidden = false
            multiSwitch[index].isOn = false
            multiSwitch[index].onTintColor = .black
        }
        
        multiAnswerButtonIsOn(false)
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabels[0].text = answers[0].text
        rangedLabels.last!.text = answers.last!.text
        multipleStackView.setCustomSpacing(20.0,after: labelsStackView)
    }
    
    func nextQuestion(){
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let destinationVC = segue.destination as? ResultViewController
            destinationVC?.answers = QuestionViewController.answersChosen
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = questions[questionIndex].answer
        let index = singleButtons.index(of: sender)!
        QuestionViewController.answersChosen.append(answers[index])
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed() {
        let answers = questions[questionIndex].answer
        for index in 0..<min(multipleLabels.count, answers.count) {
            let multiLabel = multipleLabels[index].superview?.subviews.last as? UISwitch
            if multiLabel != nil {
                QuestionViewController.answersChosen.append(answers[index])
            }
        }
        nextQuestion()
    }
    
    // changing multianswerbutton's activity by cheking switches' status
    @IBAction func switchIsChanged() {
        for index in 0..<multiSwitch.count {
            if multiSwitch[index].isOn == true {
                multiAnswerButtonIsOn(true)
                break
            } else {
                multiAnswerButtonIsOn(false)
            }
        }
    }
    
    @IBAction func rangedButtonPressed() {
        let answers = questions[questionIndex].answer
        let index = Int(round(slider.value * Float(answers.count - 1)))//0-0.15; 0.16-0.5; 0.51-0.85; 0.86-1
        QuestionViewController.answersChosen.append(answers[index])
        nextQuestion()
    }
}
