#!/usr/bin/env factor -script

! http://api.openweathermap.org/data/2.5/weather?q=Vienna

USING: assocs kernel http.client sequences prettyprint json.reader math ;
IN: weather

CONSTANT: fixed-url-part "http://api.openweathermap.org/data/2.5/weather?q="
CONSTANT: fixed-url-part-history "http://api.openweathermap.org/data/2.5/history/city?type=day&q="


: get-http-data ( url -- data ) http-get nip ;
: url ( str -- str ) fixed-url-part swap append ;
: get-value ( hsh str -- str ) swap at* drop ;
: parse-weather ( hsh -- str ) "main" get-value "temp" get-value ;
: get-weather ( str -- str ) url get-http-data json> parse-weather ;

! historical weather
: url_h ( str -- str ) fixed-url-part-history swap append ;

! : parse-hist-weather ( hsh -- ... ) "list" get-value [ "main" get-value "temp" get-value ] each ;
! : calc-sum ( hsh -- x ) "list" get-value [ "main" get-value "temp" get-value ] each 9 [ + ] times ;

: get-weather-list ( str -- hsh ) url_h get-http-data json> "list" get-value ;
! : get-hist-weather ( str -- n ) get-weather-list calc-sum ;


! calculate sum of 10 values
"Vienna" get-weather-list [ "main" get-value "temp" get-value ] each 9 [ + ] times

! calculate avg
10 /

! kelvin to celsius
273.25 -

! von wien holen
! "Vienna" get-weather

.

clear