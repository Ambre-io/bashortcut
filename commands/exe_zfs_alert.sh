#! /bin/bash

# FIXME: at start it was auto loaded in the bsht profile
#   - it's a good way to execute it with a nice frequency like an homemade ZFS healthcheck
#   - it's not relevant for the other filesystems
#   - sometimes we could want to execute it manually
#   - sometimes we don't want to execute it at all

# => leave it like that and setup it on a cron job for ZFS users

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
