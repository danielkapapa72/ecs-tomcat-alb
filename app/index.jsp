<%@ page import="java.util.Date,java.security.cert.X509Certificate" %>

<!DOCTYPE html>

<html>
<head>
    <title>mTLS Tomcat App</title>

```
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        background: #f4f6f9;
    }

    /* Navbar */
    .navbar {
        background: #1e293b;
        padding: 15px;
        color: white;
        display: flex;
        justify-content: space-between;
    }

    .navbar a {
        color: white;
        margin: 0 10px;
        text-decoration: none;
        font-weight: bold;
    }

    .navbar a:hover {
        text-decoration: underline;
    }

    /* Container */
    .container {
        text-align: center;
        margin-top: 40px;
    }

    /* Card */
    .card {
        background: white;
        padding: 25px;
        margin: auto;
        width: 60%;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    /* Status */
    .success { color: green; }
    .error { color: red; }

    /* Image */
    .hero-img {
        width: 150px;
        margin-bottom: 20px;
    }

    /* Footer */
    .footer {
        margin-top: 50px;
        padding: 10px;
        background: #1e293b;
        color: white;
    }
</style>
```

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">
    <div>🔐 mTLS App</div>
    <div>
        <a href="#">Home</a>
        <a href="#">Status</a>
        <a href="#">Docs</a>
    </div>
</div>

<!-- MAIN CONTENT -->

<div class="container">

```
<div class="card">

    <!-- IMAGE -->
    <img class="hero-img" src="https://cdn-icons-png.flaticon.com/512/3064/3064197.png" />

    <h1>Secure mTLS Tomcat Application</h1>

    <p><strong>Status:</strong> <span class="success">Secure Connection ✅</span></p>
    <p><strong>Time:</strong> <%= new Date() %></p>
    <p><strong>Protocol:</strong> <%= request.getScheme() %></p>

    <hr/>

    <%
    X509Certificate[] certs =
    (X509Certificate[]) request.getAttribute("jakarta.servlet.request.X509Certificate");

    if (certs != null && certs.length > 0) {
    %>
        <h3>🔎 Client Certificate Info</h3>
        <p><strong>Subject:</strong> <%= certs[0].getSubjectDN() %></p>
        <p><strong>Issuer:</strong> <%= certs[0].getIssuerDN() %></p>
    <%
    } else {
    %>
        <p class="error">No client certificate detected ❌</p>
    <%
    }
    %>

</div>
```

</div>

<!-- FOOTER -->

<div class="footer">
    © 2026 mTLS Demo | AWS ECS Deployment 🚀
</div>

</body>
</html>

