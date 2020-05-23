#!/bin/bash

# Unzip .zip files typically from bandcamp and put them in correct directory,
# as well as rename them to my convention:
# music/own/<artistORgroup>/[<year>] <album title>/01. <track name>.<extension>

# Currently tested on flac files

ZIP=$(echo "${1?Usage: Specify the zip to work with}" | awk --field-separator='/' '{print $NF}')
EXTRACTDIR="${2:-/media/pool/media/audio/music/own/}"
if test ! -f "$1"; then
    echo "File not found"
    exit 1
fi

FIELDSEPNUM=$(echo $ZIP | grep -o ' - ' | wc -l)

if [ "$FIELDSEPNUM" = "1" ]; then
    echo "The zip file has the expected name form of 'Aritst - Album.zip':"
    echo "$ZIP"
    ARTIST="$(echo "$ZIP" | awk -F' - ' '{print $1}')"
    ALBUM="$(echo "$ZIP" | awk -F' - ' '{print $2}' | cut --fields=1 --delimiter='.')"

    TMPALBUMDIR="${EXTRACTDIR}tmp/${ARTIST}/${ALBUM}/"
    mkdir --parents "${TMPALBUMDIR}"
    cd "${TMPALBUMDIR}"
    unzip "$(readlink -f "$1")"

    find . -name "*.flac" -print0 | while read -d $'\0' file
    do
        mv "$file" "${file/$ARTIST - $ALBUM - }"
    done

    # The tag YEAR ouputs 'YEAR=2020', cut the firts 5 chars
    YEAR="$(metaflac --show-tag=DATE 01*.flac)"
    YEARALBUM="[${YEAR:5}] $ALBUM"

    cd ..
    mv "$ALBUM" "$YEARALBUM"
    cd "$EXTRACTDIR"
    mkdir --parents "$EXTRACTDIR/$ARTIST"
    mv "tmp/$ARTIST/$YEARALBUM" "$EXTRACTDIR/$ARTIST"
    rmdir "tmp/$ARTIST"
    rmdir tmp

    ZIPFULLPATH="$(readlink -f "$1")"
    mkdir --parents "${ZIPFULLPATH%/*}/extracted"
    mv "$1" "${ZIPFULLPATH%/*}/extracted"
else
    echo "Too many or no ' - ' sequences. Can't parste what is 'Artist' and 'Album' with ceartanty"
    exit 1
fi

echo "Extraction complete"



# Do:
# Move the extracted ZIP to to an 'extracted' folder
