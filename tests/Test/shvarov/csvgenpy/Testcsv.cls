Class Test.shvarov.csvgenpy.Testcsv Extends %UnitTest.TestCase
{

ClassMethod RecordCount(tname)
{
	set rs=##class(%SQL.Statement).%ExecDirect(,"SELECT COUNT(*) FROM "_tname)
	do rs.%Next()
	set result=rs.%GetData(1)
	quit result
}

ClassMethod DeleteTable(tname)
{
	set status=##class(%SQL.Statement).%ExecDirect(,"DROP TABLE "_tname)
}

Method TestTimeStamp()
{
	Set tExpected=9
	set fn="/home/irisowner/dev/data/10k_diabetes_small 2.csv"
	set tname="sqltest"
	set rc=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestReservedWords()
{
	Set tExpected=30
	set fn="/home/irisowner/dev/data/Educational_Attainment_small.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDateTime()
{
	Set tExpected=1010
	set fn="/home/irisowner/dev/data/Educational_Attainment.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestNoHeader()
{
	Set tExpected=4
	set fn="/home/irisowner/dev/data/test_header.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set fn="/home/irisowner/dev/data/test_noheader.csv"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname,,,,0)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestNoLoadData()
{
	Set tExpected=9
	set fn="/home/irisowner/dev/data/10k_diabetes_small 2.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestAppend()
{
	Set tExpected=18
	set fn="/home/irisowner/dev/data/10k_diabetes_small 2.csv"
	set tname="sqltest"
	do ..DeleteTable("csvgen."_tname)
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname,,,1)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDotsinCols()
{
	Set tExpected=809
	set fn="/home/irisowner/dev/data/organisations.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestGenerate()
{
	Set tExpected=272
	set fn="/home/irisowner/dev/data/covid-03-16-2020.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestWithRowtype()
{
	Set tExpected=272
	set fn="/home/irisowner/dev/data/covid-03-16-2020.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestGenerateNoGuess()
{
	Set tExpected=272
	set fn="/home/irisowner/dev/data/covid-03-16-2020.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestGenerateFromURL()
{
	Set tExpected=3347
	set url="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-17-2020.csv"
	set tname="sqltest"
	set status=##class(shvarov.csvgenpy.generate).Generate(url,tname)
	set tResults=..RecordCount("csvgen."_tname)
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
