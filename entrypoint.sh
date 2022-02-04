#!/bin/sh

replica_runner()
{
    while true
    do
        rsync -avzP --delete --progress --password-file=/etc/rsync_replica.passwd $RSYNC_USER@$RSYNC_MASTER_ADDR::testcase /test_case >> /log/rsync_replica.log
        sleep 5
    done
}

primary_runner()
{
    rsync --daemon --config=/etc/rsyncd.conf
    while true
    do
        sleep 60
    done
}

if [ "$RSYNC_MODE" = "primary" ]; then
    if [ ! -f "/etc/rsyncd.passwd" ]; then
        echo "$RSYNC_USER:$RSYNC_PASSWORD" > /etc/rsyncd.passwd
    fi
    chmod 600 /etc/rsyncd.passwd
    primary_runner
elif [ "$RSYNC_MODE" = "replica" ]; then
    if [ ! -f "/etc/rsync_replica.passwd" ]; then
        echo "$RSYNC_PASSWORD" > /etc/rsync_replica.passwd
    fi
    chmod 600 /etc/rsync_replica.passwd
    replica_runner
fi
