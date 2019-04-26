'use strict';

app.formScanToWorkITBC = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkITBCModel = kendo.observable({
        fields: {
            itbcWorkOrder: '',
            itbcWarehouse: '',
            itbcOperation: '',
            itbcWorkCentre: '',
            itbcDescription: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkITBCModel', formScanToWorkITBCModel);
})(app.formScanToWorkITBC);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel