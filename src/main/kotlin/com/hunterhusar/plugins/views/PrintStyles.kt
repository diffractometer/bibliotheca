package com.hunterhusar.plugins.views

val printStyles = """
        body {
            font-family: 'Times New Roman', serif;
            color: #000;
            background: #fff;
            font-size: 14pt; /* Smaller font size */
        }
        h1 {
            font-size: 14pt;
            margin: 10px 0;
        }
        p {
            margin: 8px 0;
        }
        img {
            display: block;
            margin: 0;
            max-width: 100%; 
            height: auto;
            page-break-after: avoid;
        }
""".trimIndent()