# flutter_facebook_login_web

A Flutter plugin for using the JS Facebook Login SDK with Flutter Web.

## Web integration

NOTE: Facebook only allows <b>https</b> URLs.<br>
At the start of `body` tag in `web\index.html` add:
```html
 
<!--Facebook SDK config -->
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId            : 'YOUR_APP_ID',
      autoLogAppEvents : true,
      xfbml            : true,
      version          : 'v7.0'
    });
  };
</script>

<!-- Facebook JS CDN SDK -->
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>

<!-- for interop with dart through this plugin -->
<script src="https://flutterfacebooklogin.s3.us-east-2.amazonaws.com/web_interop.js"></script>
```
