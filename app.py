from flask import Flask, render_template,request,json,url_for,session,flash
from flask_mysqldb import MySQL
from os import name, urandom
import smtplib
import os
import math
from werkzeug.utils import redirect,secure_filename
from werkzeug.security import generate_password_hash as gen, check_password_hash as check


with open('vars.json','r') as v:
    variable = json.load(v)
    

var = variable["variables"]
db_keeps = variable["sql_conf"]
mail_keeps = variable["smtp"]
log_cred = variable["login"]

app = Flask(__name__)

mysql = MySQL(app)


# MySQL Configuration
app.config['MYSQL_HOST'] = db_keeps["mysql_host"]
app.config['MYSQL_USER'] = db_keeps["mysql_user"]
app.config['MYSQL_PASSWORD'] = db_keeps["mysql_password"]
app.config['MYSQL_DB'] = db_keeps["mysql_db"]
app.config['MYSQL_PORT'] = db_keeps['mysql_port']


app.secret_key = urandom(24)
app.config['UPLOAD_FOLDER'] = var["upload_location"]
#SMTP Configuration
'''app.config['MAIL_SERVER'] = mail_keeps["smtp_server"]
app.config['MAIL_PORT'] = mail_keeps["smtp_port"]
app.config['MAIL_USERNAME'] =  mail_keeps["smtp_user"]
app.config['MAIL_PASSWORD'] =  mail_keeps["smtp_pass"]
app.config['MAIL_USE_SSL'] = True
'''
def sendmail(text):
    fromaddr = mail_keeps["smtp_user"]
    toaddrs  = mail_keeps["smtp_user"]
    msg = text
    username = mail_keeps["smtp_user"]
    password = os.getenv(mail_keeps["smtp_pass"])
    server = smtplib.SMTP('smtp.gmail.com:587')
    server.ehlo()
    server.starttls()
    server.login(username,password)
    server.sendmail(fromaddr, toaddrs, msg)
    server.quit()


@app.route("/")
def home():
    
    """PAGINATION LOGIC
    First: prev = #! next = page +1
    Middle: prev = page -1 next = page +1
    Last: prev = page -1 next = #!
    """
    cur = mysql.connection.cursor()
    q = cur.execute("SELECT * FROM posts;")
    if q > 0:
        posts = cur.fetchall()
        last = math.ceil(len(posts)/int(var["num_posts"]))
        page = request.args.get('page')
        if (not str(page).isnumeric()):
            page = 1
        page = int(page)
        posts = posts[(page-1)*int(var["num_posts"]) : (page-1)*int(var["num_posts"]) + int(var["num_posts"])]

        if page==1:
            prev = "#!"
            next = "/?page=" + str(page+1)
        elif(page==last):
            next = "#!"
            prev = "/?page=" + str(page-1)
        else:
            next = "/?page=" + str(page+1)
            prev = "/?page=" + str(page-1)

        return render_template('index.html',var=var, posts=posts,prev=prev,next=next)
    else:
        return render_template('index.html',var=var, posts=None)


@app.route("/user/register",  methods=['GET','POST'])
def reg_user():
    if request.method=='POST':
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM user;")
        q = cur.fetchall()
        emails = q
        unames = q
        name = request.form.get('name')
        uname = request.form.get('uname')
        email = request.form.get('email')
        passwd = gen(request.form.get('pass'))
        for i in range(len(emails)):
            if email == emails[i][2]:
                flash('Account already Exists, Please Login',"danger")
                return redirect('/user/login')
        for i in range(len(unames)):
            if uname == unames[i][-1]:
                flash('Oops! Username already Exists, Choose Different One',"info")
                return redirect('#')
        cur.execute("INSERT INTO user (name,email,uname,password) VALUES (%s,%s,%s,%s);",(name,email,uname,passwd))
        flash('Account Created Successfully','success')
        return redirect('/user/login')
    return render_template('register_user.html',var=var)


