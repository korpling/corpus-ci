list_of_files=$(git show --name-only --format=tformat: $CI_COMMIT_SHA)
exit_code=0
for f in $list_of_files
do
	if [[ $f == *exb ]]; then
		xmllint --noout $f
		ec=$?
		exit_code=$((exit_code+ec))
	fi
done
exit $exit_code
