#!/usr/bin/env sh
mkdir -p .cache
cd .cache
if [ ! -f google-java-format-1.7-all-deps.jar ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/google-java-format-1.7/google-java-format-1.7-all-deps.jar"
    chmod 755 google-java-format-1.7-all-deps.jar
fi
if [ ! -f google-java-format-diff.py ]
then
    curl -LJO "https://raw.githubusercontent.com/google/google-java-format/master/scripts/google-java-format-diff.py"
    chmod 755 google-java-format-diff.py
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo $changed_java_files
for FILE in ${changed_java_files}
do
  echo ============================================================
  echo $FILE
  DIFF_OUTPUT=$(git diff --cached -U0 $FILE | .cache/google-java-format-diff.py -p1 -a --skip-sorting-imports --google-java-format .cache/google-java-format-1.7-all-deps.jar)
  echo "${DIFF_OUTPUT}"
  if [ ! -z "$DIFF_OUTPUT" ]
  then
    RETURN_CODE=1
  fi

done

exit $RETURN_CODE

