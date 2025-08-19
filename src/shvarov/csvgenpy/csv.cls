Class shvarov.csvgenpy.csv
{

/// CSVGENPY.GENERATE
/// filename - file or URL to import
/// primarykey - the name of the column to introduce a primary key for
ClassMethod Generate(filename, tablename = "csvgenpy", schema = "csvgen", server = "iris+emb:///", append As %Boolean = 0, header = 1, primarykey = "") As %Status
{
        Set sc = $$$OK
        Set csv = ##class(%SYS.Python).Import("csvgen")
        if $L(filename,"http")>1 {
            Set stream=..GetStreamFromURL(filename)
            Set sc=..StreamToFile(stream,.filename)
            if $$$ISERR(sc) Return sc
        }

        do csv.importcsv(filename,tablename,server,schema,$case(append,1:"append",:"replace"),header)
        //B "L"
        // add primary key if we are not appending
        if primarykey'="",'append {
            do ..DeleteAllData(schema_"."_tablename)
            do ..DropDDLIndex(schema_"."_tablename)
            set sc=..AddPrimaryKey(schema_"."_tablename,primarykey)
            do csv.importcsv(filename,tablename,server,schema,"append",header)
        }
        Return sc
}

ClassMethod DropDDLIndex(table) As %Status
{
    //B "L"
    set st=$$$OK
    set tStatement = ##class(%SQL.Statement).%New()
    set query = "DROP INDEX ""%%DDLBEIndex"" ON TABLE "_table
    set qStatus = tStatement.%Prepare(query)
    if qStatus '= 1 return qStatus
    set rset=tStatement.%Execute()
    if rset.%SQLCODE < 0 {
        write "Error dropping index: "_rset.%SQLCODE_" "_rset.%Message
        set ex=##class(%Exception.SQL).CreateFromSQLCODE(%sqlcode,%message)
        return ex.%AsStatus()
    }
    return st
}

ClassMethod DeleteAllData(table) As %Status
{
    set st=$$$OK
    set tStatement = ##class(%SQL.Statement).%New()
    set query = "DELETE FROM "_table
    set qStatus = tStatement.%Prepare(query)
    if qStatus '= 1 return qStatus
    set rset=tStatement.%Execute()
    if rset.%SQLCODE < 0 {
        write "Error deleting data: "_rset.%SQLCODE_" "_rset.%Message
        set ex=##class(%Exception.SQL).CreateFromSQLCODE(%sqlcode,%message)
        return ex.%AsStatus()
    }
    return st
}

ClassMethod AddPrimaryKey(table, column) As %Status
{
    // turn on DDLPKeyNotIDKey option
    set st=$$$OK
    do $System.SQL.Util.SetOption("DDLPKeyNotIDKey",0,.oldoption)
    try {
    set tStatement = ##class(%SQL.Statement).%New()
    set query = "ALTER Table "_table_" ADD PRIMARY KEY ("_column_")"
    $$$TOE(st,tStatement.%Prepare(query))
    set rset=tStatement.%Execute()
    if rset.%SQLCODE < 0 {
        write "Error adding primary key: "_rset.%SQLCODE_" "_rset.%Message
       set ex=##class(%Exception.SQL).CreateFromSQLCODE(%sqlcode,%message)
        $$$ThrowStatus(ex.%AsStatus)
        }
    }
    catch ex {
        set st=ex.%AsStatus()
    }
    do $System.SQL.Util.SetOption("DDLPKeyNotIDKey",oldoption)
     
    return st
}

ClassMethod StreamToFile(stream As %Stream, ByRef filename As %String) As %Status
{
    if $G(filename)="" set filename=##class(%File).NormalizeDirectory(##class(%SYS.System).TempDirectory())_"stream"_($zd($h,8))
    Set file=##class(%Stream.FileCharacter).%New()
    Do file.LinkToFile(filename)
    Set sc=file.CopyFromAndSave(stream)
    return sc
}

ClassMethod GetStreamFromURL(URL As %String, SSLConf As %String = "default") As %CharacterStream
{
    set ns=$znspace
    zn "%SYS"

    //set SSLConfig="GitHub"
    do:'##class(Security.SSLConfigs).Exists(SSLConf) ##class(Security.SSLConfigs).Create(SSLConf)
    zn ns

    if $L(URL,"http")>1 set URL=$P(URL,"//",2)
    Set httprequest = ##class(%Net.HttpRequest).%New()
    Set httprequest.Server = $P(URL,"/")
    Set httprequest.Https = 1
    Set httprequest.SSLConfiguration = SSLConf
    set proxy=$System.Util.GetEnviron("https_proxy")
    if proxy'="" {
      Do ##class(%Net.URLParser).Parse(proxy,.pr)
      set:$G(pr("host"))'="" httprequest.ProxyHTTPS=1,httprequest.ProxyTunnel=1,httprequest.ProxyPort=pr("port"),httprequest.ProxyServer=pr("host")
      set:$G(pr("username"))'=""&&($G(pr("password"))'="") httprequest.ProxyAuthorization="Basic "_$system.Encryption.Base64Encode(pr("username")_":"_pr("password"))
    }
    set filename="/"_$P(URL,"/",2,*)
    $$$TOE(sc,httprequest.Get(filename))
    Set stream = httprequest.HttpResponse.Data

    //Reset the HTTP connection, to allow for another connection and not throw a 404 error
    Do httprequest.Reset()

    //TBD check for sc
    return stream
}

ClassMethod TestRun() As %Status
{
        Set sc = $$$OK
        set fn="/home/irisowner/dev/data/10k_diabetes_small 2.csv"
        set fn="/home/irisowner/dev/data/titanic.csv"
	    set tname="sqltest"
        ;do ##class(Test.shvarov.csvgenpy.Testcsv).DeleteTable("SQLUSER_"_tname)
	    set rc=##class(shvarov.csvgenpy.csv).Generate(fn,tname)
        write !,rc
	Return sc
}

}
