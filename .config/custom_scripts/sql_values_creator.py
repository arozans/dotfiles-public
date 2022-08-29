import sys
from csv import reader, Sniffer
from pathlib import Path


def _read_from_file(param):
    p = Path(param)
    assert p.is_file() and p.exists(), "passed param {} needs to ba non empty file!".format(param)
    lines = p.read_text().split('\n')
    return lines


def _read_from_stdin():
    lines = []
    for line in sys.stdin:
        lines.append(line)
    return lines


def transform_to_sql_values():
    argvs = sys.argv[1:]
    if argvs:
        lines = _read_from_file(argvs[0])
    else:
        lines = _read_from_stdin()

    output = _create_values_block(lines)
    print(output)


def _create_values_block(lines):
    output = _csv_to_values(lines)
    output = _remove_last_comma(output)
    return output


def _remove_last_comma(output):
    last_coma_index = output.rfind(',')
    return output[:last_coma_index]


def _csv_to_values(lines):
    output = "values \n"
    header_values = ["invoice_id", "waybill", "waybill_id", "entry_id"]
    csv_contents = _read_csv(lines)
    csv_contents = [x for x in csv_contents if (x and not [y for y in x if y in header_values])]

    for i, line in enumerate(csv_contents):
        output = _append_values_line(output, i, line)

    return output


def _append_values_line(output, i, line):
    inner = ""
    for x in line:
        x = x.strip()
        if x == '':
            inner += "null, ".format(x)
        else:
            inner += "'{}', ".format(x)
    output += ("(" + inner[:-2] + "),")
    if not i % 6 and i != 0:
        output += '\n'
    return output


def _read_csv(lines):
    try:
        dialect = Sniffer().sniff("\n".join(lines), delimiters=';,')
    except:
        dialect = None
    return reader(lines, dialect)


if __name__ == '__main__':
    transform_to_sql_values()
