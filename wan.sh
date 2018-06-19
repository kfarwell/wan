#!/bin/sh

DIR=/where/to/download/shows
USER=transmission
PASS=transmission

if [ $# -eq 0 ]; then
    rssdler -o
    cd $DIR
    for i in */; do
        if [ -d "$i.torrents" ] && [ "$(ls "$i.torrents")" ]; then
            cd "$i".torrents
            for j in *.torrent; do
                transmission-remote -n $USER:$PASS -a "$j" -w "$DIR/$i" --trash-torrent
            done
            cd ../..
        fi
    done
else
    echo '
['$*']
link = https://nyaa.si/?page=rss&q=[HorribleSubs]+'$(echo $* | sed 's/ /+/g')'+[720p]+-batch&c=1_2&f=0
directory = '$DIR'/'$*'/.torrents' \
    >>$HOME/.rssdler/config.txt
    mkdir -p "$DIR/$*/.torrents"
fi
