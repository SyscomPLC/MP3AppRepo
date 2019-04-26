'use strict';

app.formPutAway = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formPutAway
// END_CUSTOM_CODE_formPutAway
/*(function(parent) {
    var formScanToWorkModel = kendo.observable({
        fields: {
            paSubIdenifier: '',
            paPiece: '',
            paItemCode: '',
            paWarehouse: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanToWorkModel', formScanToWorkModel);
})(app.formScanToWork);*/

// START_CUSTOM_CODE_formPutAwayModel
// END_CUSTOM_CODE_formPutAwayModel