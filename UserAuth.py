import sqlite3
import hashlib

conn = sqlite3.connect("userdata.db")
cur = conn.cursor()

cur.execute("""
CREATE TABLE IF NOT EXISTS userdata (
    id INTEGER PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL  
)          
""")

username1, pass1 = "password1", hashlib.sha256("password123".encode()).hexdigest()
username2, pass2 = "password2", hashlib.sha256("password321".encode()).hexdigest()
username3, pass3 = "password3", hashlib.sha256("password213".encode()).hexdigest()
username4, pass4 = "password4", hashlib.sha256("password312".encode()).hexdigest()
cur.execute("INSERT INTO userdata (username, password) VALUES (?, ?)", (username1, pass1))
cur.execute("INSERT INTO userdata (username, password) VALUES (?, ?)", (username2, pass2))
cur.execute("INSERT INTO userdata (username, password) VALUES (?, ?)", (username3, pass3))
cur.execute("INSERT INTO userdata (username, password) VALUES (?, ?)", (username4, pass4))

conn.commit()