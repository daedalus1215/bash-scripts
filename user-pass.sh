#!/bin/bash




PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)


SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)

echo "${PASSWORD}${SPECIAL_CHARACTER}"


