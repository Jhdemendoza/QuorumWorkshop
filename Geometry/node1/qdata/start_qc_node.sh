#!/bin/bash
set -u
set -e

CORE_NODE_IP="$(dig +short $CORE_NODE_IP)"
CORE_BOOTNODE_IP="$(dig +short $CORE_BOOTNODE)"
NETID=87234
sleep 2
CORE_MASTERNODE_IP="$(dig +short $CORE_MASTERNODE_IP)"

BOOTNODE_ENODE=enode://6433e8fb82c4638a8a6d499d40eb7d8158883219600bfd49acb968e3a37ccced04c964fa87b3a78a2da1b71dc1b90275f4d055720bb67fad4a118a56925125dc@[$CORE_BOOTNODE_IP]:33445

GLOBAL_ARGS="--verbosity 6 --bootnodes $BOOTNODE_ENODE --networkid $NETID --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum"

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
PRIVATE_CONFIG=node1.conf geth --datadir qdata $GLOBAL_ARGS --rpcport 22000 --rpccorsdomain "*" --port 21000 --blockmakeraccount "0xc2efa262856d571ca06788586277863bd167cb4a" --blockmakerpassword ""  --voteaccount "0x7d75924c60922dfe7ddb4ef2421dbff0a6c3783f" --votepassword "" --minblocktime 2 --maxblocktime 5 2>qdata/logs/node1.log &
echo "[*] Started Quorum on node1"

while true 
do 
 sleep 5
done

