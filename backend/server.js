const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const nodemailer = require('nodemailer');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const transporter = nodemailer.createTransport({
    host: 'smtp.mailersend.net',
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
        user: 'MS_d5uAHz@trial-o65qngkvnp8lwr12.mlsender.net',
        pass: 'k7qteTNdiphGmg1f'
    }
});

app.get('/', (req, res) => {
    res.send('Server is running');
});

app.post('/send-receipt', (req, res) => {
    const { receiptDetails } = req.body;

    const mailOptions = {
        from: 'MS_d5uAHz@trial-o65qngkvnp8lwr12.mlsender.net',
        to: 'youssef.ezzat@graduate.utm.my',
        subject: 'Payment Receipt',
        text: `Thank you for your payment. Here are your receipt details: ${receiptDetails}`
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.error(error);
            return res.status(500).send(error.toString());
        }
        res.status(200).send('Email sent: ' + info.response);
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
