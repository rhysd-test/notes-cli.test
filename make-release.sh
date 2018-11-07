#! /bin/bash

set -e

go test -v
golint

rm -rf release
gox
mkdir -p release
mv notes-cli.test_* release/
cd release
for bin in *; do
    if [[ "$bin" == *windows* ]]; then
        command="notes-cli.test.exe"
    else
        command="notes-cli.test"
    fi
    mv "$bin" "$command"
    zip "${bin}.zip" "$command"
    rm "$command"
done
