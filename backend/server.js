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
    const { receiptDetails, email } = req.body;

    if (!email) {
        console.log('No email address provided');
        return res.status(400).send('Email address is required');
    }

    const mailOptions = {
        from: 'MS_d5uAHz@trial-o65qngkvnp8lwr12.mlsender.net',
        to: email,
        subject: 'Payment Receipt',
        text: `Thank you for your payment. Here are your receipt details: ${receiptDetails}`
    };

    console.log('Sending email to:', email);
    console.log('Email details:', mailOptions);

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.error('Error sending email:', error);
            return res.status(500).send('Error sending email: ' + error.toString());
        }
        console.log('Email sent:', info.response);
        res.status(200).send('Email sent: ' + info.response);
    });
});

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
