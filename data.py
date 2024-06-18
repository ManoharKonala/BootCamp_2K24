'''from tkinter import *

def checkInput():
    # Check if username and password match
    usernm = "Username301"
    pswrd = "Passw0rd"
    entered_usernm = username_entry.get()
    entered_pswrd = password_entry.get()

    if usernm == entered_usernm and pswrd == entered_pswrd:
        print("Login Successful")
        root.destroy()
    else:
        print("Login failed: Invalid username or password.")

def toggled():
    # Function for the remember me checkbutton
    print("Remembered for Next time.")

root = Tk()
root.title("Login")
root.geometry("400x320")
root.maxsize(400, 320)

# Login Label
login_label = Label(root, text="Login")
login_label.pack(ipady=10,fill='x')



# Username Entry
username_frame = Frame(root)
username_frame.pack()

Label(username_frame, text="Username").pack(side='left', padx=5)
username_entry = Entry(username_frame)
username_entry.pack(side='right')

# Password Entry
password_frame = Frame(root)
password_frame.pack()

Label(password_frame, text="Password").pack(side='left', padx=7)
password_entry = Entry(password_frame, show="*")
# The show="*" option is used to display asterisks instead of the actual characters entered, 
# enhancing security
password_entry.pack(side='right')

# GO Button
go_button = Button(root, text="GO!", command=checkInput, width=15)
# The command=checkInput parameter specifies that when the button is clicked, 
# the checkInput function will be called.
go_button.pack(pady=5)

# Remember me and Forgot Password
bottom_frame = Frame(root)
bottom_frame.pack()

remember_me = Checkbutton(bottom_frame, text="Remember me",  command=toggled)
remember_me.pack(side='left', padx=19)
Label(bottom_frame, text="Forgot password?").pack(side="right", padx=19)

root.mainloop()

import tkinter as tk
from tkinter import Toplevel

def open_login_window():
    login_window = Toplevel(root)
    login_window.title("Login")

    tk.Label(login_window, text="Login").pack(pady=10)

    tk.Label(login_window, text="Username").pack()
    username_entry = tk.Entry(login_window)
    username_entry.pack()

    tk.Label(login_window, text="Password").pack()
    password_entry = tk.Entry(login_window, show="*")
    password_entry.pack()

    tk.Button(login_window, text="Login", command=lambda: check_login(username_entry.get(), password_entry.get(), login_window)).pack(pady=10)

def open_signup_window():
    signup_window = Toplevel(root)
    signup_window.title("Sign Up")

    tk.Label(signup_window, text="Sign Up").pack(pady=10)

    tk.Label(signup_window, text="Username").pack()
    username_entry = tk.Entry(signup_window)
    username_entry.pack()

    tk.Label(signup_window, text="Password").pack()
    password_entry = tk.Entry(signup_window, show="*")
    password_entry.pack()

    tk.Label(signup_window, text="Confirm Password").pack()
    confirm_password_entry = tk.Entry(signup_window, show="*")
    confirm_password_entry.pack()

    tk.Button(signup_window, text="Sign Up", command=lambda: sign_up(username_entry.get(), password_entry.get(), confirm_password_entry.get(), signup_window)).pack(pady=10)

def check_login(username, password, window):
    if username == "Username301" and password == "Passw0rd":
        print("Login successful!")
        window.destroy()
    else:
        print("Login failed: Invalid username or password.")

def sign_up(username, password, confirm_password, window):
    if password == confirm_password:
        print("Sign up successful!")
        window.destroy()
    else:
        print("Passwords do not match!")

root = tk.Tk()
root.title("Main Application")

tk.Button(root, text="Login", command=open_login_window).pack(pady=10)
tk.Button(root, text="Sign Up", command=open_signup_window).pack(pady=10)

root.mainloop()'''

'''import tkinter as tk
from tkinter import messagebox

class LoginSignupApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Login / Sign Up")
        self.geometry("400x320")
        self.maxsize(400, 320)

        self.current_frame = None
        self.login_frame = LoginFrame(self)
        self.signup_frame = SignupFrame(self)

        self.show_login_frame()

    def show_login_frame(self):
        if self.current_frame:
            self.current_frame.pack_forget()
        self.login_frame.pack(fill="both", expand=True)
        self.current_frame = self.login_frame

    def show_signup_frame(self):
        if self.current_frame:
            self.current_frame.pack_forget()
        self.signup_frame.pack(fill="both", expand=True)
        self.current_frame = self.signup_frame

class LoginFrame(tk.Frame):
    def __init__(self, master):
        super().__init__(master)
        self.master = master

        tk.Label(self, text="Login").pack(pady=10)
        tk.Label(self, text="Username").pack()
        self.username_entry = tk.Entry(self)
        self.username_entry.pack()
        tk.Label(self, text="Password").pack()
        self.password_entry = tk.Entry(self, show="*")
        self.password_entry.pack()
        tk.Button(self, text="Login", command=self.check_login).pack(pady=10)
        tk.Button(self, text="Switch to Sign Up", command=self.master.show_signup_frame).pack()

    def check_login(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        # Replace with your actual login logic
        if username == "Username301" and password == "Passw0rd":
            messagebox.showinfo("Login", "Login Successful")
            self.master.destroy()
        else:
            messagebox.showerror("Login Failed", "Invalid username or password")

class SignupFrame(tk.Frame):
    def __init__(self, master):
        super().__init__(master)
        self.master = master

        tk.Label(self, text="Sign Up").pack(pady=10)
        tk.Label(self, text="Username").pack()
        self.username_entry = tk.Entry(self)
        self.username_entry.pack()
        tk.Label(self, text="Password").pack()
        self.password_entry = tk.Entry(self, show="*")
        self.password_entry.pack()
        tk.Label(self, text="Confirm Password").pack()
        self.confirm_password_entry = tk.Entry(self, show="*")
        self.confirm_password_entry.pack()
        tk.Button(self, text="Sign Up", command=self.sign_up).pack(pady=10)
        tk.Button(self, text="Switch to Login", command=self.master.show_login_frame).pack()

    def sign_up(self):
        username = self.username_entry.get()
        password = self.password_entry.get()
        confirm_password = self.confirm_password_entry.get()
        # Replace with your actual sign-up logic
        if password == confirm_password:
            messagebox.showinfo("Sign Up", "Sign Up Successful")
            self.master.show_login_frame()
        else:
            messagebox.showerror("Sign Up Failed", "Passwords do not match")

if __name__ == "__main__":
    app = LoginSignupApp()
    app.mainloop()'''

