#!/bin/sh
echo -e "\e[1;33m 齐心SY-100黑群晖DS218专用 \e[0m"
sleep 3



macstr=$1
sn=$2
mac=(${macstr//:/ })
if [ ${#mac[@]} != 6 ];
then
echo mac address error!
exit
fi
for var in ${mac[@]}
do
if echo $var | grep -q '[^0-9A-F]'
then 
echo mac address error!
exit
fi 
if  [[ ${#var} != 2  ]] 
then
echo mac address error!!
exit
fi
done
if  [[ ${#sn} != 13  ]] 
then
echo sn error:The SN Length must be 13
exit
fi

for((i=0;i<6;i++));
do 
declare -i macchecksum+=0x${mac[i]}
done
declare -i macchecksum=$macchecksum%256
for((i=0;i<13;i++));
do 
declare -i checksum+=$(printf '%d' "'${sn:$i:1}")
done
if [ ${#checksum} == 3 ];
then
echo -e -n "\x${mac[0]}\x${mac[1]}\x${mac[2]}\x${mac[3]}\x${mac[4]}\x${mac[5]}\
\x$(printf '%x' $macchecksum)\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0"\
\SN=$sn",CHK="$checksum\
"\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x3C\x0\x0\x0\
\x0\x0\x0\x0\x1\x1\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x1\x1\x1\x1\
\x0\x1\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x1\x1\x1\x1\
\x1\x0\x1\x1\x1\x1\x1\x0\
\x1\x1\x1\x0\x0\x0\x0\x0\
\x0\x0\x0\x1\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0" > vender.bin
else
echo -e -n "\x${mac[0]}\x${mac[1]}\x${mac[2]}\x${mac[3]}\x${mac[4]}\x${mac[5]}\
\x$(printf '%x' $macchecksum)\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0"\
\SN=$sn",CHK="$checksum\
"\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x3C\x0\x0\x0\
\x0\x0\x0\x0\x1\x1\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x1\x1\x1\x1\
\x0\x1\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x1\x1\x1\x1\
\x1\x0\x1\x1\x1\x1\x1\x0\
\x1\x1\x1\x0\x0\x0\x0\x0\
\x0\x0\x0\x1\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\
\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0" > vender.bin
fi
dd if=vender.bin of=/dev/mtdblock3
rm vender.bin
echo Update Success! MAC:$macstr SN:$sn
echo -e "\e[1;33m 成功啦！成功啦！成功啦！立即重启系统，Enjoy  it!  \e[0m"
rm -f sy100macsn.sh