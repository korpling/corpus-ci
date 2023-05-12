list_of_files=$(git show --name-only --format=tformat: $CI_COMMIT_SHA)
mkdir tmp-runner
for f in $list_of_files
do
	[ ! -f $f ] && continue;
	echo "Changed file:" $f
	fn=$(basename -- "$f")
	ext="${fn##*.}"
	tdir=tmp-runner/$ext
	[ ! -d $tdir ] && mkdir $tdir
	cp $f $tdir/
done
if [[ -d tmp-runner/exb ]]; then
	tests/aql/annatto-cli tests/aql/check_exb.xml
	[ $? -gt 0 ] && exit 1
fi
if [[ -d tmp-runner/conllu ]]; then
	tests/aql/annatto-cli tests/aql/check_conll.xml
	[ $? -gt 0 ] && exit 1
fi
rm -r tmp-runner
exit 0
