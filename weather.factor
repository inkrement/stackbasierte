#!/usr/bin/env factor -script

! http://api.openweathermap.org/data/2.5/weather?q=Vienna

USING: assocs kernel http.client sequences prettyprint json.reader ;
IN: weather

CONSTANT: fixed-url-part "http://api.openweathermap.org/data/2.5/weather?q="


: get-http-data ( url -- data ) http-get nip ;
: url ( str -- str ) fixed-url-part swap append ;
: get-value ( hsh str -- str ) swap at* drop ;

! von wien holen
"Vienna" url get-http-data

! json string in hashtable umwandeln
json>

! temperatur auslesen
"main" get-value "temp" get-value


.