# Hair By Gabriela - Professional Hair Styling Website

A beautiful, elegant website for Hair By Gabriela's professional hair styling business. Features a stunning gallery, contact form with SMS notifications, and responsive design.

## Features

- **Elegant Design**: Sophisticated typography and layout with golden accent colors
- **Interactive Gallery**: Filterable photo gallery showcasing hair work
- **Contact Form**: Professional contact form with SMS notifications via Twilio
- **Responsive Design**: Mobile-first approach that works on all devices
- **Smooth Animations**: Beautiful scroll animations and hover effects
- **Professional Services**: Detailed service offerings and pricing information

## Quick Start

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Set up SMS Notifications (Optional)**
   - Copy `env.example` to `.env`
   - Get Twilio credentials from [Twilio Console](https://console.twilio.com/)
   - Fill in your Twilio Account SID, Auth Token, and phone numbers

3. **Start the Server**
   ```bash
   npm start
   ```

4. **View the Website**
   - Open your browser to `http://localhost:3000`

## SMS Configuration (AWS SNS)

To enable SMS notifications when someone submits the contact form:

1. **AWS Account Setup** (if you don't have one):
   - Sign up for [AWS Free Tier](https://aws.amazon.com/free/) (12 months free)
   - You get 100 SMS messages per month for free!

2. **Create IAM User for SMS**:
   - Go to AWS IAM Console
   - Create a new user with programmatic access
   - Attach the `AmazonSNSFullAccess` policy
   - Save the Access Key ID and Secret Access Key

3. **Update Environment Variables**:
   ```bash
   cp env.example .env
   ```
   Then edit `.env` with your AWS credentials:
   ```
   AWS_ACCESS_KEY_ID=your_access_key_id
   AWS_SECRET_ACCESS_KEY=your_secret_access_key
   AWS_REGION=us-east-1
   RECIPIENT_PHONE_NUMBER=+1234567890
   ```

4. **Cost**: SMS via AWS SNS costs about $0.75 per 100 messages (much cheaper than Twilio!)

## Customization

### Contact Information
Update the contact details in `index.html`:
- Phone number
- Email address
- Physical address
- Business hours

### Images
Replace the images in the gallery section with actual photos of Gabriela's work:
- `IMG_4588.jpg` through `IMG_4594.jpg`
- Update the `data-category` attributes for proper filtering

### Colors and Styling
The website uses a golden color scheme. To change colors, update the CSS variables in `styles.css`:
- Primary gold: `#d4af37`
- Light gold: `#f4e4bc`

## File Structure

```
Hair By Gabriela C/
├── index.html          # Main HTML file
├── styles.css          # CSS styles and animations
├── script.js           # JavaScript functionality
├── server.js           # Express.js server
├── package.json        # Node.js dependencies
├── env.example         # Environment variables template
├── README.md           # This file
└── IMG_*.jpg          # Gallery images
```

## Technologies Used

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Backend**: Node.js, Express.js
- **SMS**: AWS SNS (Simple Notification Service)
- **Fonts**: Google Fonts (Playfair Display, Inter)
- **Icons**: Font Awesome

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## License

MIT License - feel free to use this template for your own projects!

---

**Hair By Gabriela** - Professional Hair Styling & Design
