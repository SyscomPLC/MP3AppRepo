'use strict';

app.formMenu = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formMenu
// END_CUSTOM_CODE_formMenu
(function(parent) {
    var formMenuModel = kendo.observable({
        fields: {},
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formMenuModel', formMenuModel);
})(app.formMenu);

// START_CUSTOM_CODE_formMenuModel
// END_CUSTOM_CODE_formMenuModel