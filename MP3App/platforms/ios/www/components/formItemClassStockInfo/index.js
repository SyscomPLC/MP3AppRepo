'use strict';

app.formItemClassStockInfo = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formItemClassStockInfo
// END_CUSTOM_CODE_formItemClassStockInfo
(function(parent) {
    var formItemClassStockInfoModel = kendo.observable({
        fields: {
            icsiItemcode: '',
            icsiWarehouse: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formItemClassStockInfoModel', formItemClassStockInfoModel);
})(app.formItemClassStockInfo);

// START_CUSTOM_CODE_formItemClassStockInfoModel
// END_CUSTOM_CODE_formItemClassStockInfoModel