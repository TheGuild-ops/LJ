#!/bin/bash

git clone https://github.com/Entangle-Protocol/entangle-blockchain
cd entangle-blockchain
make install


apt update && apt upgrade -y
source <(curl -sS https://raw.githubusercontent.com/TheGuild-ops/LJ/main/tool/dependencies.sh)
source <(curl -sS https://raw.githubusercontent.com/TheGuild-ops/LJ/main/tool/fetch_or_ask)

dependencies=("build-essential" "git" "clang" "curl" "libssl-dev" "llvm" "libudev-dev" "git" "make" "cargo" "protobuf-compiler" "unzip")
check_dependencies "${dependencies[@]}"

readonly PNAME=entangle
readonly WALLET_PROVIDER=tendermint
readonly NETWORK=

target_directory="/root/node/${PNAME}"

readonly status_folder="$(pwd)/data/$PNAME/status/"
mkdir -p $status_folder

NODENAME=$(fetch_or_ask NODENAME)
PASSWORD=$(fetch_or_ask PASSWORD)
sh init_key.sh $NODENAME $PASSWORD
entangled keys unsafe-export-eth-key $NODENAME

WALLET=$(fetch_or_ask "$WALLET_PROVIDER" "WALLET")
WALLET_SEED=$(fetch_or_ask $WALLET_PROVIDER WALLET_SEED)
WALLET_PHRASE=$(fetch_or_ask $WALLET_PROVIDER WALLET_PHRASE)
STATUS=$(fetch_or_ask $PNAME STATUS)

echo $STATUS
echo "$server_id"
sh get_snapshot.sh
sh run_node.sh