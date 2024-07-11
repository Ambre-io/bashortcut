#! /bin/bash

# homemade alert for ZFS filesystem
zpool_health=$(zpool status -x)
if [ "${zpool_health}" != "all pools are healthy" ]; then
    echo "[Warning] >>> You should look at ZFS states: zpool status -x"
fi
zpool_states=$(zpool status | grep -c state)
zpool_online=$(zpool status | grep state | grep -c ONLINE)
if [ "${zpool_states}" -ne "${zpool_online}" ]; then
    echo "[Warning] >>> Some zpool are not online, see: zpool status"
fi
