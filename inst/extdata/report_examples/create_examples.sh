#!/usr/bin/env bash

# Function to filter lines based on alternatives in specific columns
filter_markers() {
    local input_file="$1"
    local alternatives="$2"
    local output_file="$3"

    # Extract the header
    header=$(head -n 1 "$input_file")

    # Write the header to the output file
    echo "$header" > "$output_file"

    # Filter the lines based on the alternatives and append to the output file
    awk -F'\t' -v alt="$alternatives" '
    NR > 1 && ($7 ~ "(^|[[:space:]])"alt"($|[[:space:]])" || $14 ~ "(^|[[:space:]])"alt"($|[[:space:]])") {print $0}' "$input_file" >> "$output_file"
}

#
# Example 0
#
EXAMPLE00_IN_RPT="MRK_List1.rpt"
EXAMPLE00_OUT_RPT="MRK_List1-EX00.rpt"

# Only the header
head -n 1 "$EXAMPLE00_IN_RPT" > "$EXAMPLE00_OUT_RPT"

#
# Example 1
#
EXAMPLE01_SYMBOLS="1700024N20Rik|2200002F22Rik|Plpbp|Proscos|Prosc|ENSMUSG00000045549"
EXAMPLE01_IN_RPT="MRK_List1.rpt"
EXAMPLE01_OUT_RPT="MRK_List1-EX01.rpt"

filter_markers "$EXAMPLE01_IN_RPT" "$EXAMPLE01_SYMBOLS" "$EXAMPLE01_OUT_RPT"

#
# Example 2
#
EXAMPLE02_SYMBOLS="Mob4|Gm6822|Rftn2|LOC102635460|Snord87|Mstn"
EXAMPLE02_IN_RPT="MRK_List1.rpt"
EXAMPLE02_OUT_RPT="MRK_List1-EX02.rpt"

filter_markers "$EXAMPLE02_IN_RPT" "$EXAMPLE02_SYMBOLS" "$EXAMPLE02_OUT_RPT"

#
# Example 3
#
EXAMPLE03_SYMBOLS="Adh7|Mir466f-3|Hes1"
EXAMPLE03_IN_RPT="MRK_List1.rpt"
EXAMPLE03_OUT_RPT="MRK_List1-EX03.rpt"

filter_markers "$EXAMPLE03_IN_RPT" "$EXAMPLE03_SYMBOLS" "$EXAMPLE03_OUT_RPT"
