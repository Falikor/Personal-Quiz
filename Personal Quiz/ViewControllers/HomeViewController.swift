//
//  HomeViewController.swift
//  Personal Quiz
//
//  Created by Татьяна Татьяна on 31.05.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // вызываем из модели
    let questions = Question.getQuestions()
    // передаем модель
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController,
              let vc = navigationVC.topViewController as? QuestionsViewController else { return }
        vc.questions = questions
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }

}
