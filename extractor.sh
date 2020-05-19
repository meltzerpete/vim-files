#! /bin/bash

## HELP ##
help_string='
Usage: extractor [-chvx] -r REGEX [-t TARGET] INPUT_FILE [...]

    -c    compile only (do not open pdf viewer)
    
    -h    display this help page
    
    -r    regex to match in headings of the format "# DD/MM/YYYY ..."
    
    -t    target file to save pdf (default is out.pdf)
    
    -v    verbose

    -x    close pdf viewer
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

# check for cached

#cache_dir="$HOME/.diary"

# mkdir "$cache_dir"

#cached_md="$cache_dir/$target.md"
#cached_pdf="$chacher_dir/$target.pdf"

if [ $print_help -eq 1 ]; then
	echo "$help_string"

elif [ $close -eq 1 ]; then
	PDF_PID=`cat .extractor`
        
	if [ $verbose -eq 1 ]; then
		echo "closing PDF viewer ($target.pdf)"
		echo
		echo "kill $PDF_PID; rm .extractor"
        fi

	kill $PDF_PID; rm .extractor

else
	if [ $verbose -eq 1 ]; then
                echo "target: $target.pdf"
                echo "regex: $regex"
                echo "file(s): $files"
		echo
                echo "awk -f extractor.awk -v r=$regex $files | pandoc -f gfm -o $target.pdf"
		awk -f extractor.awk -v r="$regex" "$files" > temp.md
		cat temp.md | pandoc -o temp.tex
	fi
	
	if [ -f "$cached_pdf" ]; then
		echo using cached pdf

	elif [ -f "$cached_md" ]; then
		echo using cached md
		awk -f extractor.awk -v r="$regex" "$cached_md" "$files" | pandoc -o "$target.pdf"
	else
		awk -f extractor.awk -v r="$regex" "$files" | pandoc -o "$target.pdf"
	fi

	if [ $compile_only -eq 0 ]; then
        	xdg-open $target'.pdf' &> /dev/null
		PDF_PID=`ps | grep okular | tail -n 1 | awk '{print $1}'`
                echo $PDF_PID > .extractor
        fi
fi

