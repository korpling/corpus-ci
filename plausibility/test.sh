THRESHOLD=32
if [[ $(git cat-file -p $CI_COMMIT_SHA | grep "parent" -c) -gt 1 ]]; then  # more than one parent means merge
	l=($(git show --name-only --format=tformat: $CI_COMMIT_SHA^))
else
	l=($(git show --name-only --format=tformat: $CI_COMMIT_SHA))
fi
echo "Changed files:"
for e in "${l[@]}"; do echo $e; done
[ ${#l[@]} -gt $THRESHOLD ] && echo "Warning: High number of changes"
[ ${#l[@]} -le $THRESHOLD ]
