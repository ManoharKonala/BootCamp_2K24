'''import tkinter as tk
import mysql.connector  # type:ignore

connection = mysql.connector.connect(host='localhost',
    user='root',
    password='manohar@2006',
    database='summer_project')

if connection.is_connected():
    print("connected")

cursor = connection.cursor()

def toggled():
    # Function for the remember me checkbutton
    print("Remembered for Next time.")

def user_info():
    cursor.execute("select username,password from user;")
    users = cursor.fetchall()
    return users

def checkInput():
    entered_usernm = username_entry.get()
    entered_pswrd = password_entry.get()

    users = user_info()

    for username, password in users:
        if username == entered_usernm and password == entered_pswrd:
            print("Login Successful")
            root.destroy()
            return

    print("Login failed: Invalid username or password.")    

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


import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
import mysql.connector #type:ignore

# Database connection to python ra
connection = mysql.connector.connect(
    host='localhost',
    user='root',
    password='manohar@2006',
    database='summer_project'
)

login_in_store = None

if connection.is_connected():
    print("connected")

cursor = connection.cursor()

def restaurant_info():
    cursor.execute("SELECT * FROM restaurant")
    return cursor.fetchall()

def user_info():
    cursor.execute("SELECT * FROM user")
    return cursor.fetchall()

def users_info():
    cursor.execute("select user_id,username,password from user;")
    users = cursor.fetchall()
    return users

def order_history(user_id):
   cursor.execute('''SELECT 
 o.order_id,
 r.name AS restaurant_name,
  GROUP_CONCAT(fi.food_name) AS food_items,
  GROUP_CONCAT(rfp.price) AS food_prices,
  o.order_date,
  SUM(rfp.price) AS total_amount,
  o.status
FROM 
  Orders o
  JOIN Restaurant r ON o.restaurant_id = r.restaurant_id
  JOIN Restaurant_Food_Price rfp ON o.restaurant_id = rfp.restaurant_id
  JOIN Food_Item fi ON rfp.food_id = fi.food_id
GROUP BY 
  o.order_id
ORDER BY 
  o.order_date DESC;
  
