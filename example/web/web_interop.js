function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function getFB() {
    return new Promise((resolve) => {
        if (window.FB) {
            resolve(window.FB);
        }
    });
}

function FacebookLogin() {


    FacebookLogin.prototype.login = function (permissions) {
        return new Promise(async (resolve) => {
            const FB = await getFB();

            FB.login((response) => {

                console.log(response);

                let accessTokenObject = null;
                if (response.authResponse != null) {
                    accessTokenObject = {
                        token: response.authResponse.accessToken,
                        userId: response.authResponse.userID,
                        expires: response.authResponse.data_access_expiration_time //expiresIn,
                        // permissions: response.accessToken.permissions,
                        // declinedPermissions: response.accessToken.declinedPermissions
                    };
                }

                let resultObject = {
                    accessToken: accessTokenObject,
                    status: response.status,
                    errorMessage: response.errorMessage,
                };

                resolve(JSON.stringify(resultObject));
            }, {scope: 'public_profile, email'});
        });
    };

    FacebookLogin.prototype.testAPI = function () {
        console.log('Welcome!  Fetching your information.... ');
        // FB.api('/me', function (response) {
        //     console.log('Successful login for: ' + response.name);
        // });

        return new Promise(async (resolve) => {
            const FB = await getFB();

            FB.api('/me', (response) => {
                console.log(response);

                resolve(response.name);
            });
        });
    };

    FacebookLogin.prototype.logout = function () {
        return new Promise(async (resolve) => {
            const FB = await getFB();

            FB.logout((response) => {
                resolve(true);
            });
        });
    };


}
