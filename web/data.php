<?php

/*
    Reading data from SQL database and converting to JSON.
    Example as presented by nyquist212.wordpress.com.
*/

$serverName = "aaltoms.database.windows.net";
$uid = "aaltoadmin@aaltoms";
$pwd = "fD^bS7yVGw";
$db = "ms_twitter";
$connectionInfo = array( "UID"=>$uid,
                         "PWD"=>$pwd,
                         "Database"=>$db,
                         "CharacterSet"=>"UTF-8");

//echo phpversion();
//echo phpversion('sqlsrv');

/* Connect using SQL Server Authentication. */
$conn = sqlsrv_connect( $serverName, $connectionInfo);

if( $conn === false ) {
     echo "Unable to connect.</br>";
     die( print_r( sqlsrv_errors(), true));
}

/* TSQL Query */
$tsql = "SELECT * FROM twitter_opinions ORDER BY hour, sentiment";
$stmt = sqlsrv_query( $conn, $tsql);

if( $stmt === false ) {
     echo "Error in executing query.</br>";
     die( print_r( sqlsrv_errors(), true));
}

/* Process results */
$json = array();

do {
     while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
     $json[] = $row;
     }
} while ( sqlsrv_next_result($stmt) );

/* Run the tabular results through json_encode() */
/* And ensure numbers don't get cast to trings */
echo json_encode($json, JSON_NUMERIC_CHECK);
/* Free statement and connection resources. */
sqlsrv_free_stmt( $stmt);
sqlsrv_close( $conn);

?>
