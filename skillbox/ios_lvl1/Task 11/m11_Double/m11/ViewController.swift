//
//  ViewController.swift
//  m11
//
//  Created by Maxim Nikolaev on 07.09.2021.
//
//    Доработайте пользовательский интерфейс и логику калькулятора из урока с помощью StackView и перечислений. Для решения используйте прикрепленный к заданию проект.
//Добавьте в калькулятор недостающие цифры и математические операции.
//
//Должны выполняться следующие условия:
//
//в калькуляторе должны быть математические операции вычитания, умножения и деления;
//реализация пользовательского интерфейса должна содержать StackView для выравнивания кнопок калькулятора; кастомизация кнопок и вывода результата может быть любой, она не оценивается;
//математические операции должны работать правильно;
import UIKit

class ViewController: UIViewController {
    var isNewValue = true
    var operation: MathOperation? = nil
    var previousOperation: MathOperation? = nil
//    var result: Int = 0
//    var newValue: Int = 0
    var resDouble: Double = 0
    var newValueDouble: Double = 0
    
    @IBAction func onOne(_ sender: Any) {
        addDigit("1")
    }
    @IBAction func onTwo(_ sender: Any) {
        addDigit("2")
    }
    @IBAction func onThree(_ sender: Any) {
        addDigit("3")
    }
    @IBAction func onFour(_ sender: Any) {
        addDigit("4")
    }
    @IBAction func onFive(_ sender: Any) {
        addDigit("5")
    }
    @IBAction func onSix(_ sender: Any) {
        addDigit("6")
    }
    //Недостающие цифры/символы
    @IBAction func onSeven(_ sender: Any) {
        addDigit("7")
    }
    
    @IBAction func onEight(_ sender: Any) {
        addDigit("8")
    }
    
    @IBAction func onNine(_ sender: Any) {
        addDigit("9")
    }
    
    @IBAction func onZero(_ sender: Any) {
        addDigit("0")
    }
    
    @IBAction func onDot(_ sender: Any) {
        addDigit(".")
    }
    // нажать равно
    @IBAction func onEqual(_ sender: Any) {
        calculate()
    }
    // нажать плюс
    @IBAction func onPlus(_ sender: Any) {
        operation = .sum
        previousOperation = nil
        isNewValue = true
//        result = getInteger()
        resDouble = getDouble()
    }
    
    // нажать минус
    @IBAction func onMinus(_ sender: Any) {
        operation = .substract
        previousOperation = nil
        isNewValue = true
//        result = getInteger()
        resDouble = getDouble()
    }
    // нажать деление
    @IBAction func onDiv(_ sender: Any) {
        operation = .division
        previousOperation = nil
        isNewValue = true
//        result = getInteger()
        resDouble = getDouble()
    }
    // нажать умножение
    @IBAction func onMulti(_ sender: Any) {
        operation = .multiplication
        previousOperation = nil
        isNewValue = true
//        result = getInteger()
        resDouble = getDouble()
    }
    // нажать очистить
    @IBAction func onReset(_ sender: Any) {
        isNewValue = true
//        result = 0
//        newValue = 0
        resDouble = 0
        newValueDouble = 0
        operation = nil
        previousOperation = nil
        resultLabel.text = "0"
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = ConstantStrings.Calculator.title
    }
    func addDigit(_ digit: String) {
        if isNewValue {
            resultLabel.text = ""
            isNewValue = false
        }
        var digits = resultLabel.text
        digits?.append(digit)
        resultLabel.text = digits
    }
    
//    func getInteger() -> Int {
//        return Int(resultLabel.text ?? "0") ?? 0
//    }

    func getDouble() -> Double {
        return Double(resultLabel.text ?? "0") ?? 0
    }
    
    func calculate() {
        guard let operation = operation else {
            return
        }
            if previousOperation != operation {
                newValueDouble = getDouble()
            }
        // integer -> double чтобы деление было верным и работала "."
            resDouble = operation.makeOperationDouble(result: resDouble, newValue: newValueDouble)
            previousOperation = operation
        //оставить чистое число если оно integer (без чисел после запято)
            resultLabel.text = String(format: "%g", resDouble)
        
//            if previousOperation != operation {
//                newValue = getInteger()
//            }
//            result = operation.makeOperation(result: result, newValue: newValue)
//
//            previousOperation = operation
//
//            resultLabel.text = "\(result)"
        
        isNewValue = true
    }
}

enum MathOperation {
    case sum, substract, multiplication, division
    
//    func makeOperation(result: Int, newValue: Int) -> Int {
//        switch self {
//        case .sum:
//            return (result + newValue)
//        case .substract:
//            return (result - newValue)
//        case .division:
//            return result / newValue
//        case .multiplication:
//            return result * newValue
//        }
//    }
//  тоже самое но для double
    func makeOperationDouble(result: Double, newValue: Double) -> Double {
        switch self {
        case .sum:
            return (result + newValue)
        case .substract:
            return (result - newValue)
        case .division:
            return result / newValue
        case .multiplication:
            return result * newValue
        }
    }
}

