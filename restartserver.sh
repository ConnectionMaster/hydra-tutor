#!/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PID=`jps -m 2> /dev/null | grep hydra-tutor | cut -f 1 -d ' '`
iter=0

while [[ $PID && $iter != 5 ]]
do
    echo "Killing existing hydra tutor"
    kill $PID
    sleep 10
    PID=`jps -m 2> /dev/null | grep hydra-tutor | cut -f 1 -d ' '`
    iter=$(( $iter + 1))
done

pushd $DIR
mvn versions:use-latest-versions
mvn clean
mvn package -Pbdbje

nohup ./runserver.sh &
popd


