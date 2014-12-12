USING: assocs kernel math.functions http.client sequences prettyprint json.reader math formatting classes.tuple ; 
IN: weather

CONSTANT: fixed-openweather "http://api.openweathermap.org/data"
CONSTANT: fixed-history "/2.5/history/city?type=day&q="
CONSTANT: fixed-act "/2.5/weather?q="

SYMBOLS: K C ;
! SYMBOL: temp-unit
! : convert_to_kelvin? ( temp-unit -- ? )
!    temp-unit get temp-unit<=> +lt+ = not ;

! Tuple which represents the weather data informations
TUPLE: weatherstation location temperature avgtemperature ;

! load HTTP
: get-http-data ( url -- data ) 
    http-get nip ;

! reverse string concatenation
: concat_rev ( str str -- str )
    swap append ;

! weather api specific url generation
: url_h ( str -- str ) fixed-openweather fixed-history append concat_rev ;
: url_a ( str -- str ) fixed-openweather fixed-act append concat_rev ;

! parse JSON
: get-value ( hsh str -- str ) 
    swap at* drop ;

: get-weather-list ( str -- hsh ) 
    url_h get-http-data json> 
    "list" get-value ;

: parse-weather ( hsh -- str ) 
    "main" get-value 
    "temp" get-value ;

: two-decimal-round ( x -- x )
    100 * round 100 / ;

: kelvin-to-celsius ( x -- x ) 
    ! Helper word for converting a temperature value
    ! in Kelvin to a temperature value in celsius
    273.15 - 
    two-decimal-round ;

: calculate-temp ( city -- avg-temp )
    ! Helper to get avg temperature in format #.##
    get-weather-list [ parse-weather ] map 
    dup length swap sum swap / 
    kelvin-to-celsius ;

: get-act-weather ( x -- x )
    url_a get-http-data json> parse-weather ;

: weather-demo ( -- ) C "Vienna" get-act-weather kelvin-to-celsius pprint . ;
: weather-hist-demo ( -- ) "Vienna" calculate-temp  C swap pprint . ;

MAIN: weather-hist-demo