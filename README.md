# Perfect Swift: Postgres example
This is a simple example for creating backend service with Swift, Postgres and PerfectLib.

## How to use it

### OS X
This project works only with Xcode (7.2) on OSX.

On your OSX, install [Postgres.app](http://postgresapp.com), create a database, an user, connect to your database, and run the sql script "init\_database.sql" (or copy it on a pgsql terminal).

After, open the "PerfectAPI.xcodeproj" file with Xcode, edit the PerfectHandler.swift file with the correct host, username, password and name of your database. Now compile the "PerfectAPI" target and run the "PerfectServer HTTP App" target.

### Ubuntu 15.10
It's fun!...

You must install and config swift, Apache2 and Postgres.

Edit the Makfile file on "PerfectAPI/" directory with correct path (DIR\_API).

Edit the PerfectAPI/PerfectAPI/PerfectHandler.swift file with correct info for connecting to your postgres database.

Run psql, create the database, and run the "sql/init\_database.sql" file.

After that:
```
cd PerfectAPI
make
```

### After
You can try with [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop):

- $(host)/ for having the default page
- [GET] $(host)/account/ for having the list of account in the database
- [POST] $(host)/account/ for creating an account

## More Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
