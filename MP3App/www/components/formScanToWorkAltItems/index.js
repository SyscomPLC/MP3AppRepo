'use strict';

app.formScanToWorkAltItems = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkAltItemsModel = kendo.observable({
        fields: {
            //stwcWorkOrder: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkAltItemsModel', formScanToWorkAltItemsModel);
})(app.formScanToWorkAltItems);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel