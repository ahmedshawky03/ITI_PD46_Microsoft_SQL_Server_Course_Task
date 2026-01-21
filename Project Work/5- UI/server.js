const express = require('express');
const sql = require('mssql');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Database Configuration
const dbConfig = {
    user: 'sa',              
    password: 'abdelrahim5',  // Ensure this is your SQL Server authentication password
    server: '127.0.0.1',      // Using IP is often more reliable than 'localhost'
    database: 'ITI_EXAMS',
    port: 1433,               // Connect directly to the port we set in Step 1
    options: {
        encrypt: true,
        trustServerCertificate: true
    }
};

// Connect to the database once when the server starts
const poolPromise = new sql.ConnectionPool(dbConfig)
    .connect()
    .then(pool => {
        console.log('Connected to SQL Server');
        return pool;
    })
    .catch(err => console.log('Database Connection Failed! Bad Config: ', err));

// API 1: Generate Exam
app.post('/api/generate', async (req, res) => {
    try {
        const pool = await poolPromise;
        const { studentId, courseId, mcqCount, tfCount } = req.body;

        // 1. Call Procedure: Generate the Exam (Creates Exam + Returns Questions)
        const genReq = pool.request()
            .input('exam_name', sql.VarChar, `Exam-${Date.now()}`)
            .input('duration', sql.Int, 60)
            .input('course_id', sql.Int, courseId)
            .input('num_MCQ', sql.Int, mcqCount)
            .input('num_TF', sql.Int, tfCount);
        
        const genResult = await genReq.execute('sp_generateExam');
        
        const rawRows = genResult.recordset;
        if (!rawRows || rawRows.length === 0) {
            return res.status(500).json({ error: "Exam generation failed: No questions returned." });
        }

        // Extract the Exam_ID (Assuming sp_generateExam returns it in the first column as configured previously)
        const examId = rawRows[0].Exam_Id; 

        // 2. Call Procedure: Get Next Attempt ID
        const idReq = pool.request();
        const idResult = await idReq.execute('sp_getNextAttemptID');
        const newAttemptId = idResult.recordset[0].NewId;

        // 3. Call Procedure: Insert the Exam Attempt
        // We use the existing sp_insertExamAttempt from your SQL script
        const insertReq = pool.request()
            .input('attempt_id', sql.Int, newAttemptId)
            .input('total_score', sql.Int, null) // Null initially
            .input('student_id', sql.Int, studentId)
            .input('exam_id', sql.Int, examId);
            
        await insertReq.execute('sp_insertExamAttempt');

        // 4. Format Data for Frontend
        const formattedQuestions = rawRows.map(row => ({
            id: row.Question_id,
            text: row.Question_Text,
            choices: [
                { id: row.Choice1_id, text: row.Choice1 },
                { id: row.Choice2_id, text: row.Choice2 },
                { id: row.Choice3_id, text: row.Choice3 },
                { id: row.Choice4_id, text: row.Choice4 }
            ].filter(c => c.id !== null)
        }));

        res.json({
            examId: examId,
            attemptId: newAttemptId,
            questions: formattedQuestions
        });

    } catch (err) {
        console.error("Error in /api/generate:", err);
        res.status(500).send(err.message);
    }
});

// API 2: Submit Answers
app.post('/api/submit', async (req, res) => {
    try {
        const pool = await poolPromise;
        const { attemptId, answers } = req.body;

        // 1. Prepare Table-Valued Parameter (TVP)
        const tvp = new sql.Table('StudentAnswerListType'); 
        tvp.columns.add('Question_id', sql.Int);
        tvp.columns.add('Choice_id', sql.Int);

        answers.forEach(ans => {
            tvp.rows.add(ans.questionId, ans.choiceId);
        });

        // 2. Call Procedure: submitAnswers
        const submitReq = pool.request()
            .input('Attempt_id', sql.Int, attemptId)
            .input('StudentAnswers', tvp);

        await submitReq.execute('submitAnswers');

        // 3. Call Procedure: Evaluate Score
        const gradeReq = pool.request()
            .input('attempt_id', sql.Int, attemptId);
            
        const gradeResult = await gradeReq.execute('sp_evaluateExamScore');
        
        // Return the score
        const score = gradeResult.recordset[0]['Final Score'];
        res.json({ success: true, score: score });

    } catch (err) {
        console.error("Error in /api/submit:", err);
        res.status(500).send(err.message);
    }
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));