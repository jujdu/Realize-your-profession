//
//  ResultViewController.swift
//  realize your personality
//
//  Created by Michael Sidoruk on 14/04/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    //MARK: - IBOutlets Properties
    
    @IBOutlet weak var shortResultLabel: UILabel!
    @IBOutlet weak var longResultLabel: UILabel!
    
    //MARK: - Properties
    
    var answers: [Answer]?
    
    //MARK: - UIViewController Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        var choices: [ProfessionType: Int] = [.policeman: 0, .cosmonaut: 0, .doctor: 0, .model: 0]
        
        if let answers = answers {
            for index in answers {
                switch index.type {
                case .cosmonaut:
                    guard let cosmonaut = choices[.cosmonaut] else { return }
                    choices[.cosmonaut] = cosmonaut + 1
                case .policeman:
                    guard let policeman = choices[.policeman] else { return }
                    choices[.policeman] = policeman + 1
                case .model:
                    guard let model = choices[.model] else { return }
                    choices[.model] = model + 1
                case .doctor:
                    guard let doctor = choices[.doctor] else { return }
                    choices[.doctor] = doctor + 1
                }
            }
        }
        
        guard var userResult = choices.popFirst() else { return }
        for result in choices {
            if result.value > userResult.value {
                userResult = result
            }
        }
        
        shortResultLabel.text = "You are \(userResult.key.rawValue)"
        longResultLabel.text = userResult.key.definition
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        QuestionViewController.answersChosen = []
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
