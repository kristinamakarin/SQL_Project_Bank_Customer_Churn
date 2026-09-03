/*
⚠️ Database Load Issues (follow if receiving permission denied when running COPY below)
 
NOTE: If you get error:
'could not open file "[your file path]\...csv" for reading: Permission denied.'
 
1. Open pgAdmin
2. In Object Explorer, navigate to the `bank_customer_churn` database
3. Right-click it and select `PSQL Tool` (opens a terminal window)
4. Get the absolute file path of your csv files
   (right-click a CSV file in VS Code and select "Copy Path")
5. Paste the following into `PSQL Tool`, with the CORRECT file path:
 
\copy customer_churn FROM '\csv_file\bank_customer_churn.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
*/

COPY customer_churn
FROM '\csv_file\bank_customer_churn.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');