#!/usr/bin/env bash
#get data or exec command in MP
dest_file=$1
nowaday=`date +%Y%m%d`
workdir="/tmp/townstmp"
tmpdir="${workdir}/tmp"
tmpfile="result.tmp"
resultfile="result.unl"
listfile="sb_devices.tmp"
ListFileTmp="NameIpTmp.unl"
TimeoutInfo="timeout"
concurrent=19            ###取模并发，根据IP的最后一个字段决定该IP在哪个进程，对于大量的，且最后一个字段的模不一样的数据有效果。
Password=`cat /etc/switchboard.mp-password`
Cmd=`cat /tmp/townstmp/task_cmd.sh`

#echo "you can input one or more devices and ip,for example \"MLAB-xxx 10.x.x.x\"    Enter,Ctrl+d to edit finish"
#cat >${workdir}/${listfile}

#read -p "please input you want concurrent count:" concurrent
#read -p "please input the MP password:" Password
#echo  "please input command:"
#read  Cmd




main(){
        F_ListTmpName=$1
        cat ${tmpdir}/${F_ListTmpName}|while read F_name F_ip
do
   PingNum=`ping -c 1 ${F_ip}|grep "1 packets transmitted" |awk '{print $6}'|awk -F % '{print $1}'`
   if [ ${PingNum} -eq 0 ];then
                sshpass -p ${Password} ssh -A -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=20 -o ServerAliveInterval=60 -o ServerAliveCountMax=5 -t -C  ubuntu@${F_ip} "${Cmd}"  > ${tmpdir}/${tmpfile}${F_ListTmpName#*.} </dev/null
                #Model=`awk '{if(NR==1) print $0}' ${tmpdir}/${tmpfile}${F_ListTmpName#*.}` 
         Model=`cat ${tmpdir}/${tmpfile}${F_ListTmpName#*.}`
                echo "${F_name}|${F_ip}|${Model}"  >>${tmpdir}/${resultfile%.*}.${F_ListTmpName#*.}
   else 
                echo "${F_name}|${F_ip}|${TimeoutInfo}"  >>${tmpdir}/${resultfile%.*}.${F_ListTmpName#*.}
   fi
done
        }

Rmtmpfile(){
TmpFileCount=`ls ${tmpdir}/ |grep "${ListFileTmp}" |wc -l`
if [ ${TmpFileCount} -ne 0 ];then
   rm ${tmpdir}/${ListFileTmp}*
fi

ResultFileCount=`ls ${tmpdir}/ |grep "${resultfile}" |wc -l`
if [ ${ResultFileCount} -ne 0 ];then
   rm ${tmpdir}/${resultfile}*
fi

ResultTmpCount=`ls ${tmpdir}/ |grep "${tmpfile}unl" |wc -l`
if [ ${ResultFileCount} -ne 0 ];then
   rm ${tmpdir}/${tmpfile}unl*
fi
   
}


Rmtmpfile



AllResultFileCount=`ls ${workdir}/ |grep "all${resultfile}" |wc -l`
if [ ${AllResultFileCount} -ne 0 ];then
   rm ${workdir}/all${resultfile}
fi

cat ${workdir}/${listfile} |while read name ip 
do
        LastNum=`echo ${ip}|awk -F . '{print $4}'`
        Remainder=`expr ${LastNum} % ${concurrent}`
        echo "${name} ${ip}"  >> ${tmpdir}/${ListFileTmp}${Remainder}
done


for ListTmpName in `ls ${tmpdir}/ |grep "${ListFileTmp}" `
do 
  main ${ListTmpName} &
done

wait
cat ${tmpdir}/${resultfile}* >${workdir}/all${resultfile}_${nowaday}
sshpass -p Coates5566 scp  -P 28214 ${workdir}/all${resultfile}_${nowaday} coates@120.197.52.139:${dest_file}

Rmtmpfile
echo "process complet,plsase check ${workdir}/all${resultfile}_${nowaday}"
