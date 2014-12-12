USING: weather parser tools.test eval ;
IN: weather.tests

[ 20.0 ] [ 293.15 kelvin-to-celsius ] unit-test
[ -173.15 ] [ 100 kelvin-to-celsius ] unit-test
[ 22.25 ] [ 22.253231 two-decimal-round ] unit-test
[ 22.25 ] [ 22.246731 two-decimal-round ] unit-test
[ "22.25" two-decimal-round ] must-fail