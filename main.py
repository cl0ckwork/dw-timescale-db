from lib.db import conn

if __name__ == '__main__':

    cur = conn.cursor()

    # Query the database and obtain data as Python objects.
    cur.execute('SELECT * from pg_extension;')
    results = cur.fetchall()
    for result in results:
        print(result)

    # Close communication with the database.
    cur.close()
    conn.close()
