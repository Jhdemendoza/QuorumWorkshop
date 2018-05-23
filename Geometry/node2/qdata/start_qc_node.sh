#!/bin/bash
set -u
set -e

CORE_NODE_IP="$(dig +short $CORE_NODE_IP)"
CORE_BOOTNODE_IP="$(dig +short $CORE_BOOTNODE)"
NETID=87234
sleep 10
CORE_MASTERNODE_IP="$(dig +short $CORE_MASTERNODE_IP)"

BOOTNODE_ENODE=enode://6433e8fb82c4638a8a6d499d40eb7d8158883219600bfd49acb968e3a37ccced04c964fa87b3a78a2da1b71dc1b90275f4d055720bb67fad4a118a56925125dc@[$CORE_BOOTNODE_IP]:33445

GLOBAL_ARGS="--verbosity 6 --bootnodes $BOOTNODE_ENODE --networkid $NETID --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum"

cp qdata/node2.conf .

PATTERN="s/CORE_NODE_IP/${CORE_NODE_IP}/g"
PATTERN2="s/CORE_MASTERNODE_IP/${CORE_MASTERNODE_IP}/g"

sed -i "$PATTERN" node2.conf
sed -i "$PATTERN2" node2.conf

echo "[*] Starting Constellation on node2"
constellation-node node2.conf 2> qdata/logs/constellation_node2.log &
sleep 1
echo "[*] Started Constellation on node2"

echo "[*] Starting Quorum on node2"
PRIVATE_CONFIG=node2.conf geth --datadir qdata $GLOBAL_ARGS --rpcport 22000 --rpccorsdomain "*" --port 21000 --blockmakeraccount "0x1da7290acdae10ea9cf85bfc64b883a2143a4639" --blockmakerpassword ""  --voteaccount "0xdc839e6169bb71e01caa9dba996dd03f61d838cc" --votepassword "" --minblocktime 2 --maxblocktime 5 2>qdata/logs/node2.log &
echo "[*] Started Quorum on node2"

while true 
do 
 sleep 5
done

