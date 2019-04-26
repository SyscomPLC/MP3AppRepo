'use strict';

app.formLogin = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formLoginModel = kendo.observable({
        fields: {
            password: '',
            username: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formLoginModel', formLoginModel);
})(app.formLogin);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel