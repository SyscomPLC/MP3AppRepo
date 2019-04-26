'use strict';

app.formScanToWorkPicker = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formScanToWorkPickModel = kendo.observable({
        fields: {
            stwpWorkOrder: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkPickerModel', formScanToWorkPickerModel);
})(app.formScanToWorkPicker);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel