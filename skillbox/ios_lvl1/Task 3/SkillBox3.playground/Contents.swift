import UIKit
import Security

//Задание 1
print ("\nЗадание 1")
func eqOrNot (num1: Int, num2: Int) {
    if num1 > num2 {
        print ("Больше")
    } else if num1 < num2 {
        print ("Меньше")
    } else { print ("Равно") }
}

eqOrNot(num1: 0, num2: 0)
eqOrNot(num1: 2, num2: -1)
eqOrNot(num1: -100, num2: -99)


//Задание 2
print ("\nЗадание 2")
func summ(toValue:Int) {
    var count : Int = 0
    for i in 1..<toValue {
        if i % 2 != 0 { count += i }
    }
    print ("Сумма всех нечетных чисел до заданного числа равна \(count)")
}

summ(toValue: 100)

//Задание 3
print ("\nЗадание 3")
func squareLessThenTarget (number: Int) {
    print ("Числа, квадрат которых меньше заданного числа: ")
    for i in 1...number {
        if i * i <= number { print (i) }
    }
}

squareLessThenTarget(number: 20)

//Задание 4
print ("\nЗадание 4")
func handleDiceRoll (result: Int) {
    switch result {
    case 1, 2, 3:
        print ("Проигрыш")
    case 4, 5, 6:
        print("Победа")
    default:
        print("Кубик оказался слишком большим/маленьким")
    }
}
handleDiceRoll(result: 3)
handleDiceRoll(result: 5)
handleDiceRoll(result: 99)
