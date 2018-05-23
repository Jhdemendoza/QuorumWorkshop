#!/bin/bash
set -u
set -e

CORE_NODE_IP="$(dig +short $CORE_NODE_IP)"
CORE_MASTERNODE_IP="$(dig +short $CORE_MASTERNODE_IP)"

GLOBAL_ARGS="--raft --nodiscover --rpc --rpcaddr 0.0.0.0 --verbosity 6 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum"

cp qdata/node1.conf .

PATTERN="s/CORE_NODE_IP/${CORE_NODE_IP}/g"
PATTERN2="s/CORE_MASTERNODE_IP/${CORE_MASTERNODE_IP}/g"

sed -i "$PATTERN" node1.conf
sed -i "$PATTERN2" node1.conf

echo "[*] Starting Constellation on node1"
constellation-node node1.conf 2> qdata/logs/constellation_node1.log &
sleep 1
echo "[*] Started Constellation on node1"

echo "[*] Starting Quorum on node1"
PRIVATE_CONFIG=node1.conf geth --datadir qdata $GLOBAL_ARGS --rpcport 22000 --rpccorsdomain "*" --port 21000 2>qdata/logs/node1.log &

echo "[*] Started Quorum on node1"

while true 
do 
 sleep 5
done

