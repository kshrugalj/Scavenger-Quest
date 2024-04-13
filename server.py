import sqlite3
import hashlib
import socket
import threading 

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(("localhost", 9999))


server.listen()

def handle_connection(c):
    c.send("Username: ".encode())
    username = c.recv(1024).decode()
    c.send("Password: ".encode())
    password = c.recv(1024).decode()
    psasword = hashlib.sha256(password).hexdigest()
    

    conn = sqlite3.connect("userdata.db")
    cur = conn.cursor()
    
    cur.execute("SELECT * FROM userdata WHERE username = ? AND password = ?", (username, password))
    
    if cur.fetchone():
        c.send("Welcome to the server".encode())
        # can have secret information here
        # can have service information
    else:
        c.semd("Login Failed!".encode())
        
while True:
    client, addr = server.accept()
    threading.Thread(target=handle_connection, args=(client,)).start()