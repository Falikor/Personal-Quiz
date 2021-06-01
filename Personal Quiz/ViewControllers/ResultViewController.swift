//
//  AnswersViewController.swift
//  Personal Quiz @IBOutlet weak var questionLabel: UILabel!
//
//  Created by Татьяна Татьяна on 31.05.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var textAnimalLabel: UILabel!
    
    var answers: [Answer] = []

    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        resultAnimal()
    }


}

extension ResultViewController {
    private func resultAnimal() {
        // делаем дикшанари чтобы расчитать количество ответов соответствующих животных
        var animalsCount: [String:Int] = ["dogCount": 0, "catCount": 0, "rabbitCount": 0, "turtleCount": 0]
        for i in 0..<answers.count {
           
            switch answers[i].type {
            case .dog:
                animalsCount["dogCount"] = animalsCount["dogCount"]! + 1
            case .cat:
                animalsCount["catCount"] = animalsCount["catCount"]! + 1
            case .rabbit:
                animalsCount["rabbitCount"] = animalsCount["rabbitCount"]! + 1
            case .turtle:
                animalsCount["turtleCount"] = animalsCount["turtleCount"]! + 1
            }
        }
        // вычисляю максимальное количисто значений в дикшнари и каким ключам это значение соответствует
        let userAnimal = animalsCount.filter {$0.value ==  animalsCount.values.max()}
        // берется первый ключ(так как в дикшанаре элементы ключ:значение хранятся рандомно то и получаем рандомный ключ в случаи равенства)
        switch userAnimal.keys.first {
        case "dogCount":
            animalLabel.text = "Вы - 🐶"
            textAnimalLabel.text = AnimalType.dog.definition
        case "catCount":
            animalLabel.text = "Вы - 🐱"
            textAnimalLabel.text = AnimalType.cat.definition
        case "rabbitCount":
            animalLabel.text = "Вы - 🐰"
            textAnimalLabel.text = AnimalType.rabbit.definition
        case "turtleCount":
            animalLabel.text = "Вы - 🐢"
            textAnimalLabel.text = AnimalType.turtle.definition
        default:
            print("Eror")
        }
    }
}

