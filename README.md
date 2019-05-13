# iCalendarStresser

I developed these test harnesses on my own during my time in CIS\*2750. In creating a RESTful web app, we were first instructed to create a C backend that parsed [standard RFC 5545](https://tools.ietf.org/html/rfc5545) iCalendar files. As the prof.'s assignment specification was strict, we all had to use the same function definitions, so keeping this in mind I created iCalendarStresser in order to streamline testing of valid and invalid inputs against the project API in order to make the 'Angel of Death' course much more bearable.

## Summary of Tests
* `createCalendar()`—calendar file parsing stress test; tests the function's ability to parse iCalendar files correctly and create objects
  * 7 tests for `INV_FILE` (invalid file)
  * 12 tests for `INV_CAL` (invalid Calendar object)
  * 5 tests for `INV_VER` (invalid version)
  * 4 tests for `DUP_VER` (duplicate version value)
  * 3 tests for `INV_PRODID` (invalid product ID)
  * 4 tests for `DUP_PRODID` (duplicate product ID)
  * 13 tests for `INV_EVENT` (invalid event)
  * 5 tests for `INV_DT` (invalid date/time)
  * 10 tests for `INV_ALARM` (invalid alarm)
  * 6 tests that run badly formatted files (no expected error)
  * 2 tests that highlight undefined issues in the assignment specification (no expected error)
  * 3 tests for NULL function arguments (NULL & NULL, NOT NULL & NULL, NULL & NOT NULL)
  * 18 tests for `OK` (valid file)
* `createCalendar()` and `writeCalendar()`—calendar file parsing and filewriting stress test
  * 19 valid files are parsed into Calendar objects using `createCalendar()`. They are then re-written to disk in a dedicated exports folder, then a character-by-character comparison of the two files is done. Test(s) fail if the resultant files don't match exactly or the initial `createCalendar()` call fails to return `OK`.
* `validateCalendar()`—calendar object validation stress test
  * 39 tests for `INV_CAL` (invalid Calendar object)
  * 116 tests for `INV_EVENT` (invalid Event object)
  * 104 tests for `INV_ALARM` (invalid Alarm object)
  * 273 collision tests for simultaneous `INV_CAL` and `INV_EVENT` errors (`INV_CAL` takes precedence)
  * 208 collision tests for simultaneous `INV_CAL` and `INV_ALARM` errors (`INV_CAL` takes precedence)
  * 336 collision tests for simultaneous `INV_EVENT` and `ENV_ALARM` errors (`INV_EVENT` takes precedence)
  * 4368 collision tests for simultaneous `INV_CAL`, `INV_EVENT`, and `INV_ALARM` errors (`INV_CAL` takes precedence)
  * 39 tests for `OK` (valid Calendar object)
* `validateCalendar()`—calendar API error precedence vulnerability test
  * 1 test for cross-event error collision between `INV_EVENT` and `INV_ALARM` (`INV_EVENT` takes precedence)
