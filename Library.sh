#!/bin/bash
# NAME="Library.sh"
# BLURB="A library of functions for bash shell scripts"
# SOURCE="https://github.com/vonbrownie/homebin"

# Place in $HOME/bin and call its functions by adding to script:
#
# . Library.sh
#
# SEE: "A library for shell scripts"
#       http://www.circuidipity.com/shell-script-library.html

echoRed() {
echo -e "\E[1;31m$1"
echo -e '\e[0m'
}

echoGreen() {
echo -e "\E[1;32m$1"
echo -e '\e[0m'
}

echoYellow() {
echo -e "\E[1;33m$1"
echo -e '\e[0m'
}

echoBlue() {
echo -e "\E[1;34m$1"
echo -e '\e[0m'
}

echoMagenta() {
echo -e "\E[1;35m$1"
echo -e '\e[0m'
}

echoCyan() {
echo -e "\E[1;36m$1"
echo -e '\e[0m'
}

penguinista() {
cat << _EOF_

(O<
(/)_
_EOF_
}

exitOK() {
echoGreen "\n$( penguinista ) .: Exiting ... Have a good day!"
exit                                                                               
}                                                                                  
                                                                                   
badReply() {
echoRed "\n'$REPLY' is invalid input ...\n"                                        
}                                                                                  
                                                                                   
badReplyYN() {
echoRed "\n'$REPLY' is invalid input. Please select 'Y(es)' or 'N(o)' ...\n"       
}

confirmStart() {
while :
do
    read -n 1 -p "Run script now? [yN] > "
    if [[ $REPLY == [yY] ]]
    then
        echoGreen "\nLet's roll then...\n"
        sleep 2
        break
    elif [[ $REPLY == [nN] || $REPLY == "" ]]
    then
        penguinista
        exit
    else
        badReplyYN
    fi
done
}

testRoot() {
local message="$NAME requires ROOT privileges to do its job."
if [[ $UID -ne 0 ]]
then
    echoRed "\n$( penguinista ) .: $message\n"
    exit 1
fi
}

testConnect() {
local message="$NAME requires an active network interface."
if ! $(ip addr show | grep "state UP" &>/dev/null); then
    echoRed "$( penguinista ) .: $message"
    echo "INTERFACES FOUND"
    ip link
    exit 1
fi
}
