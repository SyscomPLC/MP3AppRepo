'use strict';

app.formPutAway = kendo.observable({
    onShow: function() {},
    afterShow: function() {}
});

// START_CUSTOM_CODE_formPutAway
// END_CUSTOM_CODE_formPutAway
(function(parent) {
    var formPutAwayModel = kendo.observable({
        fields: {
            paSubIdenifier: '',
            paPiece: '',
            paItemCode: '',
            paWarehouse: '',
        },
        submit: function() {},
        cancel: function() {}
    });

    parent.set('formPutAwayModel', formPutAwayModel);
})(app.formPutAway);

// START_CUSTOM_CODE_formPutAwayModel
// END_CUSTOM_CODE_formPutAwayModel