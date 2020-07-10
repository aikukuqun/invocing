hq=$1
client=$2
client_dist=$3

nowaday=$4
oldday=$5

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

new_each_file="${neweach}/Each-Device-${client_dist}-${nowaday}.csv"
old_each_file="${oldeach}/Each-Device-${client_dist}-${oldday}.csv"

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

new_result_csv_file="${newresultcsv}/DeviceList-Invoicing-${client_dist}-${nowaday}.csv"
old_result_csv_file="${oldresultcsv}/DeviceList-Invoicing-${client_dist}-${oldday}.csv"




new_sbdv_minus="${newtmp}/VPN_SN_minus_timeout_${client}_${nowaday}.csv"
old_sbdv_minus="${oldtmp}/VPN_SN_minus_timeout_${client}_${oldday}.csv"

new_each_full_replace="${newtmp}/each_full_replace_${client}_${nowaday}.csv"
old_each_full_replace="${oldtmp}/each_full_replace_${client}_${oldday}.csv"

new_exist_location_name_sbsr="${newtmp}/location_name_${client}_${nowaday}"  
old_exist_location_name_sbsr="${oldtmp}/location_name_${client}_${oldday}"

dos2unix  ${new_each_file}

##先整理格式，再匹配location_name
##按照顺序 FC|DK|McC|DT|CNB|DCB|Other
awk -F , -v OFS=","  'NR>1{
if            ($12=="FC")     print $2,$4",,"$5,$7,$8,$9,$10,$11,"1,0,0,0,0,0,0,0,0,0"
else if       ($12=="DK")     print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,1,0,0,0,0,0,0,0,0"
else if       ($12=="McC")    print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,1,0,0,0,0,0,0,0"
else if       ($12=="DT")     print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,1,0,0,0,0,0,0"
else if       ($12=="CNB")    print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,0,1,0,0,0,0,0"
else if       ($12=="DCB")    print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,0,0,1,0,0,0,0"
else if       ($12=="OCS")    print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,0,0,0,1,0,0,0"
else if       ($12=="CFS")    print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,0,0,0,0,1,0,0"
else if       ($12=="LED")    print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,0,0,0,0,0,1,0"
else if       ($12=="Other")  print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,0,0,0,0,0,0,1"
else                          print $2,$4",,"$5,$7,$8,$9,$10,$11,"0,0,0,0,0,0,0,0,0,1"
}' ${new_each_file}    >  ${new_result_no_name_file}



#awk '{if(!(($0~/unknow/)||($0~/No Location/))) print $0}'  ${new_sbsr_file}   >  ${new_exist_location_name_sbsr}   

##需要分成有双引号和没有双引号的来看


#awk 'NR==FNR&&NR>1{
#if(NF==14){
##按loation name有逗号的来写
#a[$2]=$4","$5
#}
#else{
###按没有逗号的来写
#if($4~/\"/){
#a[$2]=$4"\""
#}else{
#a[$2]=$4
#}
#}
#}
#NR>FNR{
#if($1 in a) print $1","$2","a[$1]","$4","$5","$6","$7","$8","$9","$10","$11 ","$12 ","$13 ","$14","$15","$16","$17","$18","$19
#else print $1","$2",,"$4","$5","$6","$7","$8","$9","$10","$11 ","$12 ","$13 ","$14","$15","$16","$17","$18","$19
#}'  FS="," ${new_exist_location_name_sbsr}  FS="," ${new_result_no_name_file}  >${new_result_csv_file}


awk 'NR==FNR&&NR>1{
a[$1]=$2
}
NR>FNR{
if($1 in a) print $1","$2","a[$1]","$4","$5","$6","$7","$8","$9","$10","$11 ","$12 ","$13 ","$14","$15","$16","$17","$18","$19
else print $1","$2",,"$4","$5","$6","$7","$8","$9","$10","$11 ","$12 ","$13 ","$14","$15","$16","$17","$18","$19
}'  FS="|" ${new_exist_location_name_sbsr}  FS="," ${new_result_no_name_file}  >${new_result_csv_file}


total_site=`awk -F , '{a[$1]=a[$1]+1}END{for(i in a) print i}' ${new_result_csv_file}|wc -l`
total_FC=`awk -F , '{if(NF==20){print $11}else{print $10}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_DK=`awk -F , '{if(NF==20){print $12}else{print $11}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_McC=`awk -F , '{if(NF==20){print $13}else{print $12}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_DT=`awk -F , '{if(NF==20){print $14}else{print $13}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_CNB=`awk -F , '{if(NF==20){print $15}else{print $14}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_DCB=`awk -F , '{if(NF==20){print $16}else{print $15}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_OCS=`awk -F , '{if(NF==20){print $17}else{print $16}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_CFS=`awk -F , '{if(NF==20){print $18}else{print $17}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_LED=`awk -F , '{if(NF==20){print $19}else{print $18}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`
total_Other=`awk -F , '{if(NF==20){print $20}else{print $19}}'  ${new_result_csv_file}  |awk '{sum+=$1}END{print sum}'`

total_ODMB=`expr ${total_DT} + ${total_OCS} + ${total_CFS}`
total_MP=`expr ${total_FC} + ${total_DK} + ${total_McC} + ${total_DT} + ${total_CNB} + ${total_DCB} + ${total_OCS} + ${total_CFS} + ${total_LED} + ${total_Other}`
total_IDBM=`expr ${total_FC} + ${total_DK} + ${total_McC} + ${total_CNB} + ${total_DCB} + ${total_LED} + ${total_Other}`

echo "" >> ${new_result_csv_file}
echo "" >> ${new_result_csv_file}
echo "Total Site #,,,,,,,,,FC,DK,McC,DT,CNB,DCB,OCS,CFS,LED,Other"  >> ${new_result_csv_file}
echo "${total_site},,,,,,,,,${total_FC},${total_DK},${total_McC},${total_DT},${total_CNB},${total_DCB},${total_OCS},${total_CFS},${total_LED},${total_Other}"  >> ${new_result_csv_file}
echo "" >> ${new_result_csv_file}
echo "Location,IDMB,ODMB,Total MP"  >> ${new_result_csv_file}
echo "${total_site},${total_IDBM},${total_ODMB},${total_MP}"  >> ${new_result_csv_file}

####首行插入列名
sed  -i '1 i\location_code,state,Location Name,ip,Product_name,S/N,Install Date (Invoicing),Install Date (SB Output) Current,Install Date (SB Output) Previous,FC,DK,McC,DT,CNB,DCB,OCS,CFS,LED,Other'   ${new_result_csv_file}
