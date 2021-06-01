//
//  QuestionsViewController.swift
//  Personal Quiz
//
//  Created by Татьяна Татьяна on 31.05.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    //лейбл с вопросом
    @IBOutlet weak var questionLabel: UILabel!
    //отоброжение прогресса
    @IBOutlet weak var progressView: UIProgressView!
    
    // ****SINGL****
    // общий стек с вопросами типа сингл
    @IBOutlet weak var singleStackView: UIStackView!
    // собираем все buttons в колекцию. При этом важна последовательность включения в колекции изза присвоения индекса
    @IBOutlet var singleButtons: [UIButton]!
    
    // ****MULTIPLE****
    // стек со множествеными ответами
    @IBOutlet weak var multipleStackView: UIStackView!
    // лейблы множественный тип вопросов, тоже записали как колекция в правильной последовательности
    @IBOutlet var multipleLabels: [UILabel]!
    // колекция свичей так же в правильном порядке
    @IBOutlet var multipleSwitchs: [UISwitch]!
    
    //****RANGED****
    //стек ранжированых вопросов
    @IBOutlet weak var rangedStackView: UIStackView!
    //колекция лейблов для ranged вопросов
    @IBOutlet var rangedLables: [UILabel]!
    // слайдер для вопросов  ranged
    @IBOutlet weak var rangedSlider: UISlider!
    
    // принимает массив модели вопросов
    var questions: [Question] = []
    // индекс активного вопроса
    private var questionIndex = 0
    // массив ответов для передачи на ResultViewContriler
    private var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // метод обнавления контролера
        updateUI()
    }
    

    
    
}

extension QuestionsViewController {
    // обработка нажатия на кнопки(ответ на вопрос) в single вопросе
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        // получить текущий ответ
        // получаем все возможные ответы по текущему вопросу
        let currentAnswers = questions[questionIndex].answers
        // получаем индекс кнопки на которую нажали
        // обходим масив button чтобы определить какой был нажат
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        // текущий ответ равен текущие ответы и индекс ответа на который нажали
        let currentAnswer = currentAnswers[currentIndex]
        // помещаем в массив ответов
        answersChosen.append(currentAnswer)
        // метод перейти к следующему вопросу
        nextQuestion()
    }
    
    // обработка нажатия на кнопку ответ в multiple вопросах
    @IBAction func multipleAnswerButtonPressed() {
        // получить текущий ответ
        // получаем все возможные ответы по текущему вопросу
        let currentAnswers = questions[questionIndex].answers
        // обход по свитчирам и ответам и если свитчер включен то помещае ответ помещаем в ответы
        for (switcher, answer) in zip(multipleSwitchs, currentAnswers) {
            if switcher.isOn {
                answersChosen.append(answer)
            }
        }
        
        
        // метод перейти к следующему вопросу
        nextQuestion()
    }
    // обработка нажатия на кнопку ответ в ranged вопросах
    @IBAction func rangedAnswerButtonPressed() {
        // получить текущий ответ
        // получаем все возможные ответы по текущему вопросу
        let currentAnswers = questions[questionIndex].answers
        // положение слайдера на количество нашего ответа и получаем средний индекс куда мы попали
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        // метод перейти к следующему вопросу
        nextQuestion()
    }
}

extension QuestionsViewController {
    private func updateUI() {
        // скрыть все стеки
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        // получить текущий вопрос
        let currentQuestion = questions[questionIndex]
        // в лейбл добовляем текст вопроса
        questionLabel.text = currentQuestion.text
        // отобразим прогрес текущего вопроса. Индекс делим на количество вопросов
        let totalProgress = Float(questionIndex) / Float(questions.count)
        //метод отображающий прогресс
        progressView.setProgress(totalProgress, animated: true)
        // navigation title отображение в тексте navigation
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        // берем текущий вопрос и получаем его ответы
        let answers = currentQuestion.answers
        // обращаемся к активному вопросу чтобы узнать тип вопроса
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(answers: answers)
        case .multiple:
            updateMultipleStackView(answers: answers)
        case .ranged:
            updateRangedStackView(answers: answers)
        }
    }
    
    // метод обнавления singl стека
    private func updateSingleStackView(answers: [Answer]) {
        // активируем(показываем) необходимый стек
        singleStackView.isHidden = false
        // обходим все кнопкуи и ответам одновременно показываем оба масива через zip
        for (button, answer) in zip(singleButtons, answers) {
            // каждой кнопке присвае соответствующий ответ
            button.setTitle(answer.text, for: .normal)
        }
        
    }
    // метод обнавления multiple стека
    private func updateMultipleStackView(answers: [Answer]) {
        // активируем(показываем) необходимый стек
        multipleStackView.isHidden = false
        // обходим все лейблам и ответам одновременно показываем оба масива через zip
        for (labil, answer) in zip(multipleLabels, answers) {
            // каждой лейблам присвае соответствующий ответ
            labil.text = answer.text
        }
    }
    // метод обнавления ranged стека
    private func updateRangedStackView(answers: [Answer]) {
        // активируем(показываем) необходимый стек
        rangedStackView.isHidden = false
        // задаем первый и последний лейбл из ответов
        rangedLables.first?.text = answers.first?.text
        rangedLables.last?.text = answers.last?.text
    }
    
    private func nextQuestion() {
        // увеличиваем активный индекст текущего вопроса на 1
        questionIndex += 1
        // запустить обнавление UI
        //  если колличество вопросов больше индекса то обнавляем
        if questionIndex < questions.count {
            updateUI()
        } else {
            // есле нет то перейти на результат и передать массив ответов
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegue",
        let vc = segue.destination as? ResultViewController else { return }
        vc.answers = answersChosen
        
    }
}

