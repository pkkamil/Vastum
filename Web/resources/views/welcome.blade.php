<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="apple-mobile-web-app-title" content="Vastum"/>
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- Favicon -->
    <link rel="shortcut icon" href={{ asset("../favicon.ico")}} />
    <link rel="apple-touch-icon" sizes="256x256" href={{ asset("../favicon.ico") }} />
    <link rel="apple-touch-startup-image" href={{ asset("../favicon.ico") }} />

    <!-- Open Graph -->
    <meta property="og:title" content="Vastum - Segreguj prawidłowo" />
    <meta property="og:description" content="" />
    <meta property="og:type" content="website" />
    <meta property="og:image" content={{ asset("../favicon.ico") }} />
    <meta property="og:url" content="" />
    <meta property="og:site_name" content="Vastum" />

    <title>Vastum - Segreguj prawidłowo</title>

    <!-- Canonical link -->
    <link rel="canonical" href="" />

    <!-- Scripts -->
    <script src="{{ asset('js/app.js') }}" defer></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/95a2d2c3f2.js" crossorigin="anonymous"></script>

    <!-- Fonts -->
    <link rel="dns-prefetch" href="//fonts.gstatic.com">

    <!-- Styles -->
    <link href="{{ mix('css/app.css') }}" rel="stylesheet">
    <body>
        <div id="app">
            <search></search>
        </div>
    </body>
</html>
