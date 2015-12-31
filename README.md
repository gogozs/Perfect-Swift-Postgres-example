# Perfect Swift: Postgres example
This is a simple example for creating backend service with Swift, Postgres and PerfectLib.

## How to use it
This project works only with Xcode (7.2) on OSX (I didn't try to compile it on Linux).

On your OSX, install [Postgres.app](http://postgresapp.com), create a database, an user, and run the sql script "init_database.sql" (or copy it on a pgsql terminal).

After, open the "PerfectAPI.xcodeproj" file with Xcode, edit the PerfectHandler.swift file with the correct host, username, password and name of your database. Now compile the "PerfectAPI" target and run the "PerfectServer HTTP App" target.

You can try with Postman:
* $(host)/ for having the default page
* [GET] $(host)/account/ for having the list of account in the database
* [POST] $(host)/account/ for creating an account

## More Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
