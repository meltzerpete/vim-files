# f == 1: inside section not to filter out (based on heading)
# l == 1: inside a tex code block (strips off ``` from start and finish)
# t == 1: inside todo section

BEGIN {f = 0; l = 0}

/^```tex$/ {l = 1; next}

/^```$/ {

        if (l == 1) {l = 0; next}

}

/^# GENERAL TODO$/ {f = 0; print("# TODO"); t = 1}

/^# Vorspiel$/ {f = 0}

/^---$/ {f = 1}
/^\.\.\.$/ {f = 0; print}

/^# [0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/ {
    
    	if (match($0, r)) {f = 1}
    	
	else {f = 0}
    
}
    
{       
        if (f == 1) {print}
	
	else if (t == 1) {
		if (match($0, r)) {print}
	}
}
