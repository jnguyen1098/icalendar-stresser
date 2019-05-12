# Calendar Angel ("_Angel of Stress_")

## Introduction
I developed these test harnesses on my own during my time in CIS\*2750. In creating a RESTful web app, we were first instructed to create a C backend that parsed [standard RFC 5545](https://tools.ietf.org/html/rfc5545) iCalendar files. As the prof.'s assignment specification was strict, we all had to use the same function definitions, so keeping this in mind I created iCalendarStresser in order to streamline testing of valid and invalid inputs against the project API in order to make the 'Angel of Death' much more bearable.

## Tests
* `createCalendar()` file validation stress test 
* `writeCalendar()` file validation stress test 
* `validateCalendar()` Calendar object validation stress test 
* `validateCalendar()` Calendar error precedence vulnerability test
