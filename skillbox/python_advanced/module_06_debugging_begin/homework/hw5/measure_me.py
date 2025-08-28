"""
Каждый лог содержит в себе метку времени, а значит, правильно организовав логирование,
можно отследить, сколько времени выполняется функция.

Программа, которую вы видите, по умолчанию пишет логи в stdout. Внутри неё есть функция measure_me,
в начале и в конце которой пишется "Enter measure_me" и "Leave measure_me".
Сконфигурируйте логгер, запустите программу, соберите логи и посчитайте среднее время выполнения функции measure_me.
"""
import logging
import random
from datetime import datetime
from typing import List

logger = logging.getLogger(__name__)

def get_data_line(sz: int) -> List[int]:
    try:
        logger.debug("Enter get_data_line")
        return [random.randint(-(2 ** 31), 2 ** 31 - 1) for _ in range(sz)]
    finally:
        logger.debug("Leave get_data_line")

def measure_me(nums: List[int]) -> List[List[int]]:
    logger.debug("Enter measure_me")
    results = []
    nums.sort()

    for i in range(len(nums) - 2):
        logger.debug(f"Iteration {i}")
        left = i + 1
        right = len(nums) - 1
        target = 0 - nums[i]
        if i == 0 or nums[i] != nums[i - 1]:
            while left < right:
                s = nums[left] + nums[right]
                if s == target:
                    logger.debug(f"Found {target}")
                    results.append([nums[i], nums[left], nums[right]])
                    logger.debug(
                        f"Appended {[nums[i], nums[left], nums[right]]} to result"
                    )
                    while left < right and nums[left] == nums[left + 1]:
                        left += 1
                    while left < right and nums[right] == nums[right - 1]:
                        right -= 1
                    left += 1
                    right -= 1
                elif s < target:
                    logger.debug(f"Increment left (left, right) = {left, right}")
                    left += 1
                else:
                    logger.debug(f"Decrement right (left, right) = {left, right}")

                    right -= 1
    logger.debug("Leave measure_me")
    return results

def find_measure_me_and_get_time_difference():
    """
    Подсчет времени выполнения measure_me (разницы времени между двумя Enter measure_me и Leave measure_me)
    Returns:
        среднее время выполнение функции measure_me
    """
    all_time_differences = []
    start_time = 0
    end_time = 0

    with open("stderr.txt", "r") as f:
        for line in f:
            if "Enter measure_me" in line:
                timestamp_str = line.split()[0] + " " + line.split()[1]
                start_time = datetime.strptime(timestamp_str, '%Y-%m-%d %H:%M:%S.%f')  # Adjust format if needed
                start_time = start_time.timestamp()
            elif "Leave measure_me" in line:
                timestamp_str = line.split()[0] + " " + line.split()[1]
                end_time = datetime.strptime(timestamp_str, '%Y-%m-%d %H:%M:%S.%f')  # Adjust format if needed
                end_time = end_time.timestamp()
            if start_time != 0 and end_time != 0:
                time_difference = end_time - start_time
                all_time_differences.append(time_difference)
                start_time, end_time = 0, 0
    for k, v in enumerate(all_time_differences):
        print(f'{k + 1} = {v + 1} s')
    sum_time = 0
    for item in all_time_differences:
        sum_time += item
    return sum_time / len(all_time_differences)


if __name__ == "__main__":
    logging.basicConfig(level="DEBUG", filename="stderr.txt",
                        format='%(asctime)s.%(msecs)03d %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
    for it in range(15):
        data_line = get_data_line(10 ** 3)
        measure_me(data_line)
        # print(f"MEASURE_TIME {it+1} DONE")

    print(f"Average time is {find_measure_me_and_get_time_difference():.4f} s")