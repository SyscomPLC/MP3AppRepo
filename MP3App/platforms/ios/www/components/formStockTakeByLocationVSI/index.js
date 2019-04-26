'use strict';

app.formStockTakeByLocationVSI = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formStockTakeByLocationUpdate
// END_CUSTOM_CODE_formStockTakeByLocationUpdate
(function(parent) {
    var formStockTakeByLocationVSIModel = kendo.observable({
        //fields: {
        //    stblQuantity: '',
        //    stblUpdSubIdent: '',
        //    stblUpdPiece: '',
        //    stblUpdItemCode: '',
        ///},
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formStockTakeByLocationVSIModel', formStockTakeByLocationVSIModel);
})(app.formStockTakeByLocationVSI);

// START_CUSTOM_CODE_formStockTakeByLocationUpdateModel
// END_CUSTOM_CODE_formStockTakeByLocationUpdateModel