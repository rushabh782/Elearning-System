<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="E_Learning.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>E-Learning Platform - Login</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css" />

    <!-- AdminLTE Theme -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css" />

    <!-- Bootstrap 5 for Modal -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .custom-toast {
            background-color: #dc3545;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            animation: fadeIn 0.5s ease-in-out;
            margin-top: 1rem;
        }

            .custom-toast .btn-close-white {
                background: none;
                border: none;
                color: white;
                font-size: 20px;
                cursor: pointer;
            }

        ustom-toast .btn-close-white {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
        }


        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f4f6f9;
            font-family: 'Source Sans Pro', sans-serif;
            overflow-x: hidden;
        }

        /* Animated Background */
        .animated-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
        }

        @keyframes gradientShift {
            0% {
                background-position: 0% 50%;
            }

            50% {
                background-position: 100% 50%;
            }

            100% {
                background-position: 0% 50%;
            }
        }

        /* Floating Shapes */
        .floating-shapes {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .shape {
            position: absolute;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 20s infinite ease-in-out;
        }

            .shape:nth-child(1) {
                width: 80px;
                height: 80px;
                left: 10%;
                top: 20%;
                animation-delay: 0s;
            }

            .shape:nth-child(2) {
                width: 120px;
                height: 120px;
                right: 15%;
                top: 60%;
                animation-delay: 2s;
            }

            .shape:nth-child(3) {
                width: 60px;
                height: 60px;
                left: 70%;
                top: 80%;
                animation-delay: 4s;
            }

            .shape:nth-child(4) {
                width: 100px;
                height: 100px;
                left: 30%;
                bottom: 10%;
                animation-delay: 1s;
            }

            .shape:nth-child(5) {
                width: 90px;
                height: 90px;
                right: 40%;
                top: 30%;
                animation-delay: 3s;
            }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }

            50% {
                transform: translateY(-30px) rotate(180deg);
            }
        }

        /* Top Navigation Bar */
        .top-nav {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

            .top-nav .container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: #4b545c;
        }

            .logo i {
                color: #007bff;
                margin-right: 8px;
            }

        .nav-links {
            display: flex;
            gap: 30px;
            list-style: none;
        }

            .nav-links a {
                color: #4b545c;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s;
            }

                .nav-links a:hover {
                    color: #007bff;
                }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, rgba(75,84,92,0.95) 0%, rgba(52,58,64,0.95) 100%);
            padding: 80px 20px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

            .hero-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="2" fill="rgba(255,255,255,0.1)"/></svg>');
                opacity: 0.3;
            }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 900px;
            margin: 0 auto;
        }

        .hero-section h1 {
            font-size: 4rem;
            font-weight: 700;
            color: white;
            margin-bottom: 20px;
            animation: fadeInDown 1s ease-in-out;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .hero-section .tagline {
            font-size: 1.5rem;
            color: #e9ecef;
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-in-out;
        }

        .hero-stats {
            display: flex;
            justify-content: center;
            gap: 50px;
            flex-wrap: wrap;
            margin-top: 40px;
        }

        .stat-item {
            background: rgba(255,255,255,0.1);
            padding: 25px 40px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
            animation: fadeIn 1.5s ease-in-out;
        }

            .stat-item:hover {
                background: rgba(255,255,255,0.2);
                transform: translateY(-5px);
            }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #007bff;
            display: block;
        }

        .stat-label {
            color: white;
            font-size: 1rem;
            margin-top: 5px;
        }

        /* Features Grid */
        .features-section {
            background: white;
            padding: 80px 20px;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            color: #4b545c;
            font-weight: 700;
            margin-bottom: 50px;
            position: relative;
        }

            .section-title::after {
                content: '';
                display: block;
                width: 80px;
                height: 4px;
                background: linear-gradient(90deg, #007bff, #28a745);
                margin: 15px auto 0;
                border-radius: 2px;
            }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            padding: 35px;
            border-radius: 15px;
            border: 2px solid #e9ecef;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.4s ease;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

            .feature-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #007bff, #28a745);
                transition: left 0.4s ease;
            }

            .feature-card:hover::before {
                left: 0;
            }

            .feature-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.15);
                border-color: #007bff;
            }

        .feature-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            box-shadow: 0 4px 15px rgba(0,123,255,0.3);
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            transform: rotateY(360deg);
        }

        .feature-card h4 {
            color: #4b545c;
            margin-bottom: 15px;
            font-weight: 600;
            font-size: 1.3rem;
        }

        .feature-card p {
            color: #6c757d;
            line-height: 1.6;
        }

        /* Courses Preview Section */
        .courses-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 80px 20px;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 40px auto 0;
        }

        .course-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            cursor: pointer;
        }

            .course-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            }

        .course-image {
            height: 180px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: white;
            position: relative;
            overflow: hidden;
        }

            .course-image::after {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.3) 0%, transparent 70%);
                animation: shine 3s infinite;
            }

        @keyframes shine {
            0% {
                transform: translate(-50%, -50%);
            }

            100% {
                transform: translate(50%, 50%);
            }
        }

        .course-content {
            padding: 25px;
        }

        .course-title {
            font-size: 1.3rem;
            color: #4b545c;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .course-desc {
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 15px;
        }

        .course-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #e9ecef;
        }

        .course-rating {
            color: #ffc107;
            font-size: 0.9rem;
        }

        .course-students {
            color: #6c757d;
            font-size: 0.9rem;
        }

        /* Testimonials Section */
        .testimonials-section {
            background: white;
            padding: 80px 20px;
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 40px auto 0;
        }

        .testimonial-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            padding: 30px;
            border-radius: 15px;
            border-left: 4px solid #007bff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

            .testimonial-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            }

        .testimonial-text {
            color: #4b545c;
            font-style: italic;
            line-height: 1.8;
            margin-bottom: 20px;
            font-size: 1.05rem;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff, #28a745);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .author-info h5 {
            color: #4b545c;
            font-weight: 600;
            margin: 0;
        }

        .author-info p {
            color: #6c757d;
            font-size: 0.9rem;
            margin: 0;
        }

        /* Stats Section */
        .stats-section {
            background: linear-gradient(135deg, #4b545c 0%, #343a40 100%);
            padding: 60px 20px;
            color: white;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .stat-box {
            padding: 20px;
        }

            .stat-box i {
                font-size: 3rem;
                color: #007bff;
                margin-bottom: 15px;
            }

            .stat-box h3 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .stat-box p {
                color: #e9ecef;
                font-size: 1.1rem;
            }

        /* Login Section */
        .login-section {
            padding: 80px 20px;
            background: linear-gradient(135deg, #e9ecef 0%, #f8f9fa 100%);
        }

        .login-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }

        .login-info {
            padding: 40px;
        }

            .login-info h2 {
                font-size: 2.5rem;
                color: #4b545c;
                font-weight: 700;
                margin-bottom: 20px;
            }

            .login-info p {
                color: #6c757d;
                font-size: 1.1rem;
                line-height: 1.8;
                margin-bottom: 30px;
            }

        .benefit-list {
            list-style: none;
        }

            .benefit-list li {
                color: #4b545c;
                font-size: 1.05rem;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 15px;
            }

                .benefit-list li i {
                    color: #28a745;
                    font-size: 1.3rem;
                }

        .login-box {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            animation: zoomIn 0.8s ease-in-out;
        }

            .login-box .card {
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.15);
                border: none;
                background: white;
            }

            .login-box .card-header {
                background: linear-gradient(135deg, #4b545c 0%, #343a40 100%);
                color: white;
                border-radius: 15px 15px 0 0 !important;
                padding: 30px;
            }

                .login-box .card-header h1 {
                    margin: 0;
                    font-size: 2rem;
                }

            .login-box .card-body {
                padding: 40px;
            }

        .login-box-msg {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .form-control {
            border: 2px solid #e9ecef;
            padding: 12px;
            transition: all 0.3s ease;
        }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.1);
            }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            padding: 14px;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,123,255,0.3);
        }

            .btn-primary:hover {
                background: linear-gradient(135deg, #0056b3 0%, #003d82 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0,123,255,0.4);
            }

        .btn-link {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

            .btn-link:hover {
                color: #0056b3;
            }

        /* Footer */
        .landing-footer {
            background: linear-gradient(135deg, #343a40 0%, #1a1d20 100%);
            color: white;
            padding: 50px 20px 30px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 30px;
        }

        .footer-section h4 {
            color: white;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .footer-section p, .footer-section a {
            color: #adb5bd;
            text-decoration: none;
            line-height: 2;
            transition: color 0.3s;
        }

            .footer-section a:hover {
                color: #007bff;
            }

        .social-icons {
            display: flex;
            gap: 15px;
            margin-top: 15px;
        }

            .social-icons a {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: rgba(255,255,255,0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

                .social-icons a:hover {
                    background: #007bff;
                    transform: translateY(-3px);
                }

        .footer-bottom {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid rgba(255,255,255,0.1);
            color: #adb5bd;
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        }

        .modal-header {
            background: linear-gradient(135deg, #4b545c 0%, #343a40 100%);
            color: white;
            border-radius: 15px 15px 0 0;
            padding: 25px 30px;
        }

            .modal-header .btn-close {
                filter: brightness(0) invert(1);
            }

        .modal-body {
            padding: 30px;
        }

        .modal-footer .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
        }

            .modal-footer .btn-primary:hover {
                background: linear-gradient(135deg, #1e7e34 0%, #155724 100%);
            }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }

            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* Responsive */
        @media (max-width: 992px) {
            .login-wrapper {
                grid-template-columns: 1fr;
            }

            .hero-section h1 {
                font-size: 2.5rem;
            }

            .nav-links {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .hero-stats {
                gap: 20px;
            }

            .stat-item {
                padding: 20px 30px;
            }
        }
    </style>
</head>
<body>
    <!-- Animated Background -->
    <div class="animated-bg"></div>
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <!-- Top Navigation -->
    <nav class="top-nav">
        <div class="container">
            <div class="logo">
                <i class="fas fa-graduation-cap"></i>E-Learning
           
            </div>
            <ul class="nav-links">
                <li><a href="#features">Features</a></li>
                <li><a href="#courses">Courses</a></li>
                <li><a href="#testimonials">Testimonials</a></li>
                <li><a href="#login">Login</a></li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <h1><i class="fas fa-laptop-code"></i>Master Your Skills</h1>
            <p class="tagline">Learn, Code & Grow with Expert-Led Interactive Courses</p>

            <div class="hero-stats">
                <div class="stat-item">
                    <span class="stat-number">10,000+</span>
                    <span class="stat-label">Active Students</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">500+</span>
                    <span class="stat-label">Courses Available</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">100+</span>
                    <span class="stat-label">Expert Instructors</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">98%</span>
                    <span class="stat-label">Success Rate</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="features-section" id="features">
        <h2 class="section-title">Why Choose Our Platform?</h2>
        <div class="container">
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h4>Rich Course Library</h4>
                    <p>Access hundreds of courses across programming, design, business, and more. Learn at your own pace with lifetime access.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-code"></i>
                    </div>
                    <h4>Live Coding Practice</h4>
                    <p>Practice coding in real-time with our integrated IDE. Write, run, and test your code directly in the browser.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-certificate"></i>
                    </div>
                    <h4>Industry Certification</h4>
                    <p>Earn recognized certificates upon course completion. Showcase your achievements to employers worldwide.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h4>Community Support</h4>
                    <p>Join thousands of learners. Get help from peers and mentors through our active discussion forums.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h4>Track Your Progress</h4>
                    <p>Monitor your learning journey with detailed analytics, personalized recommendations, and progress reports.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h4>Expert Mentorship</h4>
                    <p>Get guidance from industry professionals. One-on-one sessions available for personalized learning experience.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Courses Preview Section -->
    <div class="courses-section" id="courses">
        <h2 class="section-title">Popular Courses</h2>
        <div class="container">
            <div class="courses-grid">
                <div class="course-card">
                    <div class="course-image" style="background: linear-gradient(135deg, #f093fb, #f5576c);">
                        <i class="fab fa-js"></i>
                    </div>
                    <div class="course-content">
                        <h3 class="course-title">JavaScript Mastery</h3>
                        <p class="course-desc">Deep dive into JavaScript ES6+. Master async programming, closures, and more.</p>
                        <div class="course-meta">
                            <span class="course-rating">
                                <i class="fas fa-star"></i>4.7 (1.8k reviews)
                            </span>
                            <span class="course-students">
                                <i class="fas fa-user"></i>18k students
                            </span>
                        </div>
                    </div>
                </div>
                <div class="course-card">
                    <div class="course-image" style="background: linear-gradient(135deg, #4facfe, #00f2fe);">
                        <i class="fab fa-node"></i>
                    </div>
                    <div class="course-content">
                        <h3 class="course-title">Node.js Backend</h3>
                        <p class="course-desc">Build scalable APIs and backends. Learn Express, MongoDB, and authentication.</p>
                        <div class="course-meta">
                            <span class="course-rating">
                                <i class="fas fa-star"></i>4.8 (2.1k reviews)
                            </span>
                            <span class="course-students">
                                <i class="fas fa-user"></i>12k students
                            </span>
                        </div>
                    </div>
                </div>
                <div class="course-card">
                    <div class="course-image" style="background: linear-gradient(135deg, #43e97b, #38f9d7);">
                        <i class="fas fa-database"></i>
                    </div>
                    <div class="course-content">
                        <h3 class="course-title">Database Design</h3>
                        <p class="course-desc">Master SQL and NoSQL databases. Learn optimization, indexing, and best practices.</p>
                        <div class="course-meta">
                            <span class="course-rating">
                                <i class="fas fa-star"></i>4.6 (1.5k reviews)
                            </span>
                            <span class="course-students">
                                <i class="fas fa-user"></i>9k students
                            </span>
                        </div>
                    </div>
                </div>
                <div class="course-card">
                    <div class="course-image" style="background: linear-gradient(135deg, #fa709a, #fee140);">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <div class="course-content">
                        <h3 class="course-title">Mobile App Development</h3>
                        <p class="course-desc">Create iOS and Android apps. Learn React Native and cross-platform development.</p>
                        <div class="course-meta">
                            <span class="course-rating">
                                <i class="fas fa-star"></i>4.9 (2.8k reviews)
                            </span>
                            <span class="course-students">
                                <i class="fas fa-user"></i>16k students
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="stats-section">
        <div class="stats-grid">
            <div class="stat-box">
                <i class="fas fa-graduation-cap"></i>
                <h3>50,000+</h3>
                <p>Graduates</p>
            </div>
            <div class="stat-box">
                <i class="fas fa-award"></i>
                <h3>45,000+</h3>
                <p>Certificates Issued</p>
            </div>
            <div class="stat-box">
                <i class="fas fa-globe"></i>
                <h3>150+</h3>
                <p>Countries</p>
            </div>
            <div class="stat-box">
                <i class="fas fa-briefcase"></i>
                <h3>5,000+</h3>
                <p>Career Placements</p>
            </div>
        </div>
    </div>

    <!-- Testimonials Section -->
    <div class="testimonials-section" id="testimonials">
        <h2 class="section-title">What Our Students Say</h2>
        <div class="container">
            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <p class="testimonial-text">"This platform completely changed my career! The courses are well-structured, and the instructors are incredibly knowledgeable. I landed my dream job as a Full Stack Developer within 6 months."</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">SM</div>
                        <div class="author-info">
                            <h5>Sarah Mitchell</h5>
                            <p>Full Stack Developer at Tech Corp</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <p class="testimonial-text">"The hands-on projects and live coding sessions are amazing! I love how everything is practical and industry-focused. The community support is outstanding too."</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">JD</div>
                        <div class="author-info">
                            <h5>John Davis</h5>
                            <p>Software Engineer at StartupXYZ</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <p class="testimonial-text">"Best investment I've made in my education! The certification helped me get promoted, and the skills I learned are directly applicable to my daily work. Highly recommend!"</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">EP</div>
                        <div class="author-info">
                            <h5>Emily Parker</h5>
                            <p>Senior Developer at Global Solutions</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <p class="testimonial-text">"From zero coding knowledge to building my own apps! The beginner-friendly approach and patient instructors made learning so much easier. I'm now freelancing successfully."</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">MR</div>
                        <div class="author-info">
                            <h5>Michael Rodriguez</h5>
                            <p>Freelance Web Developer</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <p class="testimonial-text">"The quality of content is exceptional. Every course is updated regularly, and the platform keeps improving. The lifetime access means I can always come back and refresh my knowledge."</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">LC</div>
                        <div class="author-info">
                            <h5>Lisa Chen</h5>
                            <p>Data Scientist at AI Innovations</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <p class="testimonial-text">"Perfect for busy professionals! I could learn at my own pace, and the mobile app made it easy to study during my commute. The career support team was incredibly helpful."</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">DW</div>
                        <div class="author-info">
                            <h5>David Wilson</h5>
                            <p>Backend Developer at FinTech Pro</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Login Section -->
    <div class="login-section" id="login">
        <div class="login-wrapper">
            <div class="login-info">
                <h2>Start Your Learning Journey Today</h2>
                <p>Join thousands of successful students who have transformed their careers with our expert-led courses. Get instant access to premium content and start learning immediately.</p>

                <ul class="benefit-list">
                    <li>
                        <i class="fas fa-check-circle"></i>
                        <span>Access to 500+ premium courses</span>
                    </li>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        <span>Live coding sessions and workshops</span>
                    </li>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        <span>Industry-recognized certificates</span>
                    </li>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        <span>24/7 community support</span>
                    </li>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        <span>Career guidance and mentorship</span>
                    </li>
                </ul>
            </div>

            <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <div class="login-box">
                    <div class="card card-outline card-primary">
                        <div class="card-header text-center">
                            <h1><b>Log</b>in</h1>
                        </div>
                        <div class="card-body">
                            <p class="login-box-msg">Login to start your session</p>
                            <asp:UpdatePanel ID="LoginUpdatePanel" runat="server">
                                <ContentTemplate>
                                    <!-- Login Form -->
                                    <div class="input-group mb-3">
                                        <label for="<%= Email.ClientID %>" class="form-label visually-hidden">Email</label>
                                        <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="Email" TextMode="Email"></asp:TextBox>
                                        <div class="input-group-append">
                                            <div class="input-group-text"><span class="fas fa-envelope"></span></div>
                                        </div>
                                    </div>
                                    <div class="mb-2"><span id="emailError" class="text-danger d-none">Email is required.</span></div>
                                    <div class="input-group mb-3">
                                        <label for="<%= Password.ClientID %>" class="form-label visually-hidden">Password</label>
                                        <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                                        <div class="input-group-append">
                                            <div class="input-group-text"><span class="fas fa-lock"></span></div>
                                        </div>
                                    </div>
                                    <div class="mb-2"><span id="passwordError" class="text-danger d-none">Password is required.</span></div>
                                    <!-- Login Button -->
                                    <asp:Button ID="LoginButton" runat="server" CssClass="btn row-cols-1 btn-block btn-primary" Text="Login" OnClientClick="return validateLogin();" OnClick="LoginButton_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <!-- Custom Toast Container -->
                            <div id="customToast" class="custom-toast d-none"> 
                                <span id="customToastMessage"></span> 
                                <button onclick="hideCustomToast()" class="btn-close-white">×</button> 
                                </div>

                            <!-- SignUp Button to trigger modal -->
                            <div class="text-center mt-3"><a runat="server" class="btn btn-link px-4 py-2 rounded-pill fw-semibold" data-bs-toggle="modal" data-bs-target="#signupModal">Create New Account</a> </div>
                        </div>
                    </div>
                </div>
                <!-- SignUp Modal -->
                <asp:UpdatePanel ID="SignupUpdatePanel" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="signupModalLabel">Sign Up</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Full Name -->
                                        <div class="mb-3">
                                            <label for="<%= Name.ClientID %>" class="form-label">Full Name</label>
                                            <asp:TextBox ID="Name" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                                            <span id="nameError" class="text-danger d-none">Full name is required.</span> </div>
                                        <!-- Email -->
                                        <div class="mb-3">
                                            <label for="<%= SignUpEmail.ClientID %>" class="form-label">Email address</label>
                                            <asp:TextBox ID="SignUpEmail" runat="server" CssClass="form-control" placeholder="Enter your email" TextMode="Email"></asp:TextBox>
                                            <span id="signupEmailError" class="text-danger d-none">Email is required.</span> </div>
                                        <!-- Password -->
                                        <div class="mb-3">
                                            <label for="<%= SignUpPassword.ClientID %>" class="form-label">Password</label>
                                            <asp:TextBox ID="SignUpPassword" runat="server" CssClass="form-control" placeholder="Create a password" TextMode="Password"></asp:TextBox>
                                            <span id="signupPasswordError" class="text-danger d-none">Password is required.</span> </div>
                                        <!-- File Upload -->
                                        <div class="mb-3">
                                            <label for="<%= FileUpload1.ClientID %>" class="form-label">Upload Profile Image</label>
                                            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                                            <small class="form-text text-muted">Upload your profile photo (JPG, PNG, or JPEG).</small> <span id="fileError" class="text-danger d-none">Profile image is required.</span> </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <!-- Inside modal footer -->
                                        <button type="button" class="btn btn-primary" onclick="document.getElementById('SignUpButton').click();">Sign Up </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <!-- ✅ Place this outside UpdatePanel -->
                <asp:Button ID="SignUpButton" runat="server" CssClass="d-none" Text="Sign Up" OnClientClick="return validateSignup();" OnClick="SignUpButton_Click" />
            </form>

        </div>
    </div>

    <!-- Footer -->
    <div class="landing-footer">
        <div class="footer-content">
            <div class="footer-section">
                <h4>About E-Learning</h4>
                <p>We're dedicated to providing world-class education to everyone, everywhere. Our mission is to make quality learning accessible and affordable.</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h4>Quick Links</h4>
                <p><a href="#courses">Browse Courses</a></p>
                <p><a href="#features">Features</a></p>
                <p><a href="#testimonials">Success Stories</a></p>
                <p><a href="#login">Login</a></p>
                <p><a href="#">Become an Instructor</a></p>
            </div>

            <div class="footer-section">
                <h4>Support</h4>
                <p><a href="#">Help Center</a></p>
                <p><a href="#">Contact Us</a></p>
                <p><a href="#">FAQs</a></p>
                <p><a href="#">Terms of Service</a></p>
                <p><a href="#">Privacy Policy</a></p>
            </div>

            <div class="footer-section">
                <h4>Contact Info</h4>
                <p><i class="fas fa-map-marker-alt"></i>123 Learning Street, Education City</p>
                <p><i class="fas fa-phone"></i>+1 (555) 123-4567</p>
                <p><i class="fas fa-envelope"></i>info@elearning.com</p>
                <p><i class="fas fa-clock"></i>24/7 Support Available</p>
            </div>
        </div>

        <div class="footer-bottom">
            <p><strong>&copy; 2025 E-Learning Platform.</strong> All rights reserved. | Empowering learners worldwide</p>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="dist/js/adminlte2167.js?v=3.2.0"></script>

    <!-- Smooth scrolling for navigation links -->
    <script>
        // Smooth scrolling for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>

    <!-- Login validate Script -->
    <script>
        function validateLogin() {
            var email = document.getElementById('<%= Email.ClientID %>');
            var password = document.getElementById('<%= Password.ClientID %>');
            var emailError = document.getElementById('emailError');
            var passwordError = document.getElementById('passwordError');
            let valid = true;
            if (email.value.trim() === "") {
                emailError.classList.remove("d-none");
                valid = false;
            } else {
                emailError.classList.add("d-none");
            }
            if (password.value.trim() === "") {
                passwordError.classList.remove("d-none");
                valid = false;
            } else {
                passwordError.classList.add("d-none");
            }
            return valid;
        }

        function showLoginToast() {
            var toast = new bootstrap.Toast(document.getElementById('loginToast'));
            toast.show();
        }
    </script>

    <!-- SignUp validate Script -->
    <script>
        function validateSignup() {
            var name = document.getElementById('<%= Name.ClientID %>');
            var email = document.getElementById('<%= SignUpEmail.ClientID %>');
            var password = document.getElementById('<%= SignUpPassword.ClientID %>');
            var file = document.getElementById('<%= FileUpload1.ClientID %>');
            var nameError = document.getElementById('nameError');
            var emailError = document.getElementById('signupEmailError');
            var passwordError = document.getElementById('signupPasswordError');
            var fileError = document.getElementById('fileError');
            let valid = true;
            if (name.value.trim() === "") {
                nameError.classList.remove("d-none");
                valid = false;
            } else {
                nameError.classList.add("d-none");
            }
            if (email.value.trim() === "") {
                emailError.classList.remove("d-none");
                valid = false;
            } else {
                emailError.classList.add("d-none");
            }
            if (password.value.trim() === "") {
                passwordError.classList.remove("d-none");
                valid = false;
            } else {
                passwordError.classList.add("d-none");
            }
            if (file.value === "") {
                fileError.classList.remove("d-none");
                valid = false;
            } else {
                fileError.classList.add("d-none");
            }
            return valid;
        }
    </script>

    <!-- Script -->
    <script>
        function showCustomToast(message, duration = 10000) {
            const toast = document.getElementById("customToast");
            const msg = document.getElementById("customToastMessage");
            msg.textContent = message;
            toast.classList.remove("d-none");

            setTimeout(() => {
                hideCustomToast();
            }, duration);
        }

        function hideCustomToast() {
            const toast = document.getElementById("customToast");
            toast.classList.add("d-none");
        }
    </script>

</body>
</html>
