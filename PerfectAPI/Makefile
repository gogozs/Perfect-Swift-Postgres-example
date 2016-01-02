NAME=simpleAPI
SWIFTC=swiftc

DIR_API=/var/www/html/api
DIR_MUSTACHE=simpleapi

all: init compileLib compileExamples compile

init:
	sudo apt-get install libssl-dev libevent-dev libpq-dev libmysqlclient-dev
	sudo apt-get install apache2

compilePerfectLib:
	cd PerfectLib/ && make && sudo cp -f PerfectLib.so /usr/local/lib/ && sudo cp -f PerfectLib.swiftmodule /usr/local/lib/ && sudo cp -f PerfectLib.swiftdoc /usr/local/lib/  && make clean && cd ..

compilePostgreSQL:
	cd Connectors/PostgreSQL && make && sudo cp -f PostgreSQL.so /usr/local/lib/ && sudo cp -f PostgreSQL.swiftmodule /usr/local/lib && cd ../..

compileExamples:
	cd Examples/ && make && sudo mkdir -p $(DIR_API)/PerfectLibraries && sudo ln -s -f `pwd`/URL\ Routing/URLRouting.so $(DIR_API)/PerfectLibraries && sudo ln -s -f `pwd`/Authenticator/AuthenticatorServer.so $(DIR_API)/PerfectLibraries && sudo ln -s -f `pwd`/Upload\ Enumerator/UploadEnumerator.so $(DIR_API)/PerfectLibraries && sudo ln -s -f `pwd`/Tap\ Tracker/TapTrackerServer.so $(DIR_API)/PerfectLibraries
	sudo mkdir -p $(DIR_API)/$(DIR_MUSTACHE)/authenticator
	sudo mkdir -p $(DIR_API)/$(DIR_MUSTACHE)/taptracker
	sudo mkdir -p $(DIR_API)/$(DIR_MUSTACHE)/uploadfile
	sudo cp -f Examples/Authenticator/Authenticator/*.mustache $(DIR_API)/$(DIR_MUSTACHE)/authenticator/
	sudo cp -f Examples/Upload\ Enumerator/Upload\ Enumerator/*.mustache $(DIR_API)/$(DIR_MUSTACHE)/uploadfile/
	sudo cp -f Examples/Tap\ Tracker/*.mustache $(DIR_API)/$(DIR_MUSTACHE)/taptracker/
	cd $(DIR_API) && sudo ./perfectserverfcgi.sh restart
	sudo /etc/init.d/apache2 restart

restart:
	cd $(DIR_API) && sudo ./perfectserverfcgi.sh restart
	sudo /etc/init.d/apache2 restart

compileLib: compilePerfectLib
	cd PerfectServer && make clean && make && sudo cp -f perfectserverfcgi /usr/local/bin/ && cd ..
	cd Connectors/mod_perfect && make clean && make && sudo mv mod_perfect.so /usr/lib/apache2/modules/ && sudo chown root:root /usr/lib/apache2/modules/mod_perfect.so && sudo chmod 644 /usr/lib/apache2/modules/mod_perfect.so && cd ../..
	sudo cp -f perfect.load /etc/apache2/mods-available/
	sudo a2enmod perfect
	sudo a2enmod rewrite
	sudo cp -f ./perfectserverfcgi.sh $(DIR_API)/ && cd $(DIR_API)/ && sudo chmod 777 ./perfectserverfcgi.sh && sudo ./perfectserverfcgi.sh start
	sudo /etc/init.d/apache2 restart

compile: compilePostgreSQL prepareCompileAPI compileAPI

prepareCompileAPI:
	echo `pwd`
	cp ./Connectors/PostgreSQL/PostgreSQL.o ./PerfectAPI/

compileAPI:
	cd ./PerfectAPI/ && make && sudo ln -s -f `pwd`/PerfectAPI.so $(DIR_API)/PerfectLibraries && cd ..
	cd $(DIR_API) && sudo ./perfectserverfcgi.sh restart
	sudo /etc/init.d/apache2 restart

stop:
	sudo /etc/init.d/apache2 stop
	cd $(DIR_API) && sudo ./perfectserverfcgi.sh stop
