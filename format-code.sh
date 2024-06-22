#!/usr/bin/env sh
GOOGLE_JAVA_FORMAT_VERSION=1.22.0
mkdir -p .cache
(
cd .cache || exit 1
if [ ! -f google-java-format-"$GOOGLE_JAVA_FORMAT_VERSION"-all-deps.jar ]
then
  curl -LJO "https://github.com/google/google-java-format/releases/download/v$GOOGLE_JAVA_FORMAT_VERSION/google-java-format-$GOOGLE_JAVA_FORMAT_VERSION-all-deps.jar"
  chmod 755 google-java-format-"$GOOGLE_JAVA_FORMAT_VERSION"-all-deps.jar
fi
if [ ! -f google-java-format-diff.py ]
then
  curl -LJO "https://raw.githubusercontent.com/google/google-java-format/v$GOOGLE_JAVA_FORMAT_VERSION/scripts/google-java-format-diff.py"
  chmod 755 google-java-format-diff.py
fi
) || exit 1

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo "$changed_java_files"
for FILE in ${changed_java_files}
do
  echo ============================================================
  echo "$FILE"
  DIFF_OUTPUT=$(git diff --cached -U0 "$FILE" | .cache/google-java-format-diff.py -p1 -a --skip-sorting-imports --google-java-format .cache/google-java-format-"$GOOGLE_JAVA_FORMAT_VERSION"-all-deps.jar)
  echo "${DIFF_OUTPUT}"
  if [ -n "$DIFF_OUTPUT" ]
  then
    RETURN_CODE=1
  fi
done

exit $RETURN_CODE

