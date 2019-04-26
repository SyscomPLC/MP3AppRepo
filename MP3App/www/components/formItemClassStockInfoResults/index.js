'use strict';

app.formItemClassStockInfoResults = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formItemClassStockInfoResults
// END_CUSTOM_CODE_formItemClassStockInfoResults
(function(parent) {
    var formItemClassStockInfoResultsModel = kendo.observable({
        fields: {
            icsiResItemCode: '',
            icsiResWarehouse: '',
        },
        cancel: function() {}
    });

    parent.set('formItemClassStockInfoResultsModel', formItemClassStockInfoResultsModel);
})(app.formItemClassStockInfoResults);

// START_CUSTOM_CODE_formItemClassStockInfoResultsModel
// END_CUSTOM_CODE_formItemClassStockInfoResultsModel