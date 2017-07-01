# utils
A repo containing useful commands and scripts.

## Scripts

All scripts can be found inside the [scripts](https://github.com/NicolaFerracin/utils/tree/master/scripts) folder.

| Script        | Description  |
| ------------- | -------------|
| [incremental_number_renamer.sh](https://github.com/NicolaFerracin/utils/blob/master/scripts/incremental_number_renamer.sh) | Rename all files in a given directory to incremental numbers, based on the amount of files present. <br/><br/> Examples: <br/>- 10 files will be renamed from 01.xx to 10.xx <br/>- 100 files will be renamed from 001.xx to 100.xx |
| [suffix_renamer.sh](https://github.com/NicolaFerracin/utils/blob/master/scripts/suffix_renamer.sh) | Given a directory, this script adds a given suffix to all file names in a given range. The range is determined on the files ordered lexicographically |

## Commands

A list of useful commands

| Command | Description |
| ------- | ----------- |
| `du -h /dir` | Outputs the space usage of all files in all subdirectories recursively |
| `du -h /dir --max-depth=1` | Same as above, but it stops at one folder deep |
| `df -h` | Outputs the overall space usage in human readable format |
| `history` | Prints the last `x` commands, where `x` is defined by `HISTSIZE` in `~/.bashrc`. Each command is printed on a new line with the format<br/>`<line-number> <command>` |
| <code>history &#124; grep "`<search>`"<code> | As above, but it prints only the commands containing the `<search>` string |
| `!<line-number>` | Usually used after running `history`. It runs the command that can be found at the given `<line-number>` of the `history` output
| `!<string>` | Runs the last command starting with the given `<string>`. <br/><br/>Example:<br/>`$: echo "123"`<br/>`123`<br/>`$: !e`<br/>`echo "123"`<br/>`123`