<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Google with Grails</title>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
    <meta name="google-signin-client_id" content="252009948529-183k0hjs6v3jpl21kj24ahdr0kj1am31.apps.googleusercontent.com">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
    <script src="https://apis.google.com/js/api:client.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        var googleUser = {};
        var startApp = function() {
            gapi.load('auth2', function(){
                // Retrieve the singleton for the GoogleAuth library and set up the client.
                auth2 = gapi.auth2.init({
                    client_id: '252009948529-183k0hjs6v3jpl21kj24ahdr0kj1am31.apps.googleusercontent.com',
                    cookiepolicy: 'single_host_origin',
                    // Request scopes in addition to 'profile' and 'email'
                    //scope: 'additional_scope'
                });
                attachSignin(document.getElementById('customBtn'));
            });
        };

        function attachSignin(element) {
            console.log(element.id);
            auth2.attachClickHandler(element, {},
                function(googleUser) {
                    document.getElementById('signout').innerText = "User Signed in: " +
                        googleUser.getBasicProfile().getName();
                }, function(error) {
                    alert(JSON.stringify(error, undefined, 2));
                });
        }
        function onSignIn(googleUser) {
            var profile = googleUser.getBasicProfile();
            console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
            console.log('Name: ' + profile.getName());
            console.log('Image URL: ' + profile.getImageUrl());
            console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
            document.getElementById('details').innerHTML ="Name: "+ profile.getName() +
                "<br> ID: " + profile.getId() +
                "<br> Email: " + profile.getEmail() +
                "<br> <img src='" + profile.getImageUrl() + "' width='150px' height='150px' />";
        }

    </script>
</head>

<body>
<center>
    <div id="details" class="container-fluid"></div>
<a href="" onclick="signOut();" id="signout" title="Click to Sign Out">Sign out</a>
<script>
    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            document.getElementById('signout').innerText="User Signed out";
        });
    }
</script>
<hr style="border: solid #2b542c 5px">
<br><br>
<!-- In the callback, you would hide the gSignInWrapper element on a
  successful sign in -->
    <button href="" title="Custom Login  Button" id="customBtn" class="btn btn-success">
    <i class="fa fa-google-plus fa-3x" aria-hidden="true"> Sign in with Google</i>
    </button>

    <br><br>
<hr style="border: solid #2b542c 5px">
    <br><br>
<div class="g-signin2" data-onsuccess="onSignIn" title="Default Login Button"></div>
<script>startApp();</script>
</center>
</body>

</html>
