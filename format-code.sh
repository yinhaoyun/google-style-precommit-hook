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
    curl -LJ0 "https://github.com/google/google-java-format/blob/master/scripts/google-java-format-diff.py"
    chmod 755 google-java-format-diff.py
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo $changed_java_files
for FILE in $changed_java_files
do
  git diff -U0 $FILE | .cache/google-java-format-diff.py -p1 -a --google-java-format .cache/google-java-format-1.7-all-deps.jar
done

