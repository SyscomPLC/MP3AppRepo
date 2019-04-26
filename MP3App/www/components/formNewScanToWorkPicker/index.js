'use strict';

app.formNewScanToWorkPicker = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formLogin
// END_CUSTOM_CODE_formLogin
(function(parent) {
    var formNewScanToWorkPickerModel = kendo.observable({
        fields: {
            stwpWorkOrder: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formNewScanToWorkPickerModel', formNewScanToWorkPickerModel);
})(app.formNewScanToWorkPicker);

// START_CUSTOM_CODE_formLoginModel
// END_CUSTOM_CODE_formLoginModel