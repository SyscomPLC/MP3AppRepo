'use strict';

app.formScanToWorkCutterConQty = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkCutterConQtyModel = kendo.observable({
        fields: {
            //stwcWorkOrder: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkCutterConQtyModel', formScanToWorkCutterConQtyModel);
})(app.formScanToWorkCutterConQty);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel