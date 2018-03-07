#!/usr/bin/env python
# -*- coding: utf-8 -*-
import time
import tornado.ioloop
import tornado.web
import cx_Oracle
import codecs
from tornado.escape import url_escape
from tornado.escape import json_encode
from datetime import datetime
from datetime import timedelta



##监控治理day
class DayReportHandler(tornado.web.RequestHandler):
    def get(self):
        rt = datetime.now()
        DefaultDay = rt.strftime('%Y-%m-%d')
        WhichDay = self.get_argument("WhichDay", default=DefaultDay)
        #print WhichDay

        rs = [["Oracle Log","32","KX3","审计署商业银行审计数据分析平台","ORA日志报错","12"],["应用盘使用率高","32","应用","开放平台应用","网卡异常","12"],["网卡异常","15","KX1","数据仓库","Teradata报警","9"]]
        DailyEvents = [["ORA 日志报错","32","KX3"],["应用盘使用率高","32","应用"],["网卡异常","15","KX1"]]
        AppEvents = [["审计署商业银行审计数据分析平台","ORA 日志报错","12",""],["开放平台应用","网卡异常","12",""],["数据仓库","Teradata报警","9",""]]
        OtherEvents = ["Others","10",""]
        TotalCnt = 190
        '''
        #get_time
        rs = cursor.execute("SELECT max(day) from NF_DailyByAppEvent")
        DefaultDay = rs.fetchone()[0].strftime('%Y-%m-%d')
        WhichDay = self.get_argument("WhichDay", default=DefaultDay)
        #get_DailyEvents
        cursor.prepare("SELECT e.EventNameCN,sum(e.Cnt),max(s.owner) from NF_DailyByAppEvent e,NF_EventSetting s where e.Eventnamecn = s.Eventnamecn and e.Eventnamecn<> 'OTHER' and to_char(e.day,'YYYY-MM-DD')=:day group by e.EventNameCN order by 2 desc")
        cursor.execute(None, {'day': WhichDay})
        DailyEvents = cursor.fetchall()
        #get_AppEvents
        cursor.prepare("SELECT AppName,EventNameCN,cnt,NVL(Memo,' ') from NF_DailyByAppEvent where to_char(day,'YYYY-MM-DD')=:day and EventNameCN<>'OTHER' order by cnt desc")
        AppEvents = cursor.execute(None, {'day' : WhichDay})
        #get_OtherEvents
        cursor.prepare("SELECT e.EventNameCN,sum(e.Cnt),max(s.owner) from NF_DailyByAppEvent e,NF_EventSetting s where e.Eventnamecn = s.Eventnamecn and e.Eventnamecn='OTHER' and to_char(e.day,'YYYY-MM-DD')=:day group by e.EventNameCN order by 2 desc")
        cursor.execute(None, {'day': WhichDay})
        OtherEvents = cursor.fetchone()
        #get_TotalCnt
        cursor.prepare("SELECT sum(cnt) from NF_DailyByAppEvent where to_char(day,'YYYY-MM-DD')=:day")
        cursor.execute(None, {'day': WhichDay})
        TotalCnt = cursor.fetchone()[0]
        '''

        self.render("DayReport.html", Event = DailyEvents, AppEvent= AppEvents, OtherEvents=OtherEvents,TotalCnt=TotalCnt,day=WhichDay)

    def post(self):
        day = self.get_argument("day")
        condition = self.get_argument("condition")
        #[AppName, EventNameCN] = condition.split('||')
        Memo = self.get_argument("memo")
        #cursor.prepare(
        #    "update NF_DailyByAppEvent set Memo=:Memo where to_char(day,'YYYY-MM-DD')=:day and AppName=:AppName and EventNameCN=:EventNameCN")
        #cursor.execute(None, {'day': day, 'Memo': Memo, 'AppName': AppName, 'EventNameCN': EventNameCN})
        #conn.commit()
        print "content is " +Memo
        print "time is " +day
        print condition

##监控治理week

class WeekReportHandler(tornado.web.RequestHandler):
    def get(self):
        lastweek_num = time.localtime()[7] / 7
#        week_num = self.get_argument("week_num", default=lastweek_num)
        rt = datetime.now()
        DefaultDay = rt.strftime('%Y-%m-%d')
        WhichDay = self.get_argument("WhichDay", default=DefaultDay)
        date_time = datetime.strptime(WhichDay, '%Y-%m-%d')
        week_num = 10
        if week_num > lastweek_num:
            week_num = lastweek_num
        self.render("WeekReport.html",week_num=week_num,day=WhichDay)

#app

