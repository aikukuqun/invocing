#!/usr/bin/python
# -*- coding: utf-8 -*-


#############################################################
#############################################################
##### Extract Report Constraints Vilations     ##############
#############################################################
#############################################################

import re
import os
import sys
import csv
import glob
import gzip
import time
from datetime import datetime

reload(sys)
sys.setdefaultencoding('utf8')
 
sys.path.append("/data/nishome/donghua.gu/scripts_gdh/pym")
 
import xlwt
import xlsxwriter



def get_num(result_csv_file):
  with open(result_csv_file) as csvfile:
    mLines = csvfile.readlines()
    targetLine = mLines[-1]
    global a
    a = int(targetLine.split(',')[0])
    global b
    b = int(targetLine.split(',')[1])
    global c
    c = int(targetLine.split(',')[2])
    global d
    d = int(targetLine.split(',')[3])



def merge_csv2xlsx(csv_dir, xlsxfile):
  # Create a new workbook and add a worksheet
  workbook = xlsxwriter.Workbook(xlsxfile)
  fmt_plain = workbook.add_format({
      'font_size':  11,
      'font_name':  "Calibri",
      'border' : 1,
  })

  fmt_plain_date_formate = workbook.add_format({
      'font_size':  11,
      'font_name':  "Calibri",
      'border' : 1,
      'num_format': 'dd/mm/yyyy',

  })


  fmt_plain_fg = workbook.add_format({
      'font_size':  11,
      'font_name':  "Calibri",
      'border' : 1,
      'fg_color' : '#FFFF00',
  })

  workfomat_bold = workbook.add_format({
    'bold' : True,
    'font_size':  18,
  })

  workfomat_border = workbook.add_format({
    'border' : 1,
  })

  workfomat_border_url = workbook.add_format({
    'border' : 1,
    'font_color' : '#0000FF',
  })  

  zero_fill_au_mcd = workbook.add_format({
    'bold' : True,
    'border' : 1,
    'font_color' : '#0000FF',
    })

  date_format = workbook.add_format({'num_format': 'dd/mm/yyyy'})

  fmt_plain = fmt_plain
  #workbook = xlwt.Workbook(xlsxfile)
  ws_names = []


  sheet_name = "global"
  worksheet = workbook.add_worksheet(sheet_name)
  num_format = workbook.add_format({'num_format': '0'})
  ###row,col,1st row,1st col.    according row to write
  worksheet.write_row(0,0,['Switchboard Deployment Client List'],workfomat_bold)
  worksheet.write_row(1,0,['ID','Region','Client','Sub-list','Location','MP of IDMB','MP of ODMB','Total MP'
],workfomat_border)
  get_num("./result_csv/DeviceList-Invoicing-au.mcd-" + nowaday + ".csv")
  worksheet.write_row(2,0,[1,'ANZ','MCD Australia','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(2, 3, "internal:%s!A1" % ("au.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-nz.mcd-" + nowaday + ".csv")
  worksheet.write_row(3,0,[2,'ANZ','MCD New Zealand','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(3, 3, "internal:%s!A1" % ("nz.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-jp.mcd-" + nowaday + ".csv")
  worksheet.write_row(4,0,[3,'Japan','MCD Japan','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(4, 3, "internal:%s!A1" % ("jp.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-sg.mcd-" + nowaday + ".csv")
  worksheet.write_row(5,0,[4,'Singapore','MCD Sigapore','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(5, 3, "internal:%s!A1" % ("sg.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.hungryjacks-" + nowaday + ".csv")
  worksheet.write_row(6,0,[5,'Oceania','HUNGRYJACKS AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(6, 3, "internal:%s!A1" % ("au.hungryjacks"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-gt.mcd-" + nowaday + ".csv")
  worksheet.write_row(7,0,[6,'America','MCD Guatemala','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(7, 3, "internal:%s!A1" % ("gt.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-riyadh.sa.mcd-" + nowaday + ".csv")
  worksheet.write_row(8,0,[7,'Europe-MEA','MCD Riyadh','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(8, 3, "internal:%s!A1" % ("riyadh.sa.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.subway-" + nowaday + ".csv")
  worksheet.write_row(9,0,[8,'Oceania','SUBWAY AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(9, 3, "internal:%s!A1" % ("au.subway"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.bp-" + nowaday + ".csv")
  worksheet.write_row(10,0,[9,'Oceania','BP AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(10, 3, "internal:%s!A1" % ("au.bp"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-nl.mcd-" + nowaday + ".csv")
  worksheet.write_row(11,0,[10,'Europe-MEA','MCD Netherlands','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(11, 3, "internal:%s!A1" % ("nl.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.krispykreme-" + nowaday + ".csv")
  worksheet.write_row(12,0,[11,'Oceania','KRISPYKREME AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(12, 3, "internal:%s!A1" % ("au.krispykreme"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-us.mcd-" + nowaday + ".csv")
  worksheet.write_row(13,0,[12,'America','MCD US','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(13, 3, "internal:%s!A1" % ("us.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-py.mcd-" + nowaday + ".csv")
  worksheet.write_row(14,0,[13,'America','MCD Paraguay','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(14, 3, "internal:%s!A1" % ("py.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-uk.merlin-" + nowaday + ".csv")
  worksheet.write_row(15,0,[14,'Europe-MEA','MERLIN UK','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(15, 3, "internal:%s!A1" % ("uk.merlin"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-sv.mcd-" + nowaday + ".csv")
  worksheet.write_row(16,0,[15,'America','MCD El Salvador','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(16, 3, "internal:%s!A1" % ("sv.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-riyadh.subway-" + nowaday + ".csv")
  worksheet.write_row(17,0,[16,'Europe-MEA','Subway Riyadh','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(17, 3, "internal:%s!A1" % ("riyadh.subway"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.carlsjr-" + nowaday + ".csv")
  worksheet.write_row(18,0,[17,'Oceania','CARLSJR AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(18, 3, "internal:%s!A1" % ("au.carlsjr"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-mo.mcd-" + nowaday + ".csv")
  worksheet.write_row(19,0,[18,'Japan','MCD MACAU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(19, 3, "internal:%s!A1" % ("mo.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-hn.mcd-" + nowaday + ".csv")
  worksheet.write_row(20,0,[19,'America','MCD Honduras','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(20, 3, "internal:%s!A1" % ("hn.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-ni.mcd-" + nowaday + ".csv")
  worksheet.write_row(21,0,[20,'America','MCD Nicaragua','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(21, 3, "internal:%s!A1" % ("ni.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.merlin-" + nowaday + ".csv")
  worksheet.write_row(22,0,[21,'Oceania','MERLIN AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(22, 3, "internal:%s!A1" % ("au.merlin"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-fr.mcd-" + nowaday + ".csv")
  worksheet.write_row(23,0,[22,'Europe-MEA','MCD France','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(23, 3, "internal:%s!A1" % ("fr.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.tacobell-" + nowaday + ".csv")
  worksheet.write_row(24,0,[23,'Oceania','TACOBELL AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(24, 3, "internal:%s!A1" % ("au.tacobell"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-pf.mcd-" + nowaday + ".csv")
  worksheet.write_row(25,0,[24,'Oceania','MCD French Polynesia','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(25, 3, "internal:%s!A1" % ("pf.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-fj.mcd-" + nowaday + ".csv")
  worksheet.write_row(26,0,[25,'Oceania','MCD Fiji','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(26, 3, "internal:%s!A1" % ("fj.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-om.subway-" + nowaday + ".csv")
  worksheet.write_row(27,0,[26,'Europe-MEA','Subway Oman','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(27, 3, "internal:%s!A1" % ("om.subway"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.tarongazoo-" + nowaday + ".csv")
  worksheet.write_row(28,0,[27,'Oceania','TARONGAZOO AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(28, 3, "internal:%s!A1" % ("au.tarongazoo"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-kw.subway-" + nowaday + ".csv")
  worksheet.write_row(29,0,[28,'Europe-MEA','Subway Kuwait','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(29, 3, "internal:%s!A1" % ("kw.subway"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-jp.legoland-" + nowaday + ".csv")
  worksheet.write_row(30,0,[29,'Japan','LEGOLAND Japan','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(30, 3, "internal:%s!A1" % ("jp.legoland"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-sr.mcd-" + nowaday + ".csv")
  worksheet.write_row(31,0,[30,'America','MCD Suriname','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(31, 3, "internal:%s!A1" % ("sr.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-brn.mcd-" + nowaday + ".csv")
  worksheet.write_row(32,0,[31,'Singapore','MCD Brunei','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(32, 3, "internal:%s!A1" % ("brn.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-us.whataburger-" + nowaday + ".csv")
  worksheet.write_row(33,0,[32,'America','Whataburger US','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(33, 3, "internal:%s!A1" % ("us.whataburger"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-sharjah.uae.subway-" + nowaday + ".csv")
  worksheet.write_row(34,0,[33,'Europe-MEA','Subway Sharjah','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(34, 3, "internal:%s!A1" % ("sharjah.uae.subway"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-salalah.om.subway-" + nowaday + ".csv")
  worksheet.write_row(35,0,[34,'Europe-MEA','Subway Salalah','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(35, 3, "internal:%s!A1" % ("salalah.om.subway"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-abudhabi.uae.subway-" + nowaday + ".csv")
  worksheet.write_row(36,0,[35,'Europe-MEA','Subway Abu Dhabi','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(36, 3, "internal:%s!A1" % ("abudhabi.uae.subway"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-sg.pizzahut-" + nowaday + ".csv")
  worksheet.write_row(37,0,[36,'Singapore','PIZZAHUT Singapore','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(37, 3, "internal:%s!A1" % ("sg.pizzahut"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-ca.cfa-" + nowaday + ".csv")
  worksheet.write_row(38,0,[37,'Canada','Chick-Fil-A Canada','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(38, 3, "internal:%s!A1" % ("ca.cfa"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-ca.mcd-" + nowaday + ".csv")
  worksheet.write_row(39,0,[38,'Canada','McD Canada','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(39, 3, "internal:%s!A1" % ("ca.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-us.scnbnc-" + nowaday + ".csv")
  worksheet.write_row(40,0,[39,'America','Smithfields Chicken N Barbecue','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(40, 3, "internal:%s!A1" % ("us.scnbnc"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-us.cfa-" + nowaday + ".csv")
  worksheet.write_row(41,0,[40,'America','Chick-Fil-A US','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(41, 3, "internal:%s!A1" % ("us.cfa"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-lc.kfc-" + nowaday + ".csv")
  worksheet.write_row(42,0,[41,'America','KFC St Lucia','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(42, 3, "internal:%s!A1" % ("lc.kfc"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-sg.toysrus-" + nowaday + ".csv")
  worksheet.write_row(43,0,[42,'Singapore','Toys R Us SG','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(43, 3, "internal:%s!A1" % ("sg.toysrus"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-us.legoland-" + nowaday + ".csv")
  worksheet.write_row(44,0,[43,'America','LEGOLAND US','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(44, 3, "internal:%s!A1" % ("us.legoland"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-uae-subway-" + nowaday + ".csv")
  worksheet.write_row(45,0,[44,'Europe-MEA','Subway UAE','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(45, 3, "internal:%s!A1" % ("'uae-subway'"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-hk.mcd-" + nowaday + ".csv")
  worksheet.write_row(46,0,[45,'Hongkong','McD Hongkong','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(46, 3, "internal:%s!A1" % ("hk.mcd"),workfomat_border_url, string="detail")
  get_num("./result_csv/DeviceList-Invoicing-au.parkassist-" + nowaday + ".csv")
  worksheet.write_row(47,0,[46,'Oceania','Park Assist AU','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(47, 3, "internal:%s!A1" % ("au.parkassist"),workfomat_border_url, string="detail")

  get_num("./result_csv/DeviceList-Invoicing-pl.mcd-" + nowaday + ".csv")
  worksheet.write_row(48,0,[47,'Europe-MEA','MCD Poland','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(48, 3, "internal:%s!A1" % ("pl.mcd"),workfomat_border_url, string="detail")

  get_num("./result_csv/DeviceList-Invoicing-at.mcd-" + nowaday + ".csv")
  worksheet.write_row(49,0,[47,'Europe-MEA','MCD Austria','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(49, 3, "internal:%s!A1" % ("at.mcd"),workfomat_border_url, string="detail")  

  get_num("./result_csv/DeviceList-Invoicing-it.mcd-" + nowaday + ".csv")
  worksheet.write_row(50,0,[49,'Europe-MEA','MCD Italy','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(50, 3, "internal:%s!A1" % ("it.mcd"),workfomat_border_url, string="detail")

  get_num("./result_csv/DeviceList-Invoicing-be.mcd-" + nowaday + ".csv")
  worksheet.write_row(51,0,[50,'Europe-MEA','MCD Belgium','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(51, 3, "internal:%s!A1" % ("be.mcd"),workfomat_border_url, string="detail")

  get_num("./result_csv/DeviceList-Invoicing-cz.mcd-" + nowaday + ".csv")
  worksheet.write_row(52,0,[51,'Europe-MEA','MCD Czech','detail', a, b, c, d],workfomat_border)
  worksheet.write_url(52, 3, "internal:%s!A1" % ("cz.mcd"),workfomat_border_url, string="detail")
  
  worksheet.set_column('A:A', 8)
  worksheet.set_column('B:B', 12)
  worksheet.set_column('C:C', 30)

  for filename in sorted(glob.glob("./%s/*.csv" % csv_dir), key=os.path.getsize, reverse=True):
    print "  procsss %s" % filename
    (f_path, f_name) = os.path.split(filename)
    (f_short_name, f_extension) = os.path.splitext(f_name)
    sheet_name = f_short_name[21:-9]
    if sheet_name in ws_names:
      sheet_name = "%s-%d" % (len(ws_names))
    worksheet = workbook.add_worksheet(sheet_name)

    spamReader = csv.reader(open(filename, 'rb'), delimiter=',',quotechar='"')
#    worksheet.write(0, 18, xlwt.Formula("A3+B3"))
    with open(filename, 'r') as f:
      global total_row
      total_row = len(f.readlines())
#    print total_row 
    worksheet.write_url(0, 19, "internal:%s!A1" % ("global"), workfomat_border_url, string="return_global")

    row_count = 0
    for row in spamReader:
      for col in range(len(row)):
        if col == 0 :
          value = str(row[col])
        else :
          
          value = row[col]
          try:
            value = int(value)
          except:
            try:
              value = float(value)
            except:
               #print "    Value not number: %s" % row[col]
               pass
        if row_count == 0 :
          worksheet.write(row_count, col, value, fmt_plain_fg)
        else :
            if col == 6 or col == 7 or col == 8:
              if value == "" or value == "store_offline" or value == "          ":
                worksheet.write(row_count, col, value, fmt_plain)
              else:
              	try:
		    value = datetime.strptime(value, "%Y/%m/%d")
                    value = value.strftime('%d/%m/%Y')
                except:
                    value = datetime.strptime(value, "%Y-%m-%d")
                    value = value.strftime('%d/%m/%Y')
                worksheet.write(row_count, col, value, fmt_plain_date_formate)
            else:
              worksheet.write(row_count, col, value, fmt_plain)
      row_count +=1
      

  workbook.close()
  print "xlsx file saved: %s" % xlsxfile
  return
 
 
if __name__ == "__main__":
 
  if len(sys.argv) != 3:
    print "\nUsage:"
    print "\t%s <csv dir> <nowaday>\n" % sys.argv[0]
    sys.exit(0)
 
  tag = time.strftime("%Y%m%d-%H%M%S")
  rpt_dir = sys.argv[1]
  nowaday = sys.argv[2]
  #xlsxfile = "%s/merge_%s.xlsx" % (rpt_dir, tag)
  xlsxfile = "merge_%s.xlsx" % (tag)
  merge_csv2xlsx(rpt_dir, xlsxfile)
