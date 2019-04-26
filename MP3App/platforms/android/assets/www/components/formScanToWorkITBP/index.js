'use strict';

app.formScanToWorkITBP = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkITBPModel = kendo.observable({
        fields: {
            /*itbpWorkOrder: '',
            itbpWarehouse: '',
            itbpOperation: '',
            itbpWorkCentre: '',
            itbpDescription: '',*/
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkITBPModel', formScanToWorkITBPModel);
})(app.formScanToWorkITBP);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel