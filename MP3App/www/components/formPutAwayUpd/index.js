'use strict';

app.formPutAwayUpd = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formPutAwayUpd
// END_CUSTOM_CODE_formPutAwayUpd
(function(parent) {
    var formPutAwayUpdModel = kendo.observable({
        fields: {
            paUpdPutAway: '',
            paUpdSubStorage: '',
            paUpdToLocation: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formPutAwayUpdModel', formPutAwayUpdModel);
})(app.formPutAwayUpd);

// START_CUSTOM_CODE_formPutAwayUpdModel
// END_CUSTOM_CODE_formPutAwayUpdModel