# import Modules
import tkinter as tk
#from tkinter import ttk
import mysql.connector  # type: ignore

connection = mysql.connector.connect(host='localhost',
    user='root',
    password='manohar@2006',
    database='summer_project')

if connection.is_connected():
    print("connected")

cursor = connection.cursor()

def checkInput():
    # Check if username and password match
    usernm = "Username301"
    pswrd = "Passw0rd"
    entered_usernm = username_entry.get()
    entered_pswrd = password_entry.get()

    if usernm == entered_usernm and pswrd == entered_pswrd:
        print("Login Successful")
        root.destroy()
    else:
        print("Login failed: Invalid username or password.")

def toggled():
    # Function for the remember me checkbutton
    print("Remembered for Next time.")

root = tk.Tk()
root.title("Login")
root.geometry("400x320")
root.maxsize(400, 320)

# Login Label
login_label = tk.Label(root, text="Login")
login_label.pack(ipady=10,fill='x')

# Username Entry
username_frame = tk.Frame(root)
username_frame.pack()

tk.Label(username_frame, text="Username").pack(side='left', padx=5)
username_entry = tk.Entry(username_frame)
username_entry.pack(side='right')

# Password Entry
password_frame = tk.Frame(root)
password_frame.pack()

tk.Label(password_frame, text="Password").pack(side='left', padx=7)
password_entry = tk.Entry(password_frame, show="*")
# The show="*" option is used to display asterisks instead of the actual characters entered, 
# enhancing security
password_entry.pack(side='right')

# GO Button
go_button = tk.Button(root, text="GO!", command=checkInput, width=15)
# The command=checkInput parameter specifies that when the button is clicked, 
# the checkInput function will be called.
go_button.pack(pady=5)

# Remember me and Forgot Password
bottom_frame = tk.Frame(root)
bottom_frame.pack()

remember_me = tk.Checkbutton(bottom_frame, text="Remember me",  command=toggled)
remember_me.pack(side='left', padx=19)
tk.Label(bottom_frame, text="Forgot password?").pack(side="right", padx=19)

def restaurant_info():
    cursor.execute("SELECT * FROM restaurant")
    return cursor.fetchall()

def user_window():
    # Create a new top-level window
    User_window = tk.Toplevel(root)
    User_window.title("User Window")
    User_window.geometry("300x300")

    # Add a label to the new window
    label = tk.Label(User_window, text="Eda Mowne, Happy ille")
    label.pack(pady=20)

    # Add a button to close the new window
    close_button = tk.Button(User_window, text="Close", command=User_window.destroy)
    close_button.pack(pady=20)

def restaurant_window():
    Restaurant_window = tk.Toplevel(root)
    Restaurant_window.title("Restaurant Window")
    Restaurant_window.geometry("300x300")

    # Add a label to the new window
    label = tk.Label(Restaurant_window, text="Restaurants Near You")
    label.pack(pady=20)

    header_labels_frame = tk.Frame(Restaurant_window)
    header_labels_frame.pack()
    
    restaurants = restaurant_info()
    headers = ['ID', 'Name', 'Location', 'Cuisine', 'Rating']

    for header in headers:
        H=tk.Label(header_labels_frame, text=header, font=('Helvetica', 12))
        H.pack(side="left", padx=10)
    
    for restaurant in restaurants:
        restaurant_ki_label = tk.Label(Restaurant_window, text=restaurant)
        restaurant_ki_label.pack(pady=5)
        
root = tk.Tk()
root.title("ZOMATO")
#root.geometry("400x400")
#root.maxsize(400, 400)

F1 = tk.Frame(root,bg="#CB202D")
F1.pack(pady=10,fill="x")

# Welcome label
l = tk.Label(F1, text="Welcome to Zomato", font=("Helvetica",20), fg="white",bg="#CB202D",bd=0)
l.pack( fill="x",expand="true",side ="left")
l.config(font=("font", 50))

   
U = tk.Button(F1,text="YOU", font=10,activeforeground="green",command=user_window)
U.pack(ipady=10,side="right")

# Description label
desc = tk.Label(root, text="Find the best places to eat, dine-in, and enjoy your meals.", font=5)
desc.pack(pady=30, fill="x")

# Frame to hold the side-by-side labels
f = tk.Frame(root)
f.pack(pady=10)


# k1 = tk.Button(f, text="Restaurants", font=14,activeforeground="red", command=restaurant_window)
# k1.pack(side="left",padx=20)

k3 = tk.Button(f, text="Order History", font=14,activeforeground="red")
k3.pack(side="right",padx=20)

k4 = tk.Button(f,text="Order",font=14,activeforeground="red")
k4.pack(side="right",padx=20)

k2 = tk.Button(f,text="Dine-In",font = 14,activeforeground="red",command=restaurant_window)
k2.pack(side = "right",padx=20)

root.mainloop()