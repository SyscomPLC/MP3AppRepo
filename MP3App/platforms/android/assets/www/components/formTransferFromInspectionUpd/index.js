'use strict';

app.formTransferFromInspectionUpd = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formTransferFromInspectionUpd
// END_CUSTOM_CODE_formTransferFromInspectionUpd
(function(parent) {
    var formTransferFromInspectionUpdModel = kendo.observable({
        fields: {
            tfiUpdQuantity: '',
            tfiUpdSubStorage: '',
            tfiUpdToLocation: '',
            tfiUpdToWarhouse: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formTransferFromInspectionUpdModel', formTransferFromInspectionUpdModel);
})(app.formTransferFromInspectionUpd);

// START_CUSTOM_CODE_formTransferFromInspectionUpdModel
// END_CUSTOM_CODE_formTransferFromInspectionUpdModel