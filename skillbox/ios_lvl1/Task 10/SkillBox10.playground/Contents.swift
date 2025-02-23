import UIKit
import Foundation

//Задание 1
//Объявите три сущности, которые реализует предоставленный вам протокол. После этого для всех сущностей вызовите все методы и свойства, объявленные в протоколе.
//
//Должны выполняться следующие условия:
//Объявлены класс, структура и перечисления enum, которые реализует данный протокол.
//Реализация протокола может быть любой.
//Вызваны все свойства и методы протокола у каждого экземпляра из пункта 1.
//Задание сделано без изменения протокола.


protocol CalorieCountProtocol {
     var calories: Int { get }
     func description() -> String
}


class classTest: CalorieCountProtocol {
    var calories: Int
    func description() -> String {
        return "Class calories: \(self.calories)"
    }
    init (calories: Int) {
        self.calories = calories
    }
}
struct structTest: CalorieCountProtocol {
    var calories: Int = 5
    func description() -> String {
        return "Struct calories \(self.calories)"
    }
}
enum enumTest : CalorieCountProtocol {
    case num(numb: Int)
//    case num2(Int)
    var calories: Int {
        get {
            return getNum()
        }
    }
    func getNum () -> Int {
        switch self {
        case .num(let count):
            return count
        }
    }
    
    func description() -> String {
        return "Enum calories: \(calories)"
    }
}
let classCrashTest = classTest(calories: 5)
classCrashTest.description()

let structCrashTest = structTest(calories: 10)
structCrashTest.description()

var qwerty: enumTest = .num(numb: 55)
qwerty.description()


//////////////////////////////////////////////////////////////////////////////////////////////////////

//Задание 2
//Поработайте с протоколом Equatable, который нужен для сравнения сущностей.
//Вам предоставлены структура и класс, которые нужно сравнить. Добавьте в объявление этих сущностей протокол Equatable. При необходимости реализуйте недостающий метод.
//
//Должны выполняться следующие условия:
//Структура и класс реализуют протокол Equatable.
//Проведена проверка, что протокол реализуется. Для этого сравните экземпляры этих сущностей с помощью оператора ‘==’.

func == (lhs: Balance, rhs: BalanceObject) -> Bool {
    return lhs.amount == rhs.amount
}

enum BalanceType {
    case positive, negative, neutral
}

struct Balance: Equatable {
    let type: BalanceType
    let amount: Int
}

class BalanceObject: Equatable {
    var amount: Int = 0
    static func == (lhs: BalanceObject, rhs: BalanceObject) -> Bool {
        return lhs.amount == rhs.amount
    }
    init (amount: Int) {
        self.amount = amount
    }
}

let structObj = Balance(type: .positive, amount: 5)
let classObj = BalanceObject(amount: 6)
structObj == classObj
let classObj2 = BalanceObject(amount: 6)
classObj == classObj2

//////////////////////////////////////////////////////////////////////////////////////////////////////

//Задание 3
//Вам дан протокол и три сущности, которые его реализуют. Добавьте в протокол новый метод. Реализуйте этот метод с помощью расширения протокола. Создайте массив из этих сущностей и вызовите в цикле новый метод у каждого элемента массива.
//Должны выполняться следующие условия:
//В протокол добавлен метод func speak() -> String.
//Реализация метода из пункта 1 сделана с помощью расширения.
//Создан массив, содержащий как минимум один экземпляр каждой сущности.
//У каждого элемента массива вызван новый метод.

protocol Dog {
    var name: String { get set }
    var color: String { get set }
}
//В протокол добавлен метод func speak() -> String.
//Реализация метода из пункта 1 сделана с помощью расширения.
extension Dog {
    func speak() -> String {
        return "woof"
    }
}

struct Haski: Dog {
    var name: String
    var color: String
}

class Corgi: Dog {
    var name: String
    var color: String

    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}

struct Hound: Dog {
    var name: String
    var color: String
}

let haski = Haski(name: "Haski1", color: "blue")
let corgi = Corgi(name: "Corgi", color: "white")
let hound = Hound(name: "Hound", color: "black")

//Создан массив, содержащий как минимум один экземпляр каждой сущности.
var asd1: [Any] = [hound, haski, corgi]
//У каждого элемента массива вызван новый метод.
for i in asd1 {
    if let ii = i as? Haski {
        ii.speak()
        print("Haski")
    } else if let ii = i as? Hound {
        ii.speak()
        print("Hound")
    } else if let ii = i as? Corgi {
        ii.speak()
        print("Corgi")
    } else {
        print("не собака из списка")
    }
}
//    guard let ii = i as? Haski else {
//        print("не хаски")
//        continue
//    }
//    guard let ii = i as? Corgi else {
//        print("не корги")
//        continue
//    }
//    guard let ii = i as? Hound else {
//        print("не собака")
//        continue
//    }
//asd1 = [q.speak(), w.speak(), e.speak()]
//let asd = [q.speak(), w.speak(), e.speak()]
