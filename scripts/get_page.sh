PAGE_ID="$1"
URL='https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&explaintext'

RESULTS=$(
  curl --silent "$URL&pageids=$PAGE_ID" |
    iconv -c -f ascii -t utf-8 |
    jq ".query.pages" |
    jq --arg pageid "$PAGE_ID" 'to_entries[] | select(.key==$pageid) | .value' |
    tr -d '\000-\011\013\014\016-\037' |
    jq '.extract'
)

echo $RESULTS
