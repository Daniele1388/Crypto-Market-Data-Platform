import os
import pandas as pd
import pyodbc as odbc

#Connection to SQL Server
DRIVER = 'INSERT DRIVER'
SERVER = 'INSERT SERVER'
DATABASE = 'Crypto_DB'

target_table = 'brz.crypto_prices_raw'

conn = odbc.connect(
    f"Driver={{{DRIVER}}};"
    f"Server={SERVER};"
    f"Database={DATABASE};"
    "Trusted_Connection=yes;"
    "Encrypt=no;"
)

print(conn)

# Normalize numeric values in CSV files (remove scientific notation)
def clean_csv(input_file, output_file):
    df = pd.read_csv(input_file)
    df.to_csv(output_file, index=False, float_format="%.17f")

#Define bulk insert function for data injection
def bulk_insert(data_file,target_table):
    sql = f"""
        BULK INSERT {target_table}
        FROM '{data_file}'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        )
    """.strip()
    return sql

#Source folder with raw CSV files
data_file_folder = os.path.join(os.getcwd(), 'Data')

#Target folder with cleaned CSV files
clean_data_folder = os.path.join(os.getcwd(), 'Data_clean')

#Iterate through data files and upload
data_files = os.listdir(data_file_folder) # Get all filenames from the Data folder and store them in a list
print(data_files)

cursor = conn.cursor()
try:
    # Process each CSV file
    for data_file in data_files:
        if data_file.endswith('.csv'):
            full_path = os.path.join(data_file_folder, data_file)

            # Clean the CSV and save the cleaned file
            clean_filename = data_file.replace('.csv', '_clean.csv')
            clean_path = os.path.join(clean_data_folder, clean_filename)
            clean_csv(full_path, clean_path)

             # Load data into the database
            cursor.execute(bulk_insert(clean_path, target_table))
            print(clean_path, target_table + ' inserted')
    # Commit changes and show final count
    print('Committing transaction...')
    conn.commit()
    cursor.execute("SELECT COUNT(*) FROM brz.crypto_prices_raw")
    print(cursor.fetchone()[0])
except Exception as e:
    # In case of error, rollback changes
    print(e)
    conn.rollback()
    print('Transaction rollback') 
finally:
    # Release the database connection
    conn.close()
