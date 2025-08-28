# Обнаруженные ошибки
1. Отсутствие import datetime при использовании  
**строка, которая выдает ошибку:** `now: datetime.datetime = datetime.datetime.now()`  
**исправление:** добавить `import datetime`  
2. Поставлен оператор сравнения вместо присваивания  
**строка с ошибкой:** `self.address == address`  
**заменить на:** `self.address = address`  
3. Неверное присваивание - присваивание самого себя вместо присваивания полученного параметра  
**строка с ошибкой:** `self.name = self.name`  
**заменить на:** `self.name = name`
4. Неверная запись return - переменная address не передана, а если необходимо обратиться к
своему же параметру address, то необходимо ставить self.address; для полноценной работы
return необходимо изменить выражение на тернарный оператор  
**cтрока с ошибкой:** `return address is None`  
**заменить на:** `return False if self.address else True`  
5. Неправильно выделен docstrings в функции is_homeless (вместо одиночных кавычек нужны двойные)  
**строка с ошибкой:** `''' returns True if address is not set, false in other case '''`  
**заменить на:** `"""" returns True if address is not set, false in other case """`
6. В функции get_age неправильно расчитывается возраст человека  
**строка с ошибкой:** `return self.yob - now.year`  
**заменить на:** `return now.year - self.yob`
