# iCalendar Stresser

### [Installation](https://github.com/jnguyen1098/iCalendarStresser/wiki/Installation) | [Screenshots](#screenshots) | [Glossary](https://github.com/jnguyen1098/iCalendarStresser/wiki/Glossary)

This release consists of four test harnesses that contain a combined total of over 5000 automated test cases used to test three functions of the [CIS\*2750 iCalendar web app](https://github.com/jnguyen1098/iCalendarManager): `createCalendar()`, `writeCalendar()`, and `validateCalendar()`. I developed these test harnesses from scratch in C alongside the development of my iCalendar web app during the course. This project was to take place over the course of one academic semester at the University of Guelph and accounted for a majority of the grade.

In creating the RESTful web app mentioned above, we were first instructed to create a C backend that parsed [standard RFC 5545](https://tools.ietf.org/html/rfc5545) iCalendar files. As the prof.'s assignment specification was strict, we all had to use the same function definitions, akin to an API. Keeping this in mind, I created iCalendarStresser in order to streamline testing of valid and invalid inputs against the project API in order to make the 'Angel of Death' course much more bearable for me and my cohort.

iCalendarStresser consists of:
* four `.c` files that automate the testing process by means of API calls
* a repository of 96 iCalendar (`*.ics`) test cases organized by [error](https://github.com/jnguyen1098/iCalendarStresser/wiki/Error-Codes) invoked (credits to [BenFort](https://github.com/BenFort) and other people in my cohort for contributing many of these cases for the harness)
* a `Makefile` that automates the test running process

## Summary of Tests
* **A1harness ([wiki](https://github.com/jnguyen1098/iCalendarStresser/wiki/The-A1-Harness))**—iCalendar parsing stress test; tests `createCalendar()`'s ability to parse valid and invalid calendar files correctly 
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
* **A2m1harness ([wiki](https://github.com/jnguyen1098/iCalendarStresser/wiki/The-A2-Module-1-Harness))**—iCalendar parsing and filewriting stress test; tests `createCalendar()` and `writeCalendar()`'s ability to open a valid iCalendar file and re-export it identically with the help of `printCalendar()`.
  * 19 valid files are parsed into Calendar objects using `createCalendar()`. They are then re-written to disk in a dedicated exports folder, then a character-by-character comparison of the two files' printing outputs (from `printCalendar()`) is done. Test(s) fail if the resultant files don't match exactly or the initial `createCalendar()` call fails to return `OK`.
* **A2m2harness ([wiki](https://github.com/jnguyen1098/iCalendarStresser/wiki/The-A2-Module-2-Harness))**—calendar object validation stress test; tests `validateCalendar()`'s ability to validate existing Calendar data objects
  * 39 tests for `INV_CAL` (invalid Calendar object)
  * 116 tests for `INV_EVENT` (invalid Event object)
  * 104 tests for `INV_ALARM` (invalid Alarm object)
  * 273 collision tests for simultaneous `INV_CAL` and `INV_EVENT` errors (`INV_CAL` takes precedence)
  * 208 collision tests for simultaneous `INV_CAL` and `INV_ALARM` errors (`INV_CAL` takes precedence)
  * 336 collision tests for simultaneous `INV_EVENT` and `ENV_ALARM` errors (`INV_EVENT` takes precedence)
  * 4368 collision tests for simultaneous `INV_CAL`, `INV_EVENT`, and `INV_ALARM` errors (`INV_CAL` takes precedence)
  * 39 tests for `OK` (valid Calendar object)
* **A2m2harnessv ([wiki](https://github.com/jnguyen1098/iCalendarStresser/wiki/The-A2-Module-2-Vulnerability-Harness))**—`validateCalendar()`—calendar object error priority vulnerability test
  * 1 test for cross-event error collision between `INV_EVENT` and `INV_ALARM` (`INV_EVENT` takes precedence)
  
## Screenshots

### A1harness (`createCalendar()`)
![A screenshot of the first harness](https://i.imgur.com/sj1OuLf.png)

### A2m1harness (`createCalendar()`, `writeCalendar()`, `printCalendar()`)
![A screenshot of the second harness](https://i.imgur.com/y4lV5jS.png)

### A2m2harness (`validateCalendar()`)
![A screenshot of the third harness](https://i.imgur.com/PU1O8pU.png)

### A2m2harnessv (`validateCalendar()`)
![A screenshot of the fourth harness](https://i.imgur.com/vXmXvaZ.png)
