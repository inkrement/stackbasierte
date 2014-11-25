#!/usr/bin/env factor -script

! http://api.openweathermap.org/data/2.5/weather?q=Vienna

USING: assocs kernel math.functions http.client sequences prettyprint json.reader math formatting classes.tuple ; 
IN: weather

CONSTANT: fixed-url-part "http://api.openweathermap.org/data/2.5/weather?q="
CONSTANT: fixed-url-part-history "http://api.openweathermap.org/data/2.5/history/city?type=day&q="

! Tuple which represents the weather data informations
TUPLE: weatherstation location temperature avgtemperature ;

: get-http-data ( url -- data ) 
    http-get nip ;

: url ( str -- str ) 
    fixed-url-part swap append ;

: get-value ( hsh str -- str ) 
    swap at* drop ;

: parse-weather ( hsh -- str ) 
    "main" get-value 
    "temp" get-value ;

: get-weather ( city -- str ) 
    url get-http-data 
    json> parse-weather ;

! historical weather
: url_h ( str -- str ) 
    fixed-url-part-history swap append ;

: get-weather-list ( str -- hsh ) 
    url_h get-http-data json> 
    "list" get-value ;


: kelvin-to-celsius ( x -- y ) 
    #! Helper word for converting a temperature value
    #! in Kelvin to a temperature value in celsius
    273.25 - ;

: two-decimal-round ( x -- x )
    100 * round 100 / ;


: calculate-temp ( city -- avg-temp )
    #! Helper to get avg temperature in format #.##
    get-weather-list [ "main" get-value "temp" get-value ] map 
    dup length swap sum swap / 
    kelvin-to-celsius 
    two-decimal-round ;



"Vienna" calculate-temp

.