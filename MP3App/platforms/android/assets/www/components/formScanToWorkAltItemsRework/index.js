'use strict';

app.formScanToWorkAltItemsRework = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkAltItemsReworkModel = kendo.observable({
        fields: {
            //stwcWorkOrder: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkAltItemsReworkModel', formScanToWorkAltItemsReworkModel);
})(app.formScanToWorkAltItemsRework);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel