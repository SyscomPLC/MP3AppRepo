'use strict';

app.formTransferFromInspection = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formTransferFromInspection
// END_CUSTOM_CODE_formTransferFromInspection
(function(parent) {
    var formTransferFromInspectionModel = kendo.observable({
        fields: {
            tfiSubIdentifier: '',
            tfiPiece: '',
            tfiItemCode: '',
            tfiInspectionWarehouse: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formTransferFromInspectionModel', formTransferFromInspectionModel);
})(app.formTransferFromInspection);

// START_CUSTOM_CODE_formTransferFromInspectionModel
// END_CUSTOM_CODE_formTransferFromInspectionModel