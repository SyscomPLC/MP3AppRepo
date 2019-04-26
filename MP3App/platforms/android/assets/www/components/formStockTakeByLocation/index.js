'use strict';

app.formStockTakeByLocation = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formStockTakeByLocation
// END_CUSTOM_CODE_formStockTakeByLocation
(function(parent) {
    var formStockTakeByLocationModel = kendo.observable({
        fields: {
            stblLocation: '',
            stblWarehouse: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formStockTakeByLocationModel', formStockTakeByLocationModel);
})(app.formStockTakeByLocation);

// START_CUSTOM_CODE_formStockTakeByLocationModel
// END_CUSTOM_CODE_formStockTakeByLocationModel