''', (user_id,))
   return cursor.fetchall()

def fetch_menu(restaurant_id):
    query = """
    SELECT fi.food_id, fi.food_name, rfp.price
    FROM Food_Item fi
    JOIN Restaurant_Food_Price rfp ON fi.food_id = rfp.food_id
    WHERE rfp.restaurant_id = %s
    """
    cursor.execute(query, (restaurant_id,))
    return cursor.fetchall()

def toggled():
    print("Remembered for Next time.")

def checkInput():
    entered_usernm = username_entry.get()
    entered_pswrd = password_entry.get()

    users = users_info()

    for i in range(len(users)):
        user_id = users[i][0]
        username = users[i][1]
        password = users[i][2]

        if username == entered_usernm and password == entered_pswrd:
            global login_in_store
            login_in_store = user_id
            print("Login Successful")
            login_window.destroy()
            main_window()
            return

    messagebox.showerror("Login failed", "Invalid username or password.")


def main_window():
    global root
    root = tk.Tk()
    root.title("ZOMATO")

    F1 = tk.Frame(root, bg="#CB202D")
    F1.pack(pady=10, fill="x")

    l = tk.Label(F1, text="Welcome to Zomato", font=("Helvetica", 20), fg="white", bg="#CB202D", bd=0)
    l.pack(fill="x", expand="true", side="left")
    l.config(font=("font", 50))

    desc = tk.Label(root, text="Find the best places to eat, dine-in, and enjoy your meals.", font=5)
    desc.pack(pady=30, fill="x")

    f = tk.Frame(root)
    f.pack(pady=10)

   
    k3 = tk.Button(f, text="Order History", font=14, activeforeground="red", command=order_history_window)
    k3.pack(side="right", padx=20)

    k4 = tk.Button(f, text="Order", font=14, activeforeground="red")
    k4.pack(side="right", padx=20)

    k2 = tk.Button(f, text="Dine-In", font=14, activeforeground="red", command=restaurant_window)
    k2.pack(side="right", padx=20)

    root.mainloop()    


def order_history_window():
    order_history_win = tk.Toplevel(root)
    order_history_win.title("Order History Window")
    order_history_win.geometry("800x600")

    label = tk.Label(order_history_win, text="Order History", font=("Helvetica", 16))
    label.pack(pady=20)

    tree = ttk.Treeview(order_history_win)
    tree.pack(fill="both", expand=True)

    tree['columns'] = ('Order ID', 'Restaurant Name', 'Food Items Ordered', 'Food Prices', 'Order Date', 'Total Amount', 'Status')

    tree.column('#0', width=0, stretch=tk.NO)
    tree.column('Order ID', anchor=tk.W, width=100)
    tree.column('Restaurant Name', anchor=tk.W, width=150)
    tree.column('Food Items Ordered', anchor=tk.W, width=200)
    tree.column('Food Prices', anchor=tk.W, width=200)
    tree.column('Order Date', anchor=tk.W, width=150)
    tree.column('Total Amount', anchor=tk.W, width=100)
    tree.column('Status', anchor=tk.W, width=100)

    tree.heading('#0', text='', anchor=tk.W)
    tree.heading('Order ID', text='Order ID', anchor=tk.W)
    tree.heading('Restaurant Name', text='Restaurant Name', anchor=tk.W)
    tree.heading('Food Items Ordered', text='Food Items Ordered', anchor=tk.W)
    tree.heading('Food Prices', text='Food Prices', anchor=tk.W)
    tree.heading('Order Date', text='Order Date', anchor=tk.W)
    tree.heading('Total Amount', text='Total Amount', anchor=tk.W)
    tree.heading('Status', text='Status', anchor=tk.W)

    if login_in_store is not None:
        orders = order_history(login_in_store)
        if orders:
            for order in orders:
                order_id, restaurant_name, food_items, food_prices, order_date, total_amount, status = order
                tree.insert(parent='', index='end', iid=order_id, text='', values=(order_id, restaurant_name, food_items, food_prices, order_date, total_amount, status))
        else:
            label = tk.Label(order_history_win, text="No orders to display.")
            label.pack(pady=20)
    else:
        label = tk.Label(order_history_win, text="No user logged in.")
        label.pack(pady=20)

    close_button = tk.Button(order_history_win, text="Close", command=order_history_win.destroy)
    close_button.pack(pady=20)
    
def get_food_items(order_id):
    cursor.execute("SELECT fi.food_name, oi.quantity FROM Food_Item fi JOIN Order_Item oi ON fi.food_id = oi.food_id WHERE oi.order_id = %s", (order_id,))
    return cursor.fetchall()

def user_window():
    user_window = tk.Toplevel(root)
    user_window.title("User Window")
    user_window.geometry("600x400")

    label = tk.Label(user_window, text="User Information")
    label.pack(pady=20)

    tree = ttk.Treeview(user_window)
    tree.pack(fill="both", expand=True)

    tree['columns'] = ('User ID', 'Username', 'Email', 'Password')

    tree.column('#0', width=0, stretch=tk.NO)
    tree.column('User ID', anchor=tk.W, width=50)
    tree.column('Username', anchor=tk.W, width=150)
    tree.column('Email', anchor=tk.W, width=150)
    tree.column('Password', anchor=tk.W, width=150)

    tree.heading('#0', text='', anchor=tk.W)
    tree.heading('User ID', text='User ID', anchor=tk.W)
    tree.heading('Username', text='Username', anchor=tk.W)
    tree.heading('Email', text='Email', anchor=tk.W)
    tree.heading('Password', text='Password', anchor=tk.W)

    users = user_info()
    for user in users:
        tree.insert(parent='', index='end', iid=user[0], text='', values=user)

    close_button = tk.Button(user_window, text="Close", command=user_window.destroy)
    close_button.pack(pady=20)

def restaurant_window():
    restaurant_window = tk.Toplevel(root)
    restaurant_window.title("Restaurant Window")
    restaurant_window.geometry("600x400")

    label = tk.Label(restaurant_window, text="Some Fine Restaurants Awaiting you",font= 20)
    label.pack(pady=20)
    
    tree = ttk.Treeview(restaurant_window)
    tree.pack(fill="both", expand=True)

    tree['columns'] = ('Restaurant_ID', 'Name', 'Address', 'Contact', 'Rating')

    tree.column('#0', width=0, stretch=tk.NO)
    tree.column('Restaurant_ID', anchor=tk.W, width=50)
    tree.column('Name', anchor=tk.W, width=150)
    tree.column('Address', anchor=tk.W, width=150)
    tree.column('Contact', anchor=tk.W, width=150)
    tree.column('Rating', anchor=tk.W, width=50)

    tree.heading('#0', text='', anchor=tk.W)
    tree.heading('Restaurant_ID', text='Restaurant_ID', anchor=tk.W)
    tree.heading('Name', text='Name', anchor=tk.W)
    tree.heading('Address', text='Address', anchor=tk.W)
    tree.heading('Contact', text='Contact', anchor=tk.W)
    tree.heading('Rating', text='Rating', anchor=tk.W)

    restaurants = restaurant_info()
    for restaurant in restaurants:
        tree.insert(parent='', index='end', iid=restaurant[0], text='', values=restaurant)
    
    dine_in_button = tk.Button(restaurant_window, text="Dine-In", command=dine_in_window)
    dine_in_button.pack(pady=10)

    back_button = tk.Button(restaurant_window, text="Back", command=restaurant_window.destroy)
    back_button.pack(pady=10)

def dine_in_window():
    dine_in_window = tk.Toplevel(root)
    dine_in_window.title("Dine-In Window")
    dine_in_window.geometry("600x400")

    def show_menu():
        restaurant_id = restaurant_id_entry.get()
        customer_name = customer_name_entry.get()
        customer_contact = customer_contact_entry.get()
        no_of_persons = no_of_persons_entry.get()
        
        menu_frame = tk.Frame(dine_in_window)
        menu_frame.pack(pady=10, fill='both', expand=True)
        
        menu_items = fetch_menu(restaurant_id)
        if menu_items:
            for item in menu_items:
                food_id, food_name, price = item
                label = tk.Label(menu_frame, text=f"Food ID: {food_id}, Food Name: {food_name}, Price: {price}")
                label.pack(anchor='w')
        else:
            label = tk.Label(menu_frame, text="No menu items found.")
            label.pack(anchor='w')
    
    def book_table():
        restaurant_id = restaurant_id_entry.get()
        customer_name = customer_name_entry.get()
        customer_contact = customer_contact_entry.get()
        no_of_persons = no_of_persons_entry.get()

        if restaurant_id and customer_name and customer_contact and no_of_persons:
            messagebox.showinfo("Success", "Table Booked")
            dine_in_window.destroy()
        else:
            messagebox.showwarning("Error", "Please fill in all details")
        

    Restaurant_frame = tk.Frame(dine_in_window)
    Restaurant_frame.pack()

    Name_frame = tk.Frame(dine_in_window)
    Name_frame.pack(pady=10)

    Contact_frame = tk.Frame(dine_in_window)
    Contact_frame.pack()

    Person_frame = tk.Frame(dine_in_window)
    Person_frame.pack(pady=10)

    entry_frame = tk.Frame(dine_in_window)
    entry_frame.pack()

    book_frame = tk.Frame(dine_in_window)
    book_frame.pack(pady=10)
 
    tk.Label(Restaurant_frame, text="Restaurant ID: ").pack(side='left',padx=5)
    restaurant_id_entry = tk.Entry(Restaurant_frame)
    restaurant_id_entry.pack(side='right')

    tk.Label(Name_frame, text="Customer Name: ").pack(side='left',padx=5)
    customer_name_entry = tk.Entry(Name_frame)
    customer_name_entry.pack(side='right')

    tk.Label(Contact_frame, text="Customer Contact: ").pack(side='left')
    customer_contact_entry = tk.Entry(Contact_frame)
    customer_contact_entry.pack(side='right',padx=30)

    tk.Label( Person_frame, text="No Of Persons: ").pack(side='left')
    no_of_persons_entry = tk.Entry( Person_frame)
    no_of_persons_entry.pack(side='right',padx=30)

    select_button = tk.Button(entry_frame, text="View menu of your Restaurant", command=show_menu)
    select_button.pack(side='left')

    book_button = tk.Button(book_frame, text="Book Table", command=book_table)
    book_button.pack(side='left')

login_window = tk.Tk()
login_window.title("Login")
login_window.geometry("400x320")
login_window.maxsize(400, 320)

# Login Label
login_label = tk.Label(login_window, text="Login")
login_label.pack(ipady=10, fill='x')

# Username Entry
username_frame = tk.Frame(login_window)
username_frame.pack()

tk.Label(username_frame, text="Username").pack(side='left', padx=5)
username_entry = tk.Entry(username_frame)
username_entry.pack(side='right')

# Password Entry
password_frame = tk.Frame(login_window)
password_frame.pack()

tk.Label(password_frame, text="Password").pack(side='left', padx=7)
password_entry = tk.Entry(password_frame, show="*")
password_entry.pack(side='right')

# GO Button
go_button = tk.Button(login_window, text="GO!", command=checkInput, width=15)
go_button.pack(pady=5)

# Remember me and Forgot Password
bottom_frame = tk.Frame(login_window)
bottom_frame.pack()

remember_me = tk.Checkbutton(bottom_frame, text="Remember me",  command=toggled)
remember_me.pack(side='left', padx=19)
tk.Label(bottom_frame, text="Forgot password?").pack(side="right", padx=19)

login_window.mainloop()

