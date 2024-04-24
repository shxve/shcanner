# This is shcanner
![Author](https://img.shields.io/badge/author-@shxve-orange?style=flat)
![Language](https://img.shields.io/badge/language-bash-red?style=flat)
![Platform](https://img.shields.io/badge/OS%20platform%20supported-Linux-yellow?style=flat)

# Description

This tool scans files in directories passed as input by the user recursively to look for patterns within them.

shcanner uses by default **4 parallel instances of grep** to load and search the regexes, optimizing times, you can always change it by editing the script.

For change the dataset just see the files in `./patterns`, I recommend using [**this repo**](https://github.com/mazen160/secrets-patterns-db) to get datasets (like me)

I hope I have said everything, otherwise the code is not difficult to analyze :)

## Required
You must install the latest version of [**yq**](https://github.com/mikefarah/yq) to run this script correctly, otherwise the datasets will not load.

To install the latest version of yq run these commands

    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
        chmod +x /usr/bin/yq

## Usage

To run this tool, after installing yq and verifying that it works, assign execution permissions with `chmod +x ./shcanner.sh` and then run with `./shcanner.sh`

The tool asks the user for the type of scan by default, based on the answer one dataset is used rather than another, I recommend using the quick scan for try the tool.

Lastly, enter the folders to search for separated by space (e.g. `/home/user/test /etc`)

## Execution example
![execution](https://i.ibb.co/xhCwLXL/Schermata-del-2024-04-24-20-23-26.png)
![output](https://i.ibb.co/xXP6jSc/Schermata-del-2024-04-24-20-24-03.png)
