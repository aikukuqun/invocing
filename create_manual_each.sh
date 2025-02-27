hq=$1
client=$2

nowaday=$3
oldday=$4

newdir="/home/coates/invoicing/all_date/${nowaday}"
olddir="/home/coates/invoicing/all_date/${oldday}"

newsbsr="${newdir}/data_sbsr"
oldsbsr="${olddir}/data_sbsr"

newsbdv="${newdir}/data_sbdv"
oldsbdv="${olddir}/data_sbdv"

neweach="${newdir}/each"
oldeach="${olddir}/each"

newresultcsv="${newdir}/result_csv"
oldresultcsv="${olddir}/result_csv"

neweachtmp="${newdir}/eachtmp"
oldeachtmp="${olddir}/eachtmp"


newtmp="${newdir}/tmp"
oldtmp="${olddir}/tmp"



new_sbsr_file="${newsbsr}/code.ip_sbsr_${client}_${nowaday}.csv"
old_sbsr_file="${oldsbsr}/code.ip_sbsr_${client}_${oldday}.csv"

new_sbdv_file="${newsbdv}/VPN_SN_${client}_${nowaday}.csv"
old_sbdv_file="${oldsbdv}/VPN_SN_${client}_${oldday}.csv"

new_each_file="${neweach}/Each-Device-${client}-${nowaday}.csv"
old_each_file="${oldeach}/Each-Device-${client}-${oldday}.csv"

new_each_tmp_file="${newtmp}/Each-Device-tmp-${client}-${nowaday}.csv"
old_each_tmp_file="${oldtmp}/Each-Device-tmp-${client}-${oldday}.csv"

new_each_manual_file="${neweachtmp}/Each-Device-manual-${client}-${nowaday}.csv"
old_each_manual_file="${oldeachtmp}/Each-Device-manual-${client}-${oldday}.csv"

new_add_tmp_file1="${newtmp}/additional_tmp1_${client}_${nowaday}.csv"
old_add_tmp_file1="${oldtmp}/additional_tmp1_${client}_${oldday}.csv"

new_add_tmp_file2="${newtmp}/additional_tmp2_${client}_${nowaday}.csv"
old_add_tmp_file2="${oldtmp}/additional_tmp2_${client}_${oldday}.csv"

new_add_tmp_file3="${newtmp}/additional_tmp3_${client}_${nowaday}.csv"
old_add_tmp_file3="${oldtmp}/additional_tmp3_${client}_${oldday}.csv"

new_add_file="${newtmp}/additional_${client}_${nowaday}.csv"
old_add_file="${oldtmp}/additional_${client}_${oldday}.csv"

new_add_vpn_file="${newtmp}/additional_vpn_${client}_${nowaday}.csv"
old_add_vpn_file="${oldtmp}/additional_vpn_${client}_${oldday}.csv"

new_date_tmp="${newtmp}/date_tmp_${client}_${nowaday}.csv"
old_date_tmp="${oldtmp}/date_tmp_${client}_${oldday}.csv"

new_each_tmp1_file="${newtmp}/each_tmp1_${client}_${nowaday}.csv"
old_each_tmp1_file="${oldtmp}/each_tmp1_${client}_${oldday}.csv"

new_each_tmp2_file="${newtmp}/each_tmp2_${client}_${nowaday}.csv"
old_each_tmp2_file="${oldtmp}/each_tmp2_${client}_${oldday}.csv"

new_tmp_location_file="${newtmp}/tmp_location_${client}_${nowaday}.csv"
old_tmp_location_file="${oldtmp}/tmp_location_${client}_${oldday}.csv"

new_tmp_name_file="${newtmp}/tmp_name_${client}_${nowaday}.csv"
old_tmp_name_file="${oldtmp}/tmp_name_${client}_${oldday}.csv"

new_tmp_location_name_file="${newtmp}/tmp_location_name_${client}_${nowaday}.csv"
old_tmp_location_name_file="${oldtmp}/tmp_location_name_${client}_${oldday}.csv"

new_tmp_notfull_name_file="${newtmp}/tmp_notfull_name_${client}_${nowaday}.csv"
old_tmp_notfull_name_file="${oldtmp}/tmp_notfull_name_${client}_${oldday}.csv"


new_result_no_name_file="${newtmp}/result_no_name_${client}_${nowaday}.csv"
old_result_no_name_file="${oldtmp}/result_no_name_${client}_${oldday}.csv"

new_result_no_full_name_file="${newtmp}/result_no_full_name_${client}_${nowaday}.csv"
old_result_no_full_name_file="${oldtmp}/result_no_full_name_${client}_${oldday}.csv"

new_result_csv_file="${newresultcsv}/DeviceList-Invoicing-${client}-${nowaday}.csv"
old_result_csv_file="${oldresultcsv}/DeviceList-Invoicing-${client}-${oldday}.csv"




new_sbdv_minus="${newtmp}/VPN_SN_minus_timeout_${client}_${nowaday}.csv"
old_sbdv_minus="${oldtmp}/VPN_SN_minus_timeout_${client}_${oldday}.csv"

new_each_full_replace="${newtmp}/each_full_replace_${client}_${nowaday}.csv"
old_each_full_replace="${oldtmp}/each_full_replace_${client}_${oldday}.csv"


####比较新的sbsr数据比老的sbsr数据多出来的部分

####新sbsr数据(new)有，旧sbsr数据(old)上没有的记录。
####第一次生成一份对比code.ip 列多出来的数据
awk  -F "," 'NR==FNR{a[$1]}NR>FNR{ if(!($1 in a)) print $0}' ${old_sbsr_file}  ${new_sbsr_file}   >   ${new_add_tmp_file1}

###第二次用多出来的数据，第一列可能存在device name 的情况，用device name 再对比一次,判断NF=14，14为location name没有包含逗号的，为了区分location name是否包含逗号

awk  -F "," 'NR==FNR{a[$3]}NR>FNR{ if(!($1 in a)) print $0}' ${old_sbsr_file}  ${new_add_tmp_file1} |awk -F ,    '{
if(NF==14){
cuttime=substr($8,1,10) ;print $1","$2","$3",,"$6","$7",,,"cuttime",,,"$9
}
else{
cuttime=substr($7,1,10) ;print $1","$2","$3",,"$5","$6",,,"cuttime",,,"$8
}
}' |sed "s/\"//g" >${new_add_tmp_file2}

###第三次用多出来的数据跟each表对(为了适应DHCP 的ip变化，需要匹配device name,)  对出   ${new_add_tmp_file2} 有，老的each表${old_each_file} 没有的数据
awk  -F "," 'NR==FNR{a[$1];b[$3]}NR>FNR{ if(!($1 in a)) {
if(!($3 in b)) {
print $0
}
}
}' ${old_each_file}  ${new_add_tmp_file2}   >   ${new_add_tmp_file3}



###单独取出时间字段转换成时间戳,再合并到原文件中,根据时间排序去重，留下时间比较老的记录。再删除最后一个字段,然后重定向到文件
if [ -s ${new_add_tmp_file3} ];then
rm ${new_date_tmp}
awk -F , '{print $9}' ${new_add_tmp_file3} |while read d_date; do date -d "${d_date}" +%s   >> ${new_date_tmp}; done
paste -d "|" ${new_add_tmp_file3} ${new_date_tmp}   |sort -t '|' -k2 |sort -t ','  -k 1,1  -u  |awk -F \| '{print $1}'   >  ${new_add_file}
###合并老的each file 和新增的机器，用“below is add” 分隔开
cat ${old_each_file}  >  ${new_each_tmp1_file}
echo "below_is_add"  >>  ${new_each_tmp1_file}
cat ${new_add_file}  >>  ${new_each_tmp1_file}
else
cat ${old_each_file}  >  ${new_each_tmp1_file}
fi

