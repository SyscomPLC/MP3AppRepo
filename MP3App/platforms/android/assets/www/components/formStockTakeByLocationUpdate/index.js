'use strict';

app.formStockTakeByLocationUpdate = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formStockTakeByLocationUpdate
// END_CUSTOM_CODE_formStockTakeByLocationUpdate
(function(parent) {
    var formStockTakeByLocationUpdateModel = kendo.observable({
        fields: {
            stblQuantity: '',
            stblUpdSubIdent: '',
            stblUpdPiece: '',
            stblUpdItemCode: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formStockTakeByLocationUpdateModel', formStockTakeByLocationUpdateModel);
})(app.formStockTakeByLocationUpdate);

// START_CUSTOM_CODE_formStockTakeByLocationUpdateModel
// END_CUSTOM_CODE_formStockTakeByLocationUpdateModel