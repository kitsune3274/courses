"""
Иногда возникает необходимость перенаправить вывод в нужное нам место внутри программы по ходу её выполнения.
Реализуйте контекстный менеджер, который принимает два IO-объекта (например, открытые файлы)
и перенаправляет туда стандартные потоки stdout и stderr.

Аргументы контекстного менеджера должны быть непозиционными,
чтобы можно было ещё перенаправить только stdout или только stderr.
"""
import sys
import traceback
from types import TracebackType
from typing import Type, Literal, IO


class Redirect:
    """
    Перенаправление вывода стандартных потоков stdout и stderr
    Attributes:
        stdout: IO = None
            IO объект, куда перенаправляется вывод данных sys.stdout
        stderr: IO = None
            IO объект, куда перенаправляется вывод данных sys.stderr
    """
    def __init__(self, stdout: IO = None, stderr: IO = None) -> None:
        self.stdout = stdout
        self.stderr = stderr
        self.og_stdout = sys.stdout
        self.og_stderr = sys.stderr

    def __enter__(self):
        if self.stdout:
            sys.stdout = self.stdout
        if self.stderr:
            sys.stderr = self.stderr
        return self

    def __exit__(
            self,
            exc_type: Type[BaseException] | None,
            exc_val: BaseException | None,
            exc_tb: TracebackType | None
    ) -> Literal[True] | None:
        try:
            if self.stderr and exc_type:
                sys.stderr.write(traceback.format_exc())
                return True
            elif exc_type:
                raise exc_val
        finally:
            if self.stdout:
                sys.stdout = self.og_stdout
            if self.stderr:
                sys.stderr = self.og_stderr


if __name__ == '__main__':
    stdout_file = open('stdout.txt', 'w')
    stderr_file = open('stderr.txt', 'w')

    with Redirect(stdout_file, stderr_file):
        print('Hello stdout')
        raise Exception("Hello stderr")

    stderr_file.close()
    stdout_file.close()