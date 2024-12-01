#!/bin/bash
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates standard analysis and output directories
# for a new project. It also creates a README file with the
# project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

mkdir analysis output
touch README.md
echo "# Project Name: DSI Consulting Inc." > README.md
touch analysis/main.py

# download client data

# Got following Also was getting following error 
# curl: (35) schannel: next InitializeSecurityContext failed: CRYPT_E_NO_REVOCATION_CHECK 
# (0x80092012) - The revocation function was unable to check revocation for the certificate.
# workaround was --ssl-no-revoke option [Didn't really understand the issue through :( ]

curl --ssl-no-revoke -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip rawdata.zip


###########################################
# Complete assignment here

# 1. Create a directory named data
mkdir data

# 2. Move the ./rawdata directory to ./data/raw

# Since data/raw does not exist and rawdata is a directory, mv will rename rawdata to raw while moving it into 
# the data/ directory. All the contents of rawdata will now be in data/raw
mv ./rawdata ./data/raw

# 3. List the contents of the ./data/raw directory
ls ./data/raw

# 4. In ./data/processed, create the following directories: server_logs, user_logs, and event_logs

# You can create these directories independently in 2 different ways
# mkdir -p ./data/processed ./data/processed/server_logs ./data/processed/user_logs ./data/processed/event_logs
# the following one is a simpler way to create multiple sub directories
mkdir -p ./data/processed/{server_logs,user_logs,event_logs}

# 5. Copy all server log files (files with "server" in the name AND a .log extension) from ./data/raw to ./data/processed/server_logs
cp ./data/raw/*server*.log ./data/processed/server_logs/


# 6. Repeat the above step for user logs and event logs
# the user logs also contains user IP Address data
cp ./data/raw/*user*.log ./data/processed/user_logs/
cp ./data/raw/*event*.log ./data/processed/event_logs/

# 7. For user privacy, remove all files containing IP addresses (files with "ipaddr" in the filename) from ./data/raw and ./data/processed/user_logs
rm ./data/raw/*ipaddr* ./data/processed/user_logs/*ipaddr*

# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed

# Tried this command first but it was copying the directory names as well
# ls -R ./data/processed/ > ./data/inventory.txt, And then learnt about find command
find ./data/processed -type f > ./data/inventory.txt
###########################################

echo "Project setup is complete!"
