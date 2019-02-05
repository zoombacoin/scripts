#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

echo -e ${YELLOW}"Welcome to Zoomba Automated Update."${NC}
echo "Please wait while updates are performed..."
sleep 5
cd ~
cd /usr/local/bin
echo "Stopping first node, please wait...";
zoombacli-cli -datadir=/home/zoomba/.zoomba stop
echo "Stopping second node, please wait...";
zoomba-cli -datadir=/home/zoomba2/.zoomba stop
echo "Stopping third node, please wait...";
zoomba-cli -datadir=/home/zoomba3/.zoomba stop
echo "Stopping fourth node, please wait...";
zoomba-cli -datadir=/home/zoomba4/.zoomba stop
sleep 10
echo "Removing binaries..."
rm -rf zoombad zoomba-cli zoomba-tx
echo "Downloading latest binaries"
wget https://github.com/zoombacoin/zoomba/releases/Zoomba_1.0.2_Linux.tar
tar -xzf zoomba-linux.tar.gz
sudo chmod 755 -R zoomba*
rm -rf zoomba-linux.tar.gz
echo "Syncing first node, please wait...";
zoombad -datadir=/home/zoomba/.zoomba -daemon
until zoomba-cli -datadir=/home/zoomba/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing second node, please wait...";
zoombad -datadir=/home/zoomba2/.zoomba -daemon
until zoomba-cli -datadir=/home/zoomba2/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing third node, please wait...";
zoombad -datadir=/home/zoomba3/.zoomba -daemon
until zoomba-cli -datadir=/home/zoomba3/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing fourth node, please wait...";
zoombad -datadir=/home/zoomba4/.zoomba -daemon
until zoomba-cli -datadir=/home/zoomba4/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Fourth node is fully synced. Your masternode is running!"${NC}
sleep 5
rm -rf /root/zoomba_4masternodes_update.sh
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo -e ${GREEN}"Zoomba address: Zh41h9gnCRxDvWaAF1RJonFZNMRDxyTinT"${NC}
echo -e ${GREEN}"LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"${NC}
echo -e ${GREEN}"The END. You can close now the SSH terminal session"${NC};
