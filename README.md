Components
==========

1. Database: MySQL database that stores statistics.
2. Collector: Hidden PHP script on the webserver, where stats get sent.
3. Driver: A Python script for submitting benchmark results
4. Processor: Python aggregator that builds JSON data from the DB.
5. Website: Static HTML as the frontpage, that queries JSON via XHR.

Components (2), (3), and (5) must be on the same webserver, otherwise timestamps might not be computed correctly.

Installation
============

Database
--------
1. Create a database and import/run `database/schema.sql`.
2. Database credentials are configured at the top of website/internals.php and in server/awfy-server.config
3. Manually insert rows in awfy_vendor for each product that will be tested
4. Manually insert rows in awfy_mode for each way a product will be tested.
5. If using additional machines, create a row for each machine in awfy_machines and record the auto_increment ID that was generated.


Data Collector
--------------
Drop `website/submit.php` and `website/internals.php` somewhere, and rename `submit.php` to something secret. Make sure you don't have directory listings enabled. Edit the top of internals.php to configure the database username and password.

Benchmark Computers
-------------------

1. Clone the AWFY repo 
2. Edit ```awfy.config.sample``` to match the ID of the machine generated above and the URL where submit.php is installed. The database already gives ID 1 to the server machine
3. See ```submitter_example.py``` on how to submit benchmark data to AWFY.
   
Data Processor
--------------
Edit `awfy-server.config` to point at your database and website/data folder. Then put `update.py` in a cronjob. It will dump files where appropriate. It is not safe to run two instance at once. A sample wrapper script is provided as `run-update.sh`.

update.py generates various JSON files:

1. "raw" and "metadata" files cache database queries from run to run, so we don't have to make expensive database queries.
2. "aggregate" files are used for the front page.
3. "condensed" files are used for one level of zooming, so users don't have to download the raw data set right away.
   
The metadata and raw JSON files are updated as needed. The aggregate and condensed files are always re-generated from the raw data.

Website
-------
Nothing special needed, just place the static files somewhere. Don't forget to replace the default machine number in website/awfy.js, which is the one that will show up in the first place. Note that AWFY's flot is slightly modified, so it might not work to just replace it with upstream flot. There must be a 'data' folder that contains the json/js files dumped by `update.py`. It can be a symlink.
