'use strict';

app.formScanOperations = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formPutAway
// END_CUSTOM_CODE_formPutAway
(function(parent) {
    var formPutAwayModel = kendo.observable({
        fields: {
            scWorkOrder: '',
            /*paPiece: '',
            paItemCode: '',
            paWarehouse: '',*/
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formScanOperationsModel', formScanOperationsModel);
})(app.formScanOperations);

// START_CUSTOM_CODE_formPutAwayModel
// END_CUSTOM_CODE_formPutAwayModel