import os
import re
import sys
import unicodedata
from datetime import datetime
from pathlib import Path
from typing import List


def print_full_path(file_names: List[str]):
    paths = [Path(x) for x in file_names]
    foo = [x.absolute() for x in paths if x.exists()]
    for x in foo:
        print(str(x) + ('/' if x.is_dir() else ''))


def resolve_args():
    argvs = sys.argv[1:]
    return argvs[0]


def create_dir_name(name):
    name = str(name).strip().replace(' ', '_')
    name = re.sub(r'(?u)[^-\w.]', '', name)
    name = re.sub(r"[^\w\s]", '', name)
    name = re.sub(r"\s+", '_', name)

    max_len = 50
    date_fragment = datetime.now().strftime('%y%m%dT%H%M%S')
    return unicodedata.normalize('NFKD', name).encode('ascii', 'ignore').decode('ascii')[0:max_len] + '_' + date_fragment


def create_parent_dir(args):
    path = Path(args).resolve()
    assert path.is_file() and path.exists(), "{} is not a file path".format(path)

    parent = path.parent
    inter_dir = create_dir_name(path.name)
    new_parent = parent / inter_dir
    new_parent.mkdir(parents=True, exist_ok=True)

    os.rename(path, new_parent / path.name)
    return new_parent


if __name__ == '__main__':
    args = resolve_args()
    new_dir = create_parent_dir(args)
    sys.stdout.write(str(new_dir))
