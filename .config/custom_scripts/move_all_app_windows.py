#!/usr/bin/env python3

import json
import subprocess
from time import sleep

import click

ignore_messages = [
]


def yabai_message(*msg):
    print("calling: ", ["yabai", "-m", *msg])
    ret = subprocess.run(["yabai", "-m", *msg], capture_output=True)

    if ret.returncode:
        err_msg = ret.stderr.decode()

        if err_msg.strip() not in ignore_messages:
            raise Exception(err_msg)
        else:
            print(f"While running {msg} we received error: {err_msg}")
    sleep(0.5)
    print("sleeping")
    return ret.stdout.decode()


def yabai_message_fake(*msg):
    print("calling: ", ["yabai", "-m", *msg])


def yabai_message_async(*msg):
    print("calling: ", ["yabai", "-m", *msg])
    subprocess.Popen(["yabai", "-m", *msg])


def yabai_query(domain):
    return json.loads(yabai_message("query", "--{}".format(domain)))


@click.command()
@click.argument('action', type=click.Choice(['gather', 'close_other', 'print_recent']))
@click.argument('dest_type', type=click.Choice(['display', 'space']))
@click.argument('id', )
def hello(action, dest_type, id):
    print('Hello World! in a standard echo')
    print(dest_type, id)
    res = yabai_query(
        # "space", f"s{space}", "--display", f"{display_index}",
        "windows"
    )
    recent = json.loads(yabai_message("query", "--{}".format('windows'), "--window", "recent"))
    # print(json.dumps(res, indent=4))
    focused = [x for x in res if x['focused'] > 0][0]
    print(focused['app'], focused['title'], focused['id'])

    same_app_windows = [x for x in res if x['app'] == focused['app']]
    print(len(same_app_windows))
    same_app_ids = [x['id'] for x in same_app_windows]
    print(same_app_ids)
    if action == 'gather':
        [yabai_message_async('window', str(app_id), '--' + dest_type, str(id)) for app_id in same_app_ids]  # window 11284 --display 3
    elif action == 'close_other':
        same_app_ids = [x for x in same_app_ids if x != focused['id']]
        print("killing windows: ", same_app_ids)
        res = [yabai_message('window', str(app_id), '--close') for app_id in same_app_ids]  # window 11284 --close
        print("res: ", res)
    elif action == 'print_recent':
        print("focused is: ", focused['title'])
        print("recent is: ", recent['title'])
    yabai_message_async('window', '--focus', str(focused['id']))  # window --focus 11284


if __name__ == '__main__':
    hello()
