Class shvarov.csvgenpy.generate
{

/// CSVGENPY.GENERATE
ClassMethod Generate(filename, tablename = "csvgenpy", schema = "csvgen", server = "iris+emb:///", append As %Boolean = 0) As %Status
{
        Set sc = $$$OK
        Set csv = ##class(%SYS.Python).Import("csvgen")
        do csv.importcsv(filename,tablename,server,schema,$case(append,1:"append",:"replace"))
        Return sc
}

ClassMethod TestRun() As %Status
{
        Set sc = $$$OK
        set fn="/home/irisowner/dev/data/10k_diabetes_small 2.csv"
        set fn="/home/irisowner/dev/data/titanic.csv"
	    set tname="sqltest"
        ;do ##class(Test.shvarov.csvgenpy.Testcsv).DeleteTable("SQLUSER_"_tname)
	    set rc=##class(shvarov.csvgenpy.generate).Generate(fn,tname)
        write !,rc
	Return sc
}

}
