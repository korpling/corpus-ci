list_of_files=$(git show --name-only --format=tformat: $CI_COMMIT_SHA)
files_with_hidden=$(for f in $list_of_files
do
	if [[ $f == *exb ]]; then
		matches=$(xmllint $f --xpath '//ud-information[@attribute-name="exmaralda:hidden"]')
		[ $? -eq 0 ] && echo $f
	fi
done)
if [[ ! -z $files_with_hidden ]]; then
	for e in $files_with_hidden
	do
		echo "File has hidden tiers:" $e
	done
	exit 1
fi
