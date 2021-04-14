##!/bin/bash
threadCount=200
rampUp=5
durationTime=20
sleepTime1=5
sleepTime2=6

REPORT_TIME=`date '+%Y%m%d%H%M%S'`
jmeter_basedir=/usr/local/jmeter/apache-jmeter-4.0
JMETEREXT=$jmeter_basedir/lib/ext
report_icon=$jmeter_basedir/extras/collapse.png

basedir=/home/ec2-user/workspace/jmeterTestReports/
report=$basedir/report/$JOB_NAME/$BUILD_NUMBER/
latest=$basedir/report/$JOB_NAME/latestResult/
mkdir -p $report
mkdir -p $latest

echo "starting..."
#脚本参与引入通过构建参数引入
echo $threadCount
echo $rampUp
echo $durationTime
echo $sleepTime1
echo $sleepTime2
#删除多余的jtl
cd $latest
pwd
rm -rf *


cd $WORKSPACE/testScript/
pwd
for v1 in $(ls *.jmx)
do
cd $jmeter_basedir/bin
pwd
sh jmeter.sh -JthreadNum=$threadCount -JrampUp=$rampUp -JDurationTime=$durationTime -n -t $WORKSPACE/testScript/$v1 -l $report/TestReport.jtl -e -o $report/TestReport_HTML


#java -jar $JMETEREXT/CMDRunner.jar --tool Reporter --generate-png $report_jtl/$REPORT_TIME_ResponseTimesOverTime.png --input-jtl $report_jtl/TestReport_$REPORT_TIME.jtl --plugin-type ResponseTimesOverTime
#java -jar $JMETEREXT/CMDRunner.jar --tool Reporter --generate-png $report_jtl/$REPORT_TIME_CPUMemory.png --input-jtl $jmeter_basedir/devops/CPUMemory.jtl --plugin-type PerfMon

sleep $sleepTime1

#sh jmeter.sh -g $report_jtl/TestReport_$REPORT_TIME.jtl -o $report_html/TestReport_$REPORT_TIME &

#sleep 5

done 
sleep $sleepTime2

#这个命令把Jmeter的结果文件转换为HTML的报告,有点问题，不是很有必要，因为上面已经生成了html报告。
#xsltproc $jmeter_basedir/extras/jmeter-results-detail-report_21.xsl $report_jtl/TestReport_$REPORT_TIME.jtl > $report_html/TestReport_$REPORT_TIME.html &
cp -r $report/* $latest

ls -a $basedir/report/

#备份结果文件，用处不大
#mkdir -p $WORKSPACE/report/$REPORT_TIME/
#cp $report_jtl/TestReport_$REPORT_TIME.jtl $WORKSPACE/report/$REPORT_TIME/
#cp -r $report_html/$REPORT_TIME $WORKSPACE/report/$REPORT_TIME/TestReport_$REPORT_TIME

echo "ending..."
