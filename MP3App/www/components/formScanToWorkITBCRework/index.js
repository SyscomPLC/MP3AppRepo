'use strict';

app.formScanToWorkITBCRework = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkITBCReworkModel = kendo.observable({
        fields: {
            /*itbcWorkOrder: '',
            itbcWarehouse: '',
            itbcOperation: '',
            itbcWorkCentre: '',
            itbcDescription: '',*/
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkITBCReworkModel', formScanToWorkITBCReworkModel);
})(app.formScanToWorkITBCRework);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel