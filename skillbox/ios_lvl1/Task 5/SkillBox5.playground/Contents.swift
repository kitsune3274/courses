import UIKit

// Задание 1
/* Напишите функцию, которая принимает в качестве параметра массив целых чисел Int (как отрицательных, так и положительных) и возвращает массив, в котором каждое число меньше 0 заменено на 0, а сам массив отсортирован так, чтобы все элементы со значением, равным 0, были в начале. */
print("Задание 1")
//Инициализировали массив целых чисел
var newArray = [Int]()
//Количество элементов в массиве
let count = 10
// Создали массив со случайными элементами
for _ in 0..<count {
    let randomInt = Int.random(in: -10...10)
    newArray.append(randomInt)
}
print("Массив со случайныии элементами: \n\(newArray)")
//Функция сортировки массива
func sortArray (testArray: [Int]) -> [Int] {
    if testArray.isEmpty {
        print("Массив пуст")
        return testArray
    }
    var arr = testArray
    //Заменили значения ниже 0 на 0
    for i in 0..<arr.count {
        if arr[i] < 0 { arr[i] = 0 }
    }
    //Отсортировали массив
    arr.sort{ item1, item2 in item1 < item2 }
    return arr
}
//Результат
let sortedArray = sortArray(testArray: newArray)
print("Массив с отсортированными элементами и без элементов ниже 0: \n\(sortedArray)")
let emptySortedArray = sortArray(testArray: [])
print("Пустой массив: \n\(emptySortedArray)")
// Задание 2
/* Напишите функцию, которая принимает в качестве параметра массив и возвращает его в обратном порядке. */
print("\nЗадание 2")
//Инициализация различных массивов
var testIntArray = [1, 3, 6, 8, -10, 7, 2]
var testStringArray = ["fa", "abc", "bc", "woit"]
var testDoubleArray = [9.1, 4.3, -4.33, -6.224]
let testEmptyArray: [Int] = []
//Функция сортировки в обратном порядке
func reverseArr (arr: [Any]) -> [Any] {
    if arr.isEmpty {
        print ("Массив пустой")
        return arr
    }
    else { return arr.reversed() }
}
//Результаты
print("Отсортированный массив целых чисел:\n\(reverseArr(arr: testIntArray))")
print("Отсортированный массив строк:\n\(reverseArr(arr: testStringArray))")
print("Отсортированный массив вещественных чисел:\n\(reverseArr(arr: testDoubleArray))")
print("Пустой массив:\n\(reverseArr(arr: testEmptyArray))")
// Задание 3
/* Напишите функцию, которая принимает в качестве параметров целое число и замыкание и вызывает внутри себя замыкание для проверки значения.
   Напишите замыкание, которое принимает в качестве параметра целое число и затем печатает в консоль название месяца, порядковый номер которого соответствует переданному параметру.
    Вызовите функцию, передав в неё значения для проверки.*/
print("\nЗадание 3")
let customClosure: (Int) -> Void = { int1 in
    let arr1 = ["Январь", "Февраль",
                "Март", "Апрель", "Май",
                "Июнь", "Июль", "Август",
                "Сентябрь", "Октябрь", "Ноябрь",
                "Декабрь"]
    if int1 > 12 || int1 < 1 {
        print ("Не существует такого месяца")
        return()
    }
    for (i, n) in arr1.enumerated() {
        if i == int1 - 1 { print ("Месяц: \(n)")  }
    }
}

func callMonth (int1: Int, closure: (Int) -> Void) {
    closure (int1)
   
}
print ("Проверка работоспособности")
callMonth (int1: 3, closure: customClosure)
print ("Проверка выхода за рамки месяцев")
callMonth (int1: 13, closure: customClosure)

// Задание 4
/* Напишите функцию, которая принимает в качестве параметров массив целых чисел и замыкание из задания 3. Внутри функции напишите код, где для каждого элемента в массиве вызывается передаваемое замыкание методом forEach(). Если передаётся пустой массив, то печатается «Месяцев нет».
*/
print("\nЗадание 4")

func callMonthFromArray (intArr: [Int], closure: (Int) -> Void) {
    if intArr.isEmpty {
        print ("Месяцев нет")
        return
    }
    intArr.enumerated().forEach { _ , element in
        closure (element)
    }
}
print ("Проверка работоспособности")
callMonthFromArray(intArr: [1, 3, 5, 13], closure: customClosure)
print ("Проверка пустого множестсва")
callMonthFromArray(intArr: [], closure: customClosure)


// Задание 5
/*Создайте пустое множество строк fruits и добавьте в него фрукты: orange, apple, banana, grapefruit.
 Создайте множество redFood из элементов apple, tomato, grapefruit, strawberry.
 Найдите с помощью операций над множествами множества красных фруктов, множество красных продуктов, но не фруктов, и множество всей еды, кроме красных фруктов.
*/
print("\nЗадание 5")
	
var fruits: Set<String> = []
fruits.insert("orange")
fruits.insert("apple")
fruits.insert("banana")
fruits.insert("grapefruit")
//print(fruits) // ["orange", "banana", "apple", "grapefruit"]
var redFood: Set<String> = ["apple", "tomato", "grapefruit", "strawberry"]

print ("Красные фрукты ")
//var a1 = fruits.intersection(redFood)
print ("\(fruits.intersection(redFood))")
print ("Красные продукты, но не фрукты ")
//var a2 = redFood.subtracting(fruits)
print ("\(redFood.subtracting(fruits))")
print ("Все, кроме красных фруктов")
//var a3 = fruits.symmetricDifference(redFood)
print("\(fruits.symmetricDifference(redFood))")