@app.route("/user/login", methods=['GET','POST'])
def user_login():
    if request.method == 'POST':
        form = request.form
        uname = form['uname']
        password = form['pass']
        cur = mysql.connection.cursor()
        usercheck = cur.execute("SELECT * FROM user WHERE uname=%s;", (uname,))
        if usercheck > 0:
            user = cur.fetchone()
            checker = check(user[-2], password)
            if checker:
                session['logged_in'] = True
                session['user_1'] = uname
                session['id'] = user[0]
                flash(f"Welcome {session['user_1']}!! Your Login is Successful", 'success')
            else:
                cur.close()
                flash('Wrong Password!! Please Check Again.', 'danger')
                return render_template('user_login.html')
        else:
            cur.close()
            flash('User Does Not Exist!! Please Enter Valid Username.', 'danger')
            return render_template('user_login.html')
        cur.close()
        return redirect('/')
    return render_template("user_login.html")


@app.route("/dashboard", methods=['GET','POST'])
def login():

    if ('user' in session and session['user']==log_cred["user"]):
        cur = mysql.connection.cursor()
        q = cur.execute("SELECT * FROM posts ;")
        if q > 0:
            posts = cur.fetchall()
        return render_template('dashboard.html',var=var, posts=posts)

    elif request.method=='POST':
        uname = request.form.get('uname')
        password = request.form.get('pass')
        if (uname == log_cred["user"] and password == log_cred["passwd"]):
            session['user'] = uname
            flash('You were successfully logged in')
            cur = mysql.connection.cursor()
            q = cur.execute("SELECT * FROM posts ;")
            if q > 0:
                posts = cur.fetchall()
                return render_template('dashboard.html',var=var, posts=posts)
        else :
            flash('Wrong Crendialts Try Again',"danger")
            return redirect('/dashboard')
        
    return render_template('admin_login.html',var=var)

@app.route("/edit/<int:id>", methods=['GET','POST'])
def edit(id):
    if ('user' in session and session['user']==log_cred["user"]):
        if request.method=='POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            
            if id == 0:
                author_name = 'Admin'
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO posts(title,subtitle,content,author,img_file) VALUES(%s, %s, %s, %s,%s);", (box_title, tline,content,author_name,img_file))
                mysql.connection.commit()
                cur.close()
                flash('File was Added Successfully','success')
                return redirect('/dashboard')
            else:
                box_title = box_title
                tline = tline
                content = content
                img_file = img_file
                cur = mysql.connection.cursor()
                cur.execute("UPDATE posts SET title=%s,subtitle=%s,content=%s,img_file=%s WHERE id = {};".format(id),(box_title,tline,content,img_file)) 
                mysql.connection.commit()
                cur.close()
                flash('File was Updated Successfully','success')
                return redirect('/edit/'+str(id))
        
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM posts WHERE id = {};".format(id))
        post=cur.fetchone()

        return render_template('edit.html',var=var,post=post,id=id)
        
    return render_template('admin_login.html',var=var)


@app.route("/delete/<int:id>", methods=['GET','POST'])
def delete(id):
    if ('user' in session and session['user']==log_cred["user"]):
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM posts WHERE id = {};".format(id))
        mysql.connection.commit()
        cur.close()
        flash('Post was Deleted Successfully','danger')
    return redirect('/dashboard')
            


@app.route("/upload", methods=['GET','POST'])
def uploader():

    if ('user' in session and session['user']==log_cred["user"]):
        if request.method=='POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename) ))
            flash('File Uploaded Successfully','success')
        return redirect('/dashboard')

@app.route("/about")
def about():
    if ('user_1' in session):
        return render_template('about.html',var=var)
    return redirect('/user/login')


@app.route("/contact",methods=['GET','POST'])
def contact():
    if request.method=='POST':
        ''' Adding entry to db'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO contacts(name, email, phone,msg) VALUES(%s, %s, %s, %s);", (name, email,phone,message))
        mysql.connection.commit()
        cur.close()
        #text="""New Message From:%s \n Email:%s \n Content: %s \n Phone: %s"""%(name,",".join(email),message,phone)
        #sendmail(text)
        flash('Mail was Sent Successfully','success')
        #return redirect('/')
    return render_template('contact.html',var=var)


@app.route("/post/<int:id>",methods=['GET'])
def post_route(id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM posts WHERE id = {};".format(id))
    post=cur.fetchone()

    return render_template('post.html',var=var,post=post)


@app.route("/logout")
def logout():
    session.pop('user')
    flash('User Logged Out','success')
    return redirect('/')

@app.route("/log-out")
def log_out():
    session['logged_in'] == False
    session.pop('user_1',None)
    flash('User Logged Out','success')
    
    return redirect('/')

if __name__ == "__main__":
    app.run()