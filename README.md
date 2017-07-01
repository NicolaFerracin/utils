# utils
A repo contaning useful commands and scripts.

## Scripts

All scripts can be found inside the [script](https://github.com/NicolaFerracin/utils/script) folder.

| Script        | Description  |
| ------------- | -------------|
| incremental_number_renamer.sh | Rename all files with the given format in a given directory to incremental numbers, based on the amount of files present. <br/><br/> Examples: <br/>- 10 jpg files will be renamed from 01.jpg to 10.jpg <br/>- 100 jpg files will be renamed from 001.jpg to 100.jpg |

## Commands

A list of useful commands

| Command | Description |
| ------- | ----------- |
| `du -h /dir` | Outputs the space usage of all files in all subdirectories recursively |
| `du -h /dir --max-depth=1` | Same as above, but it stops at one folder deep |
| `df -h` | Outputs the overall space usage in human readable format |
| `history` | Prints the last `x` commands, where `x` is defined by `HISTSIZE` in `~/.bashrc`. Each command is printed on a new line with the format<br/>`<line-number> <command>` |
| `history | grep "<search>"` | As above, but it prints only the commands containing the `<search>` string |
| `!<line-number>` | Usually used after running `history`. It runs the command that can be found at the given `<line-number>` of the `history` output
| `!<string>` | Runs the last command starting with the given `<string>`. <br/><br/>Example:<br/>`$: echo "123"`<br/>`123`<br/>`$: !e`<br/>`echo "123"`<br/>`123`