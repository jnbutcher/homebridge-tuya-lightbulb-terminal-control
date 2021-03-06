#!/bin/bash
#change the led colour of a tuya smart light.

#input variables
hue=$1
sat=$2

#input limitations
if [ "$1" -gt "360" ]; then
	hue=360
elif [ "$1" -lt "0" ]; then
	hue=0
elif [ "$2" -gt "100"; then
	sat=100
elif [ "$2" -lt "1"; then
	sat=1
fi &> /dev/null

#if the input is a number, then echo light hue and sat, otherwise, echo word
if [[ "$1" =~ ^[0-9]+$ ]]; then
echo ">> Light Hue: $hue"
echo ">> Light Sat: $sat"
else
case "$1" in
  red|green|blue|lightblue|white|orange|yellow|purple|pink)
    echo ">> Light Colour: $1"
    ;;
  *)
    echo ">> Colours: red, green, blue, lightblue, white, orange, yellow, purple, pink"
    ;;
esac
fi

#colour hue and saturation values
if [ "$1" == "red" ];then
	hue=1
	sat=100
elif [ "$1" == "green" ];then
	hue=120
	sat=100
elif [ "$1" == "blue" ];then
        hue=230
	sat=100
elif [ "$1" == "lightblue" ];then
	hue=200
	sat=100
elif [ "$1" == "white" ];then
        hue=0
	sat=0
elif [ "$1" == "orange" ];then
        hue=15
	sat=100
elif [ "$1" == "yellow" ];then
        hue=55
	sat=100
elif [ "$1" == "purple" ];then
        hue=270
	sat=100
elif [ "$1" == "pink" ];then
        hue=325
	sat=100
fi &> /dev/null

#set saturation
curl -X PUT --header "Content-Type:Application/json" --header "authorization: XXX-XX-XXX" http://192.168.X.X:51826/characteristics --data '{"characteristics":[{"aid":2,"iid":12,"value":'$sat',"status":0}]}' &> /dev/null

#set hue
curl -X PUT --header "Content-Type:Application/json" --header "authorization: XXX-XX-XXX" http://192.168.X.X:51826/characteristics --data '{"characteristics":[{"aid":2,"iid":11,"value":'$hue',"status":0}]}' &> /dev/null
