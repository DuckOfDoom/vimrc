import os
import string
import vim
import sys
import re
import random

logger_prefixes = [ "WARN:", "INFO:", "ERROR:", "DEBUG:" ]
logger_pattern = re.compile('WARN:/INFO:/ERROR:', re.UNICODE)

# matches the whole line with logger in it (vim-style)
logger_line_pattern = "\(INFO\|WARN\|ERROR\|DEBUG\):{logger}:.*"

# extracts logger name from a line (python-style, group 0)
logger_name_pattern = "(?:INFO|WARN|ERROR|DEBUG):(.+?)(?=:)"

filter_pattern = re.compile('[\W_]+', re.UNICODE)

highlight_group = "LogsHighlighter_highlight"
config_filename = "log_highlig_settings";

colors = { }

def _gen_random_color():
    rand_color_hex = lambda: str(hex(random.randint(0,255))).replace("0x","")
    def get_color():
        c = rand_color_hex();
        if len(c) == 1:
            c = "0" + c
        return c

    res = "#";
    for i in range(0,3):
        res = res + get_color()
#    print res
    return res

def _filter_group(s):
    return re.sub(filter_pattern, "", s)

def _load_config_from_file():
    config_path = os.environ["HOME"] + "/" + config_filename

    try:
        f = open(config_path)
        lines = f.read().splitlines()
        for line in lines:
            split = line.split(" ");
            colors[_filter_group(split[0])] = split[1]

    except IOError: 
        print("Error: Can't find file: '{p}'".format(p=config_path))

def _make_config_from_buffer():
    buffer = vim.current.buffer
    for line in buffer:
        match = re.search(logger_name_pattern, line)
        if match and match.group(1):
            logger = match.group(1)
            if not logger in colors:
                colors[logger] = _gen_random_color()

def _highlight():
    clear()
    for logger, color in colors.iteritems():
        group = _filter_group(highlight_group + logger)
        line_pattern = logger_line_pattern.format(logger=logger)
        vim.command("syntax match {group} /{pattern}/".format(group=group, pattern=line_pattern))
        vim.command("highlight {group} guifg = {color}".format(group=group, color=color))

def highlight_with_settings():
    _load_config_from_file()
    _highlight()

def highlight_automatically():
    _make_config_from_buffer()
    _highlight()

def clear():
    vim.command("syn clear")
    vim.command("syn off")

def test():
    _make_config_from_buffer()
    print colors

