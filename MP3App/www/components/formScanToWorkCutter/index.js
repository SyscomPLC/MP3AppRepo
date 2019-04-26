'use strict';

app.formScanToWorkCutter = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkCutterModel = kendo.observable({
        fields: {
            stwcWorkOrder: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkCutterModel', formScanToWorkCutterModel);
})(app.formScanToWorkCutter);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel