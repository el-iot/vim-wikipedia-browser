QUERY=$1
URL='https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts|info&generator=search&inprop=url&exsentences=1&exlimit=max&exintro&explaintext'
RESULTS=$(curl --silent "$URL&gsrsearch=$QUERY")
echo $RESULTS | jq '.query.pages'