###开始处理临时each文件  ${new_each_tmp1_file}， 从vpn文件中拿最新的数据，用第一列作为关键词
###${new_each_tmp1_file}  先把Install Date Current 的时间移到  Previous

awk -F , '{
if(($1!="below_is_add")&&($1!="Location.Code.ip")) {
print $1","$2","$3","$4","$5","$6","$7","$8","$9",,"$10","$12
}
else {
print $0
}
}'  ${new_each_tmp1_file}  >${new_each_tmp2_file}


###先把${new_sbdv_file}  timeout和空值的去掉
awk -F  , '{if(($3!="timeout")&&($3!="")) print $0}'  ${new_sbdv_file}   > ${new_sbdv_minus}


###从${new_sbdv_minus}中的code.ip 找到${new_each_tmp2_file}中的数据，找到则替换和补充，再找device name， 找不到则保持原来，
if [ -s ${new_sbdv_minus} ];then
awk  -F "," 'NR==FNR{
vpn[$3]=$2;code_ip[$3]=$3;code[$3]=$4;device[$3]=$5;local_ip[$3]=$6;model[$3]=$7;sn[$3]=$8;output_date[$3]=$9;vpn[$5]=$2;code_ip[$5]=$3;code[$5]=$4;device[$5]=$5;local_ip[$5]=$6;model[$5]=$7;sn[$5]=$8;output_date[$5]=$9
}
NR>FNR{
if(!($1 in code_ip)) {
if(!($3 in device)) {
print $0
}
else{
print code_ip[$3]","code[$3]","device[$3]","$4","local_ip[$3]","vpn[$3]","model[$3]","sn[$3]","$9","output_date[$3]","$11","$12
}
}
else {
print code_ip[$1]","code[$1]","device[$1]","$4","local_ip[$1]","vpn[$1]","model[$1]","sn[$1]","$9","output_date[$1]","$11","$12

}

}' ${new_sbdv_minus}  ${new_each_tmp2_file}   >  ${new_each_full_replace}

else 
cat ${new_each_tmp2_file} >  ${new_each_full_replace}
fi

####${new_each_tmp2_file}
###找到${new_sbdv_minus} 中有, 但是${new_each_full_replace} 没有的数据，这里的数据是可能机器在线，没有报告的机器。也有可能是换了机器，IP 改变的机器，所以需要匹配完code.ip 后还要匹配device name    按照each的格式输出并合并
awk  -F "," 'NR==FNR{a[$1];b[$3]}NR>FNR{ if(!($3 in a)) {
if(!($5 in b)){
print $0
}
}
}' ${new_each_full_replace}  ${new_sbdv_minus}   |awk -F , '{print $3","$4","$5",,"$6","$2","$7","$8","$9","$9",,"}' >   ${new_add_vpn_file}




if [ -s ${new_add_vpn_file} ];then
cat ${new_each_full_replace}  >  ${new_each_tmp_file}
echo "below_is_sbdv_data_add"  >>  ${new_each_tmp_file}
cat ${new_add_vpn_file}  >>  ${new_each_tmp_file}
else
cat ${new_each_full_replace}  >  ${new_each_tmp_file}
fi



###如果$7 不是 NUC7i3DNB 的， 删掉 $8
awk -F , '{if(($7~/NUC7i3DNB/)||($7=="model")||($1=="below_is_add")||($1=="below_is_sbdv_data_add")) {
print $0 
}
else {
print $1","$2","$3","$4","$5","$6","$7",,"$9","$10","$11","$12
}
}'  ${new_each_tmp_file}   >  ${new_each_manual_file}

##if no add ,then move manual to each .
if_add_data=`grep -E "below_is_add|below_is_sbdv_data_add"  ${new_each_manual_file} `
if [ -z "${if_add_data}" ];then
mv ${new_each_manual_file}  ${new_each_file}
fi
