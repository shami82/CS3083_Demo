from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
import config

app = Flask(__name__)
app.config.from_object(config)

mysql = MySQL(app)

# home page: w/ all students and info
@app.route('/')
def index():
    cur = mysql.connection.cursor()
    query = """
    SELECT s.s_id, s.s_first, s.s_last, f.f_last
    FROM student s
    LEFT JOIN faculty f ON s.f_id = f.f_id
    """
    cur.execute(query)
    students = cur.fetchall()
    cur.close()
    return render_template('index.html', students=students)

# add new student
@app.route('/add_student', methods=['GET', 'POST'])
def add_student():
    if request.method == 'POST':
        s_first = request.form['s_first']
        s_last = request.form['s_last']
        s_mi = request.form['s_mi']
        s_add = request.form['s_add']
        s_city = request.form['s_city']
        s_state = request.form['s_state']
        s_zip = request.form['s_zip']
        s_phone = request.form['s_phone']
        s_class = request.form['s_class']
        s_dob = request.form['s_dob']
        s_pin = request.form['s_pin']
        f_id = request.form['f_id']

        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO student 
            (s_first, s_last, s_mi, s_add, s_city, s_state, s_zip, s_phone, s_class, s_dob, s_pin, f_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (s_first, s_last, s_mi, s_add, s_city, s_state, s_zip, s_phone, s_class, s_dob, s_pin, f_id))
        mysql.connection.commit()
        cur.close()
        return redirect('/')
    return render_template('add_student.html')

# view and manage courses - student specific
@app.route('/student/<int:student_id>/courses', methods=['GET', 'POST'])
def manage_courses(student_id):
    cur = mysql.connection.cursor()

    cur.execute("SELECT s_first, s_last FROM student WHERE s_id = %s", (student_id,))
    student = cur.fetchone()

    cur.execute("""
        SELECT cs.c_sec_id, c.course_name, t.term_desc 
        FROM enrollment e
        JOIN course_section cs ON e.c_sec_id = cs.c_sec_id
        JOIN course c ON cs.course_id = c.course_id
        JOIN term t ON cs.term_id = t.term_id
        WHERE e.s_id = %s
    """, (student_id,))
    enrolled = cur.fetchall()

    cur.execute("""
        SELECT cs.c_sec_id, c.course_name, t.term_desc 
        FROM course_section cs
        JOIN course c ON cs.course_id = c.course_id
        JOIN term t ON cs.term_id = t.term_id
        WHERE cs.c_sec_id NOT IN (
            SELECT c_sec_id FROM enrollment WHERE s_id = %s
        )
    """, (student_id,))
    not_enrolled = cur.fetchall()

    cur.close()
    return render_template('manage_courses.html', student=student, student_id=student_id, enrolled=enrolled, not_enrolled=not_enrolled)

# enroll student in course
@app.route('/student/<int:student_id>/enroll/<int:c_sec_id>', methods=['POST'])
def enroll_course(student_id, c_sec_id):
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO enrollment (s_id, c_sec_id, grade) VALUES (%s, %s, NULL)", (student_id, c_sec_id))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('manage_courses', student_id=student_id))

# drop a course - student specific
@app.route('/student/<int:student_id>/drop/<int:c_sec_id>', methods=['POST'])
def drop_course(student_id, c_sec_id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM enrollment WHERE s_id = %s AND c_sec_id = %s", (student_id, c_sec_id))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('manage_courses', student_id=student_id))


if __name__ == '__main__':
    app.run(debug=True)
