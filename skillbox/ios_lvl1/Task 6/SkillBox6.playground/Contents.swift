import UIKit
import Foundation
//Задание 1
//
//Мы можем воспользоваться массивом строк [String], чтобы по номеру дня недели получать название дня недели: let days = [“Monday”, “Tuesday”, “Wednesday”, “Thursday”, “Friday”, “Saturday”, “Sunday”].
//
//day[0] — первый день недели
//
//Теперь нам нужно получить по названию дня недели его номер. Реализуйте словарь, который позволит это сделать.
print ("Задание 1")
let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
let dictionaryDays = [days[0]:1, days[1]:2 , days[2]:3, days[3]:4, days[4]:5, days[5]:6, days[6]:7]
print("Понедельник - это \(dictionaryDays[days[0]]!) день недели")
let name = "Tuesday"
print("Tuesday - is a \(dictionaryDays[name]!) day of the week")

//Задание 2
//
//С помощью итерирования по созданному словарю выведите названия всех дней недели и их номера.
//
//Вывод должен осуществляться в консоль. Пример вывода: «Четверг — 4».

print ("\nЗадание 2")
let count = dictionaryDays.count
for i in  0..<count {
    print ("\(days[i]) - \(dictionaryDays[days[i]]!)")
}


//Задание 3
//
//Создайте словарь, который будет представлять собой базу данных паролей пользователей. По строке имени пользователя мы будем хранить строку с паролем.
//
//Добавьте в этот словарь три любые записи.
print ("\nЗадание 3")
var dictionaryUsersPasswords = ["Anton": "ab3d", "George": "ld3!@"]
var arrayOfNames = ["Alice", "Leon", "Klasds"]
var arrayOfPasswords = ["aslfas", "@!13412", "Loaks1"]
//let arrayKeys = Array(dictionaryUsersPasswords.keys)
//for i in 0..<arrayOfNames.count {
//    arrayKeys.forEach{ element in
//        if element == arrayOfNames[i] {
//            print ("Пользователь \(element) уже существует")
//        }
//    }
//}
for i in 0..<arrayOfNames.count {
    dictionaryUsersPasswords[arrayOfNames[i]] =  arrayOfPasswords[i]
}
let arrayofKeys = Array(dictionaryUsersPasswords.keys)
for i in 0..<dictionaryUsersPasswords.count {
    print("\(arrayofKeys[i]) = \(dictionaryUsersPasswords[arrayofKeys[i]]!)")
}

//Задание 4
//
//
//Выше приведён код, в котором объявляется новый тип ошибки с помощью enum. Добавьте в него ещё два случая ошибки. Назовите их userNotFound и invalidUsername. Не забудьте добавить описание ошибок для новых случаев в соответствующий метод. Ошибка invalidUsername должна иметь ассоциированное значение — некорректный символ в имени пользователя.
enum CustomError : Error, LocalizedError{
    case invalidPassword
    case userNotFound
    case invalidUsername
    
    public var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "Неправильный пароль"
        case .invalidUsername:
            return "Некорректный символ в имени пользователя"
        case .userNotFound:
            return "Пользователь не найден"
        }
    }
}


//Задание 5
//
//Напишите функцию обработки имени пользователя и пароля. Функция должна принимать два аргумента и, если такая запись в базе данных отсутствует или имя пользователя неверное, выбрасывать соответствующую ошибку.
print ("\nЗадание 5")
func abc (username: String, password: String) {
    let arrayOfKeys = Array(dictionaryUsersPasswords.keys)
//    let arrayOfValues = Array(dictionaryUsersPasswords.values)
    let err1 = CustomError.invalidPassword
    let err2 = CustomError.userNotFound
    let err3 = CustomError.invalidUsername
    var inc = 0
    //проверка на спец символ
    let hasSpecialCharacters =  username.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression)
    if  hasSpecialCharacters != nil {
        print(err3.errorDescription!)
        return
    }
    //проверка на существование в списке
    for i in 0..<arrayOfKeys.count {
        if username != arrayOfKeys[i] {
            inc += 1
        } else { break }
    }
    if inc == arrayOfKeys.count {
        print(err2.errorDescription!)
        return
    }
    //проверка на пароль
    for i in 0..<dictionaryUsersPasswords.count {
        if arrayOfKeys[i] == username {
            if dictionaryUsersPasswords[arrayOfKeys[i]] != password {
                print(err1.errorDescription!)
            } else {
                print ("Имя пользователя и пароль верны")
            }
        }
    }
}
print("Проверка если не найден пользователь")
abc(username: "Alic", password: "aslfas")
print("\nПроверка если неправильный пароль")
abc(username: "Alice", password: "aslfa")
print("\nПроверка если имя пользователя со спец знаками")
abc(username: "Al!c", password: "aslfas")
print("\nПроверка если все верно")
abc(username: "Anton", password: "ab3d")
//Задание 6
//
//Напишите код обработки ошибки из функции в задании 5. Выведите описание ошибки, если она произошла, а иначе выведите сообщение, что вход в систему успешно осуществлён.
//
//Обработку ошибки сделайте двумя способами из лекции:
//
//    С помощью конструкции do-catch.
//    С помощью try?.

print ("\nЗадание 6")

func task6(username: String, password: String) throws {
//   let hasSpecialCharacters =  username.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression)
    let arrayOfKeys = Array(dictionaryUsersPasswords.keys)
    var inc = 0
//    guard hasSpecialCharacters == nil else {
//        throw CustomError.invalidUsername
//    }
    //проверка на правильность ввода
    for character in username {
        guard character.isLetter else {
           throw CustomError.invalidUsername
        }
    }
    //проверка на существование в списке
    for i in 0..<arrayOfKeys.count {
        if username != arrayOfKeys[i] {
            inc += 1
        } else {
            break }
    }
    
    guard inc != arrayOfKeys.count else {
        throw CustomError.userNotFound
    }
    //проверка на совпадение с паролем
    for i in 0..<dictionaryUsersPasswords.count {
        if arrayOfKeys[i] == username {
            guard dictionaryUsersPasswords[arrayOfKeys[i]] == password else {
                throw CustomError.invalidPassword
            }
        }
    }
    
}
func doTryCatch(username: String, password: String){
    do {
        try task6(username: username, password: password)
        print ("Имя пользователя и пароль верны")
        
    } catch {
        print(error.localizedDescription)
    }
}
print("1) do-catch")
print("Проверка если не найден пользователь")
doTryCatch(username: "Alic", password: "aslfas")
print("\nПроверка если неправильный пароль")
doTryCatch(username: "Alice", password: "aslfa")
print("\nПроверка если имя пользователя со спец знаками")
doTryCatch(username: "Al!c", password: "aslfas")
print("\nПроверка если все верно")
doTryCatch(username: "Alice", password: "aslfas")

func tryQuestion(username: String, password: String){
    if (try? task6(username: username, password: password)) == nil {
        print ("Вход в систему не выполнен")
    } else {
        print ("Вход в систему успешно выполнен")
    }
}
print("2) Try?")
print("\nПроверка если имя пользователя со спец знаками")
tryQuestion(username: "Al!c", password: "aslfas")
print("\nПроверка если все верно")
tryQuestion(username:"Alice", password:"aslfas")
