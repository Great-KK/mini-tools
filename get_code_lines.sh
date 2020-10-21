#!/bin/bash
# should be executed in code root path

echo "count code lines"

# To count code lines iterative
iterFunc() {
	line_num=0
	if [[ -f $1 ]]
	then
		line_num=`wc -l $1 | awk -F' ' '{print $1}'`
		line_num=$[$line_num+1]
	elif [[ -d $1 ]]
	then
		cd $1
		rm -rf tmp_for_count_code_lines
        ls > ./tmp_for_count_code_lines
		# delete tmp_for_count_code_lines in tmp_for_count_code_lines
		sed -i '$d' ./tmp_for_count_code_lines
        while read line
		do
			tmp_num=`iterFunc $line`
			line_num=$[$line_num+$tmp_num]
		done < tmp_for_count_code_lines
        rm -rf ./tmp_for_count_code_lines
	fi
	echo $line_num
}

total_line_num=`iterFunc ./`
echo $total_line_num
