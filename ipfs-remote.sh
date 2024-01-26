#!/usr/bin/env bash

if [ -z "$IPFS_API" ]; then
    echo "No IPFS_API environment variable" >&2
    exit 1
fi

IPFS_EXEC="${IPFS_EXEC:-ipfs}"

temp_ipfs_path="$(mktemp -d)"
chmod o-r "$temp_ipfs_path"
echo "$IPFS_API" > "$temp_ipfs_path/api"

IPFS_PATH="$temp_ipfs_path" "$IPFS_EXEC" "$@"

rm -r "$temp_ipfs_path"

