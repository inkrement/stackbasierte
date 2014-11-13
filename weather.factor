#!/usr/bin/env factor -script

! http://api.openweathermap.org/data/2.5/weather?q=Vienna

USING: kernel http.client sequences ;
IN: weather

CONSTANT: fixed-url-part "http://api.openweathermap.org/data/2.5/weather?q="


: get-http-data ( url -- data ) http-get nip ;
: url ( str -- str ) fixed-url-part swap append ;

"Vienna" url get-http-data

drop