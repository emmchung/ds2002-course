#!/usr/bin/env bash

SEARCH_PATTERN="$1"
OUTPUT="$2"

# download the text (saves as mobydick.txt in current directory)
curl -s -L "https://gist.githubusercontent.com/StevenClontz/4445774/raw/1722a289b665d940495645a5eaaad4da8e3ad4c7/mobydick.txt" -o mobydick.txt

# count occurrences (grep -o prints each match on its own line; wc counts lines)
OCCURRENCES=$(grep -o "$SEARCH_PATTERN" mobydick.txt | wc -l)

# write the required message to the output file
echo "The search pattern <$SEARCH_PATTERN> was found <$OCCURRENCES> time(s)." > "$OUTPUT"
