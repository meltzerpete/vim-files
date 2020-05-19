#!/bin/bash

## HELP ##
help_string='
Usage: extractor [-chvx] -r REGEX [-t TARGET] INPUT_FILE [...]

    -c    compile only (do not open html viewer)
    
    -h    display this help page
    
    -r    regex to match in headings of the format "# DD/MM/YYYY ..."
    
    -t    target file to save html (default is out.html)
    
    -v    verbose

    -x    close html viewer
'


## DEFAULTS ##

print_help=0
target='out'
compile_only=0
verbose=0
close=0


## OPTIONS ##

OPTIND=1 
while getopts "chr:t:vx" opt; do
  case ${opt} in
    c)
      compile_only=1
      ;;
    h)
      print_help=1
      ;;
    r)
      regex="$OPTARG"
      ;;
    t)
      target="$OPTARG"
      ;;
    v)
      verbose=1
      ;;
    x)
      close=1
      ;;
  esac
done
shift $((OPTIND -1))

files="$@"


## MAIN ##

if [ $print_help -eq 1 ]; then
	echo "$help_string"

elif [ $close -eq 1 ]; then
	html_PID=`cat .extractor`
        
	if [ $verbose -eq 1 ]; then
		echo "closing html viewer ($target.html)"
		echo
		echo "kill $html_PID; rm .extractor"
        fi

	kill $html_PID; rm .extractor

else
	if [ $verbose -eq 1 ]; then
                echo "target: $target.html"
                echo "regex: $regex"
                echo "file(s): $files"
		echo
                echo "awk -f extractor.awk -v r=$regex $files | pandoc -f gfm -o $target.html"
		awk -f extractor.awk -v r="$regex" "$files" > temp.md
		cat temp.md | pandoc -o temp.tex
	fi

	awk -f extractor.awk -v r="$regex" "$files" | pandoc --mathjax --highlight-style tango --css extractor.css -o "$target.html"

	if [ $compile_only -eq 0 ]; then
        	xdg-open $target'.html' &> /dev/null
		html_PID=`ps | grep okular | tail -n 1 | awk '{print $1}'`
                echo $html_PID > .extractor
        fi
fi

