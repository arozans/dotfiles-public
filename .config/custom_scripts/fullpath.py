import os
import sys
from datetime import datetime
from pathlib import Path
from typing import List


def print_full_path(file_names: List[str]):
    paths = [Path(x) for x in file_names]
    foo = [x.absolute() for x in paths if x.exists()]
    for x in foo:
        print(str(x) + ('/' if x.is_dir() else ''))
        #        print(str(x).replace(str(Path.home()), '~') + ('/' if x.is_dir() else ''))


def resolve_args():
    argvs = sys.argv[1:]
    # sys.stdout.write(str(Path('.').absolute())+ '\n'*3)

    # foo = [x.replace('\n', '') for x in sys.stdin]
    # sys.stdout.write(str(foo))

    # bar = reduce(lambda x, y: x + y, foo)
    # sys.stdout.write(str(list(sys.stdin)))
    # sys.stdout.write(str(bar))
    # return (sys.stdin).split()

    if argvs:
        base_path = argvs[0]
    else:
        base_path = '.'

    assert Path(base_path).is_dir() and Path(base_path).exists(), "{} dir does not exist".format(base_path)

    return Path(base_path)


def list_contents_by_date(dirpath: Path):
    paths = sorted(Path(dirpath).iterdir(), key=os.path.getctime, reverse=True)
    foo = [x.resolve() for x in paths]
    for x in foo:
        print(datetime.fromtimestamp(x.lstat().st_ctime).strftime('%d.%m.%y %T') + "  " + str(x) + ('/' if x.is_dir() else ''))


if __name__ == '__main__':
    path = resolve_args()
    list_contents_by_date(path)
    # sys.stdout.write(str(args))
    # print_full_path(args)
