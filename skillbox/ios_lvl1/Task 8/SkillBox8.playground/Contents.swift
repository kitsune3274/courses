import UIKit
//Задание 1
//Дана структура Person:
//
//Допишите метод в структуре Person, который сравнивает возраст.
//Должны выполняться следующие условия:
//    1. Формат строки со сравнением:
//{Имя другого человека} {старше меня / моложе меня / такого же возраста, как я}.

struct Person {
    var name: String
    var age: Int
    
    func getAgeComparisonString(_ p: Person) -> String {
        if self.age < p.age {
            return "\(p.name) старше меня"
        } else if self.age > p.age {
            return "\(p.name) младше меня"
        } else {
            return "\(p.name) такого же возраста, как и я"
        }
    }
// Задание 2
    lazy var abc1 = self.age < 5 ? "года" : "лет"
    lazy var info: String = "\(self.name), \(self.age) " + abc1
//    lazy var info2 = self.getInfo()
//    func getInfo () -> String {
//        let indexLast = self.age % 10
//        if indexLast == 1 {
//            return "\(self.name), \(self.age) год"
//        } else if indexLast == 2 || indexLast == 3 || indexLast == 4 {
//            return "\(self.name), \(self.age) года"
//        } else {
//            return "\(self.name), \(self.age) лет"
//        }
//    }
}

//2. Ваш код должен работать следующим образом:

var p1 = Person(name: "Антон", age: 24)
var p2 = Person(name: "Андрей", age: 36)
var p3 = Person(name: "Ольга", age: 24)

p1.getAgeComparisonString(p2) //➞ "Андрей старше меня"
p2.getAgeComparisonString(p1) //➞ "Антон младше меня"
p1.getAgeComparisonString(p3)// ➞ "Ольга такого же возраста, как и я"

//Задание 2
//Добавьте в структуру Person ленивое свойство, которое возвращает человека в виде строки следующего формата {Имя} {Возраст} {года/лет}.
var p4 = Person(name: "Николай", age: 21)
p1.info //-> Антон 24 года
p2.info //-> Андрей 36 лет

//Задание 3
//Создайте класс Hero. Добавьте свойство «количество жизней» — lifeCount. Количество жизней задаётся при создании героя в инициализаторе. Добавьте метод «попадание», который уменьшает количество жизней, — hit().

class Hero {
//    Задание 5
//    Поставьте модификатор доступа private рядом с переменной «количество жизней» в классе Hero, чтобы менять количество жизней можно было только с помощью метода hit().
    private var lifeCount: Int
    //var lifeCount: Int
    func hit() {
        lifeCount -= 16
    }
    //для проверки задания 4
    func heal() {
        lifeCount += 16
    }
    // Задание 4
    //Добавьте в класс Hero вычисляемое свойство, жив или нет герой, — isLive. Если количество жизней больше 0, то возвращает true, в остальных случаях false.
    var isLive : Bool { return self.lifeCount < 0 ? false : true }
    
    
    
    init (lifeCount: Int) {
        self.lifeCount = lifeCount
    }
    
    deinit {
    }
}

var myHero = Hero (lifeCount: 15)
myHero.hit() //-1

// Задание 4

myHero.isLive // false
myHero.heal() // 15
myHero.isLive // true

// Задание 5
//без private = 35
//с private - ошибки

//test.lifeCount += 20 // 35
//print (test.lifeCount)

//Задание 6
//Отнаследуйтесь от класса Hero, создав дочерний класс SuperHero. Переопределите метод «попадание» для нового класса так, чтобы SuperHero не получал повреждения.

class SuperHero: Hero {
    override func hit () {}
//    override func hit(){
//        lifeCount = self.lifeCount
//    }
    
}

var mySuperHero = SuperHero (lifeCount: 45)
mySuperHero.hit()
