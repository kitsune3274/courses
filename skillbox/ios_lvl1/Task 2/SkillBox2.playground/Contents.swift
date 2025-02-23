import UIKit

// Задание 1
print ("Задание 1")
func nextNumber(number: Int) -> Int {
    return number+1
}

print ("Меньше нуля: \(nextNumber(number: -66))")
print ("Нуль: \(nextNumber(number: 0))")
print ("Больше нуля: \(nextNumber(number: 1))")

// Задание 2
print ("\nЗадание 2")
func getSquare(number: Int) -> Int {
    return number*number
}

let value = getSquare(number: 3)
print("Квадрат: \(value)")

//Задание 3
print ("\nЗадание 3")
//var time : (minutes: Int, seconds: Int) = (1, 5)
func getTime(seconds: Int) -> (Int, Int) {
    return (seconds / 60, seconds % 60)
}
let c : (minutes: Int, seconds: Int) = getTime(seconds: 99)
print ("Время: \(c.minutes) минут и \(c.seconds) секунд")

//Задание 4
print ("\nЗадание 4")
func concat (str1: String, str2: String) -> String {
    return str1 + str2
}
let string1 = "Writing Swift code "
let string2 = "is interactive and fun"
print ("Полученная строка : \(concat(str1: string1, str2: string2))")

//Задание 5
//
print ("\nЗадание 5")
func getDate (str1: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: str1)!
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
    let finalDate = calendar.date(from: components)
    return finalDate!
}

let result = getDate(str1: "2004-11-23")
let formatterCheckResult = DateFormatter()
formatterCheckResult.dateFormat = "yyyy-MM-dd"
let stringToDateResult = formatterCheckResult.string(from: result)
print (stringToDateResult)