class ComboStatJasonHandler(tornado.web.RequestHandler):
    def get(self):
        '''
        json_data = {"days":["day1","day2","day3"],
                     "data_arr":[{"data":[1,2,3],"name":"name1"},
                                 {"data":[1,2,3],"name":"name2"}]
                     }
        cursor.prepare("Select EventNameCN, sum(cnt) from NF_DailyByAppEvent where EventNameCN<>'OTHER' and day >= to_date(:StartDay,'YYYY-MM-DD') and day <=to_date(:EndDay,'YYYY-MM-DD')+1 group by EventNameCN order by 2 desc")
        cursor.execute(None, {'StartDay':StartDayStr,'EndDay':EndDayStr})
        tops=cursor.fetchmany(numRows=10)
        data_series = []
        for top in tops:
            topEvent = top[0]
            cursor.prepare("SELECT sum(cnt) from NF_DailyByAppEvent where EventNameCN=:topEvent and day >= to_date(:StartDay,'YYYY-MM-DD') and day <=to_date(:EndDay,'YYYY-MM-DD')+1 group by to_char(day,'YYYY-MM-DD') order by to_char(day,'YYYY-MM-DD') asc")
            cursor.execute(None, {'topEvent':topEvent,'StartDay':StartDayStr,'EndDay':EndDayStr})
            serie_data = []
            for cnt in cursor.fetchall():
                serie_data.append(cnt[0])
            data_series.append({"data":serie_data,"name":topEvent})
        days = []
        TheDay = datetime.strptime(StartDayStr, '%Y-%m-%d')
        while (TheDay.strftime('%Y-%m-%d') != EndDayStr):
            days.append(TheDay.strftime('%Y-%m-%d'))
            TheDay = TheDay + timedelta(days=1)
        days.append(EndDayStr)
        '''
        days=['1月1日', ' 1月2日', '1月3日', '1月4日', '1月5日','1月6日','1月7日','1月8日','1月9日','02-01']
        data_series=[
            {"type": 'column',"name": 'kx1',"data": [30, 20, 30, 20, 30,30, 20, 30, 20, 30]},
            {"type": 'column',"name": 'kx2',"data": [10, 5, 10, 5, 10,10, 5, 10, 5, 10,]},
            {"type": 'column',"name": 'kx3',"data": [40, 30, 40, 30, 40,40, 30, 40, 30, 40]},
            {"type": 'column',"name": 'kx4',"data": [60, 50, 60, 50, 60,60, 50, 60, 50, 60]},
            {"type": 'column',"name": 'kx5',"data": [30, 20, 30, 20, 30,30, 20, 30, 20, 30]},
            {"type": 'column',"name": 'other',"data": [40, 30, 40, 30, 40,40, 30, 40, 30, 40]},
            {"type": 'column',"name": '应用',"data": [40, 30, 40, 30, 40,40, 30, 40, 30, 40]},
            {"type": 'line',"name": '总报警数',"data": [250, 185, 250, 185, 250,250, 185, 250, 185, 250],
             "marker": {
                "lineWidth": 2,
                "lineColor": 'blue',
                "fillColor": 'blue'
                        }
            }
        ]
        print data_series
        json_data = {'data_series':data_series,'days':days}
        self.write(json_encode(json_data))

#top10
class PieStatJasonHandler(tornado.web.RequestHandler):
    def get(self):
        data_series = [
                ['kx1',100],
                ['kx2',100],
                ['kx3',100],
                ['kx4',500],
                ['kx5',100],
                ['other',100],
                ['app',100]
            ]
        print data_series
        self.write(json_encode(data_series))
'''
        StartDayStr = self.get_argument("StartDay")
        EndDayStr = self.get_argument("EndDay")
        cursor.prepare("Select AppName, EventNameCN, sum(cnt) from NF_DailyByAppEvent where EventNameCN<>'OTHER' and day >= to_date(:StartDay,'YYYY-MM-DD') and day <=to_date(:EndDay,'YYYY-MM-DD')+1 group by AppName,EventNameCN order by 3 desc")
        cursor.execute(None, {'StartDay':StartDayStr,'EndDay':EndDayStr})
        rows=cursor.fetchmany(numRows=10)
        for row in rows:
            data_series.append([row[0] + "_" + row[1], row[2]])
 '''


settings = {
    "template_path": "./templates",
    "static_path": "./static"
}



application = tornado.web.Application([
    (r"/", DayReportHandler),
    (r"/DayReport.html", DayReportHandler),
    (r"/WeekReport.html", WeekReportHandler),
    (r"/ComboStat.json", ComboStatJasonHandler),
    (r"/PieStat.json", PieStatJasonHandler),
], **settings)

if __name__ == "__main__":
#    conn = cx_Oracle.connect('reporter/Oper1234@84.7.19.147/reporter')
#    cursor = conn.cursor()
    application.listen(8080)
    tornado.ioloop.IOLoop.instance().start()
