import UIKit
//
//1. Создайте класс животного Animal.
//    2. У животного должны быть характеристики:
//энергия,
//вес,
//текущий возраст,
//максимальный возраст,
//имя.
//Энергия, вес, максимальный возраст и имя должны инициализироваться через конструктор.

class Animal {
    public var energy: Int
    public var weight: Int
    public var currentAge: Int
    public var maxAge: Int
    public var name: String
    
//    3. Добавьте вычисляемое свойство isTooOld — Boolean.
//    Оно должно сравнивать текущий возраст с максимальным и возвращать true, если текущий возраст равен или больше максимального.
    //вернуть значение true/false
    private var isTooOld: Bool {
        get {
            return currentAge >= maxAge ? true : false
        }
    }
//    4. Животное может спать, питаться и передвигаться.
//    Во время сна:
//    Энергия животного увеличивается на 5, а возраст — на 1.
//    В консоль выводится сообщение: «${имя животного} спит».
//    Во время питания:
//    Энергия животного увеличивается на 3, а вес — на 1.
//    Возраст животного может увеличиться на 1.
//    В консоль выводится сообщение: «${имя животного} ест».
//    Во время передвижения:
//    Энергия животного уменьшается на 5, а вес — на 1.
//    Возраст животного может увеличиться на 1.
//    В консоль выводится сообщение: «${имя животного} передвигается».
//      сон
    public func sleep () {
        //проверка на то, что животное может продолжать (в данном улчае только возраст)
        if isTooOld {
            print("\(self.name) не может продолжать, слишком стар")
            return
        }
        self.energy += 5
        self.currentAge += 1
        print ("\(self.name) спит")
    }
    
    public func eat () {
        //проверка на то, что животное может продолжать (в данном улчае только возраст)
        if isTooOld {
            print("\(self.name) не может продолжать, слишком стар")
            return
        }
        self.energy += 3
        self.weight += 1
        tryIncrementAge()
        print ("\(self.name) ест")
    }
    
    public func moving () {
        //проверка на то, что животное может продолжать (тут все проверки)
        if self.energy < 5 {
            print("\(self.name) не может продолжат , устал")
            return
        } else if isTooOld {
            print("\(self.name) не может продолжать , стар")
            return
        } else if self.weight <= 0 {
            print("\(self.name) не может продолжать, недостаточно веса")
            return
        }
        
        self.energy -= 5
        self.weight -= 1
        tryIncrementAge()
        var res : String {
            get {
                return "\(self.name) передвигается"
            }
        }
        print(res)
    }
//    5. Случайное увеличение возраста реализуйте с помощью класса Bool и его метода random()
//    Пример использования:
//    if (Bool.random()) {
//      //увеличить возраст
//    }
//    Вынесите случайное увеличение возраста в метод — tryIncrementAge
//    *Если животное слишком старое, если не хватает веса или энергии для совершения действия, то ничего не происходит.
    //рандом для добавления возраста
    private func tryIncrementAge () {
        if Bool.random() {
            currentAge += 1
        }
    }
//    6. Животное может производить потомство.
//    Имя и максимальный возраст у рождённого животного такие же, как и у родителя.
//    Энергия для рождённого животного устанавливается случайно в диапазоне от 1 до 10.
//    Вес для рождённого животного устанавливается случайно в диапазоне от 1 до 5.
//    В консоль должно выводиться сообщение о том, какое животное было рождено и какие у него характеристики
    // рождение ребенка
    public func bornChild () -> Animal {
        let child = Animal(
            energy: Int.random(in: 1...10),
            weight: Int.random(in: 1...5),
            currentAge: 0,
            maxAge: self.maxAge,
            name: self.name
        )
        print("Ребенок: энергия: \(child.energy), вес: \(child.weight), текущий возраст: \(child.currentAge), максимальный возраст: \(child.maxAge), имя: \(child.name)")
        return child
    }
    //инициализатор
    init (energy: Int, weight: Int, currentAge: Int, maxAge: Int, name: String){
        self.energy = energy
        self.weight = weight
        self.currentAge = currentAge
        self.maxAge = maxAge
        self.name = name
    }
}

//7. Создайте наследников класса Animal: Bird, Fish, Dog.
//8. В каждом из наследников переопределите функцию, отвечающую за передвижение. Для каждого наследника в этой функции необходимо вызвать родительскую реализацию и дополнительно вывести в консоль сообщение:
//
//   для Bird — «летит»,
//   для Fish — «плывет»,
//   для Dog — «бежит».
class Bird: Animal {
    //переопределение движения для птицы
    override public func moving() {
        super.moving()
        print ("летит")
    }
    //   9. В каждом из наследников переопределите функцию, отвечающую за рождение потомка. Класс Fish должен возвращать объект класса Fish. Аналогично с Bird и Dog.
    //переопределение рождения для птицы
    override public func bornChild () -> Bird {
        let child = Bird(
            energy: Int.random(in: 1...10),
            weight: Int.random(in: 1...5),
            currentAge: 0,
            maxAge: self.maxAge,
            name: self.name
        )
        print("Ребенок Птицы: энергия: \(child.energy), вес: \(child.weight), текущий возраст: \(child.currentAge), максимальный возраст: \(child.maxAge), имя: \(child.name)")
        return child
    }
}

class Fish: Animal {
    //переопределние движеия для рыбы
    override func moving() {
        super.moving()
        print ("плывет")
    }
    //   9. В каждом из наследников переопределите функцию, отвечающую за рождение потомка. Класс Fish должен возвращать объект класса Fish. Аналогично с Bird и Dog.
    //переопределение рождения для рыбы
    override func bornChild () -> Fish {
        let child = Fish(
            energy: Int.random(in: 1...10),
            weight: Int.random(in: 1...5),
            currentAge: 0,
            maxAge: self.maxAge,
            name: self.name
        )
        print("Ребенок рыбы: энергия: \(child.energy), вес: \(child.weight), текущий возраст: \(child.currentAge), максимальный возраст: \(child.maxAge), имя: \(child.name)")
        return child
    }
}

class Dog: Animal {
    //переопределние движеия для собаки
    override public func moving() {
        super.moving()
        print("бежит")
    }
    //   9. В каждом из наследников переопределите функцию, отвечающую за рождение потомка. Класс Fish должен возвращать объект класса Fish. Аналогично с Bird и Dog.
    //переопределение рождения для собаки
    override public func bornChild () -> Dog {
        let child = Dog(
            energy: Int.random(in: 1...10),
            weight: Int.random(in: 1...5),
            currentAge: 0,
            maxAge: self.maxAge,
            name: self.name
        )
        print("Ребенок собаки: энергия: \(child.energy), вес: \(child.weight), текущий возраст: \(child.currentAge), максимальный возраст: \(child.maxAge), имя: \(child.name)")
        return child
    }
}

//10. Создайте класс NatureReserve, который представляет из себя заповедник с разными животными.
class NatureReserve {
    private var birds : [Bird]
    private var fishes : [Fish]
    private var dogs : [Dog]
    private var animals : [Animal]
//    12. Напишите программу, которая имитирует жизненный цикл животных в заповеднике.
//    В течение ограниченного числа итераций N каждое животное делает одно случайное действие, которое позволяют сделать его свойства: ест, спит, двигается, рожает.
//    Когда у животного рождается детёныш, он добавляется к общему количеству животных заповедника.
    
    //действия рыбы
    private func actionFish(choice: Int) {
        print("Рыб в заповеднике: \(fishes.count)")
        //еда
        if choice == 0 {
            //рыбы существуют
            if fishes.count > 0 {
                //само действие + удаление из массива
                for i in 0...fishes.count - 1 {
                    for j in 0...fishes.count - 1 {
                        if i == j {
                            fishes[j].eat()
                            if fishes[j].currentAge >= fishes[j].maxAge {
                                print("Удалена рыба \(fishes[j].name)")
                                fishes.remove(at: j)
                            }
                        }
                    }
                }
            }
            //сон
        } else if choice == 1 {
            if fishes.count > 0 {
                for i in 0...fishes.count - 1 {
                    for j in 0...fishes.count - 1 {
                        if i == j {
                            fishes[j].sleep()
                            if fishes[j].currentAge >= fishes[j].maxAge {
                                print("Удалена рыба \(fishes[j].name)")
                                fishes.remove(at: j)
                            }
                        }
                    }
                }
            }
            //движение
        } else if choice == 2 {
            for i in 0...fishes.count - 1{
                fishes[i].moving()
            }
            //рождение
        } else {
            for i in 0...fishes.count - 1{
                fishes.append(fishes[i].bornChild())
            }
        }
    }
    //Действия птицы
    private func actionBird(choice: Int) {
        print("Птиц в заповеднике: \(birds.count)")
        //еда
        if choice == 0 {
            if birds.count > 0 {
                for i in 0...birds.count - 1 {
                    for j in 0...birds.count - 1 {
                        if i == j {
                            birds[j].eat()
                            if birds[j].currentAge >= birds[j].maxAge {
                                print("Удалена птица \(birds[j].name)")
                                birds.remove(at: j)
                            }
                        }
                    }
                }
            }
            //сон
        } else if choice == 1 {
            if birds.count > 0 {
                for i in 0...birds.count - 1 {
                    for j in 0...birds.count - 1 {
                        if i == j {
                            birds[j].sleep()
                            if birds[j].currentAge >= birds[j].maxAge {
                                print("Удалена птица \(birds[j].name)")
                                birds.remove(at: j)
                            }
                        }
                    }
                }
            }
            //движение
        } else if choice == 2 {
            for i in 0...birds.count - 1{
                birds[i].moving()
            }
            //рождение (добавление в конец массива птиц
        } else {
            for i in 0...birds.count - 1{
                birds.append(birds[i].bornChild())
            }
        }
    }

    private func actionAnimal(choice: Int) {
        print("Других животных в заповеднике: \(animals.count)")
        //еда
        if choice == 0 {
            if animals.count > 0 {
                for i in 0...animals.count - 1{
                    for j in 0...animals.count - 1 {
                        if i == j {
                            animals[j].eat()
                            if animals[i].currentAge >= animals[j].maxAge {
                                print("Удалено животное \(animals[j].name)")
                                animals.remove(at: j)
                            }
                        }
                    }
                }
            }
            //сон
        } else if choice == 1 {
            if animals.count > 0 {
                for i in 0...animals.count - 1{
                    for j in 0...animals.count - 1 {
                        if i == j {
                            animals[j].sleep()
                            if animals[i].currentAge >= animals[j].maxAge {
                                print("Удалено животное \(animals[j].name)")
                                animals.remove(at: j)
                            }
                        }
                    }
                }
            }
            //движение
        } else if choice == 2 {
            for i in 0...animals.count - 1{
                animals[i].moving()
            }
            //рождение (добавление в конец массива птиц
        } else {
            for i in 0...animals.count - 1{
                animals.append(animals[i].bornChild())
            }
        }
        
    }
    
    private func actionDogs(choice: Int) {
        print("Собак в заповеднике: \(dogs.count)")
        //еда
        if choice == 0 {
            if dogs.count > 0 {
                for i in 0...dogs.count - 1{
                    for j in 0...dogs.count - 1 {
                        if i == j {
                            dogs[j].eat()
                            if dogs[j].currentAge >= dogs[j].maxAge {
                                print("Удалена собака \(dogs[j].name)")
                                dogs.remove(at: j)
                            }
                        }
                    }
                }
            }
            //сон
        } else if choice == 1 {
            if dogs.count > 0 {
                for i in 0...dogs.count - 1{
                    for j in 0...dogs.count - 1 {
                        if i == j {
                            dogs[j].sleep()
                            if dogs[j].currentAge >= dogs[j].maxAge {
                                print("Удалена собака \(dogs[j].name)")
                                dogs.remove(at: j)
                            }
                        }
                    }
                }
            }
            //движение
        } else if choice == 2 {
            for i in 0...dogs.count - 1{
                dogs[i].moving()
            }
            //рождение (добавление в конец массива птиц
        } else {
            for i in 0...dogs.count - 1{
                dogs.append(dogs[i].bornChild())
            }
        }

    }
    // функции для выведения в конце животных, которые остались живы
//    func printBirds (){
//        if birds.count > 0 {
//            for i in 0...birds.count - 1{
//                print("Имя: \(birds[i].name): энергия: \(birds[i].energy), вес: \(birds[i].weight), текущий возраст: \(birds[i].currentAge), максимальный возраст: \(birds[i].maxAge)")
//            }
//        } else {
//            print("Больше нет птиц")
//        }
//    }
//    func printFishes (){
//        if fishes.count > 0 {
//            for i in 0...fishes.count - 1{
//                print("Имя: \(fishes[i].name): энергия: \(fishes[i].energy), вес: \(fishes[i].weight), текущий возраст: \(fishes[i].currentAge), максимальный возраст: \(fishes[i].maxAge)")
//            }
//        } else {
//            print ("Больше нет рыб")
//        }
//    }
//    func printDogs (){
//        if dogs.count > 0 {
//            for i in 0...dogs.count - 1{
//                print("Имя: \(dogs[i].name): энергия: \(dogs[i].energy), вес: \(dogs[i].weight), текущий возраст: \(dogs[i].currentAge), максимальный возраст: \(dogs[i].maxAge)")
//            }
//        } else {
//            print ("Больше нет собак")
//        }
//    }
//    func printAnimals (){
//        if animals.count > 0 {
//        for i in 0...animals.count - 1{
//            print("Имя: \(animals[i].name): энергия: \(animals[i].energy), вес: \(animals[i].weight), текущий возраст: \(animals[i].currentAge), максимальный возраст: \(animals[i].maxAge)")
//
//            }
//        } else {
//            print("Больше нет других животных")
//        }
//    }
//    Если все животные исчезли — программа должна прерываться, с выводом соответствующего сообщения.
    public var iterations : Int
    public func res (){
        for i in 0...iterations {
            print ("\nИтерация \(i):")
            //по заданию
//            let action = Int.random(in: 0...3)
            //проверка еды
//            let action = 0
//            //проверка сна а так же удаления (так как повышение возраста 100% во сне), минимум итераций: 6
            let action = 1
//            //проверка движения
//            let action = 2
            //проверка рождения, !!!!лучше уменьшить число итераций с 7 до 1!!!
//            let action = 3
            //еда
            if action == 0 {
                actionFish(choice: action)
                actionBird(choice: action)
                actionDogs(choice: action)
                actionAnimal(choice: action)
                //сон
            } else if action == 1 {
                actionFish(choice: action)
                actionBird(choice: action)
                actionDogs(choice: action)
                actionAnimal(choice: action)
                //движение
            } else if action == 2 {
                actionFish(choice: action)
                actionBird(choice: action)
                actionDogs(choice: action)
                actionAnimal(choice: action)
//                рождение
            } else {
                actionFish(choice: action)
                actionBird(choice: action)
                actionDogs(choice: action)
                actionAnimal(choice: action)
            }
        //    В конце итерации все животные, у которых возраст превысил максимальный, удаляются из заповедника.
            // !!!* p.s. хоть и задание говорит о том, чтобы возраст превысил максимальный, но это конфликтует с заданием 5,
            // в котором "Если животное слишком старое, если не хватает веса или энергии для совершения действия, то ничего не происходит", а для "слишком старого" у нас есть isTooOld,в в котором "слишком старый" это >= (то есть никогда не произойдет таокго, что возраст превысит максимальный). Возьмем в виде исключения ибо это урок, а не тз, то опустим "превысил максимальный" на "слишком старый" (>= или isTooOld (не стал менять на это)).
            //!!!
            
            if dogs.isEmpty && birds.isEmpty && animals.isEmpty && fishes.isEmpty {
                print("Число оставшихся животных: 0")
                return
            }
        }
        //    По окончании работы должно выводиться число животных в заповеднике, которые остались живы.
//        printBirds()
//        printFishes()
//        printDogs()
//        printAnimals()
        let numbersOfAllAnimals = dogs.count + fishes.count + animals.count + birds.count
        print ("\nЧисло оставшихся животных: \(numbersOfAllAnimals)")
    }

    //    11. Инициализируйте заповедник. Изначально в нём должно быть пять птиц, три рыбы, две собаки и несколько обычных животных
    init (iterations: Int){
        self.iterations = iterations
        birds = [Bird(energy: 10, weight: 5, currentAge: 2, maxAge: 5, name: "Средняя птица"),
                 Bird(energy: 2, weight: 5, currentAge: 3, maxAge: 7, name: "Птица с малой энергией"),
                 Bird(energy: 10, weight: 1, currentAge: 3, maxAge: 9, name: "Птица с малым весом"),
                 Bird(energy: 10, weight: 5, currentAge: 5, maxAge: 6, name: "Старая птица"),
                 Bird(energy: 10, weight: 10, currentAge: 2, maxAge: 6, name: "Просто птица")
        ]
        fishes = [Fish(energy: 2, weight: 5, currentAge: 3, maxAge: 7, name: "Рыба с малой энергией"),
                  Fish(energy: 10, weight: 1, currentAge: 3, maxAge: 9, name: "Рыбв с малым весом"),
                  Fish(energy: 10, weight: 5, currentAge: 5, maxAge: 6, name: "Старая рыба")
        ]
        dogs = [Dog(energy: 10, weight: 1, currentAge: 3, maxAge: 9, name: "Собака с малым весом"),
                Dog(energy: 10, weight: 5, currentAge: 5, maxAge: 6, name: "Старая собака")
        ]
        animals = [Animal(energy: 10, weight: 1, currentAge: 3, maxAge: 9, name: "Животное с малым весом"),
                   Animal(energy: 10, weight: 5, currentAge: 5, maxAge: 6, name: "Старое животное")
        ]
    }
}
//вызов основной функции
let myNatureReserve = NatureReserve(iterations: 6)
myNatureReserve.res()

