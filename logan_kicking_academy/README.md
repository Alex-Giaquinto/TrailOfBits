# Logan Kicking Academy Website

A modern, sporty, and athletic website for Logan Kicking Academy featuring group training, 1-on-1 coaching, and recruiting guidance services.

## Features

- **Responsive Design**: Mobile-first approach that works on all devices
- **Hero Section**: Eye-catching landing area with logo and call-to-action
- **Services Section**: Showcases group training, 1-on-1 training, and recruiting services
- **Testimonials Carousel**: Rotating testimonials from athletes with images
- **Partners Section**: Displays partner logos
- **Contact Form**: Easy booking form for lessons
- **Social Media Integration**: Links to Instagram, TikTok, and Twitter

## File Structure

```
logan_kicking_academy/
├── index.html              # Main HTML file
├── css/
│   └── style.css          # All styling
├── js/
│   └── main.js            # JavaScript for interactivity
├── images/
│   ├── logo.jpeg          # Main logo
│   ├── testimonials/      # Testimonial images
│   └── partners/          # Partner logos
└── README.md              # This file
```

## Setup Instructions

### Local Development

1. Simply open `index.html` in a web browser, or use a local server:
   ```bash
   # Using Python
   python3 -m http.server 8000
   
   # Using Node.js (if you have http-server installed)
   npx http-server
   ```

2. Navigate to `http://localhost:8000` in your browser

### Form Configuration

The contact form currently uses Formspree as a placeholder. To enable form submissions:

1. Sign up for a free account at [Formspree.io](https://formspree.io/)
2. Create a new form
3. Replace `YOUR_FORMSPREE_ID` in `js/main.js` (line 108) with your actual Formspree form ID

Alternatively, you can:
- Use AWS SES (Simple Email Service) with Lambda
- Use a service like EmailJS
- Set up a backend API endpoint

## Deployment to AWS S3 + CloudFront

### Prerequisites

- AWS Account
- AWS CLI installed and configured
- Domain name (optional, but recommended)

### Step 1: Create S3 Bucket

1. Log into AWS Console
2. Navigate to S3
3. Click "Create bucket"
4. Name your bucket (e.g., `logan-kicking-academy`)
5. **Important**: Uncheck "Block all public access" (or configure bucket policy)
6. Enable "Static website hosting" in bucket properties:
   - Index document: `index.html`
   - Error document: `index.html` (for SPA routing)

### Step 2: Upload Files

```bash
# Install AWS CLI if not already installed
# Configure AWS credentials
aws configure

# Upload all files to S3
aws s3 sync . s3://your-bucket-name --exclude "*.md" --exclude ".git/*" --exclude "*.heic"

# Or use the AWS Console to upload files manually
```

### Step 3: Configure Bucket Policy

Add this bucket policy to allow public read access:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::your-bucket-name/*"
        }
    ]
}
```

### Step 4: Set Up CloudFront Distribution

1. Navigate to CloudFront in AWS Console
2. Click "Create Distribution"
3. Configure:
   - **Origin Domain**: Select your S3 bucket
   - **Origin Path**: Leave blank
   - **Viewer Protocol Policy**: Redirect HTTP to HTTPS
   - **Allowed HTTP Methods**: GET, HEAD, OPTIONS
   - **Default Root Object**: `index.html`
   - **Price Class**: Choose based on your needs (US/Canada/Europe is cheapest)
4. Click "Create Distribution"
5. Wait for deployment (15-20 minutes)

### Step 5: Custom Domain (Optional)

1. In CloudFront distribution settings, add your domain to "Alternate Domain Names (CNAMEs)"
2. Request an SSL certificate in AWS Certificate Manager (ACM)
3. Select the certificate in CloudFront distribution settings
4. Update your DNS records to point to CloudFront distribution

### Step 6: Update Form Endpoint

After deployment, update the form endpoint in `js/main.js` if using Formspree or another service.

## Cost Estimation

**S3 Storage:**
- First 50 TB: $0.023 per GB/month
- For a small website (~50MB): ~$0.001/month

**S3 Requests:**
- GET requests: $0.0004 per 1,000 requests
- For 10,000 page views/month: ~$0.004/month

**CloudFront:**
- Data transfer out: $0.085 per GB (first 10 TB)
- For 10GB/month: ~$0.85/month
- Requests: $0.0075 per 10,000 HTTPS requests
- For 10,000 requests: ~$0.0075/month

**Total Estimated Cost: ~$1-2/month** for low to moderate traffic

## Maintenance

- Update content by editing HTML files and re-uploading to S3
- Test locally before deploying
- Monitor CloudFront cache hit ratio for performance
- Set up CloudWatch alarms for unexpected traffic spikes

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Customization

### Colors

Edit CSS variables in `css/style.css`:

```css
:root {
    --primary-color: #1a1a1a;
    --secondary-color: #2d5016;
    --accent-color: #4a7c2a;
    /* ... */
}
```

### Content

- Update text in `index.html`
- Replace images in `images/` folders
- Modify testimonials in the HTML

## Support

For questions or issues, contact: logankickingacademy@gmail.com

## License

All rights reserved. Logan Kicking Academy © 2024

