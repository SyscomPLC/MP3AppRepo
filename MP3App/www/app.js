(function() {
    // store a reference to the application object that will be created
    // later on so that we can use it if need be
    var app = {
        data: {}
    };

    var bootstrap = function() {
        $(function() {
            app.mobileApp = new kendo.mobile.Application(document.body, {

                // you can change the default transition (slide, zoom or fade)
                transition: 'slide',
                // comment out the following line to get a UI which matches the look
                // and feel of the operating system
                skin: 'flat',
                // the application needs to know which view to load first
                initial: 'components/formLogin/view.html',
                statusBarStyle: 'black-translucent'
            });
        });
    };

    if (window.cordova) {
        // this function is called by Cordova when the application is loaded by the device
        document.addEventListener('deviceready', function() {
            // hide the splash screen as soon as the app is ready. otherwise
            // Cordova will wait 5 very long seconds to do it for you.
            if (navigator && navigator.splashscreen) {
                navigator.splashscreen.hide();
            }

            var element = document.getElementById('appDrawer');
            if (typeof(element) != 'undefined' && element != null) {
                if (window.navigator.msPointerEnabled) {
                    $("#navigation-container").on("MSPointerDown", "a", function(event) {
                        app.keepActiveState($(this));
                    });
                } else {
                    $("#navigation-container").on("touchstart", "a", function(event) {
                        app.keepActiveState($(this));
                    });
                }
            }

            bootstrap();
        }, false);
    } else {
        bootstrap();
    }

    app.keepActiveState = function _keepActiveState(item) {
        var currentItem = item;
        $("#navigation-container li a.active").removeClass("active");
        currentItem.addClass('active');
    };

    window.app = app;

    app.isOnline = function() {
        if (!navigator || !navigator.connection) {
            return true;
        } else {
            return navigator.connection.type !== 'none';
        }
    };
}());

// START_CUSTOM_CODE_kendoUiMobileApp

function onBackButtonPressed() {
    return;
}

//var emptyFunc = function () { };
//var disableBackButton = function() { document.addEventListener("backbutton", emptyFunc, false); };
//var enableBackButton = function() { document.removeEventListener("backbutton", emptyFunc); }

// 0 = Syscom Rel 7
// 1 = HP Test System
// 2 = HP Live System
// 3 = HP ASAF Test System
// 4 = HP ASAF Live System
var appbuild = 0;

//Spectre connection
//var deploy_server = "spectre";
//var server_path = "http://spectre.int.syscom.plc.uk:8980";
//var service_path = "/test1/rest/test1/";
//var deploy_method = "created"; 
//var deploy_service = "";

//Parkies Test Connection - All lines need to be uncommented (deploy_server is intentionaly spectre)
var deploy_server = "spectre";
var server_path = "http://MCJS-HPERPDB1.net.JohnLewis.co.uk:8980";
var service_path = "/HPItemClassStockInfoTest/rest/test1/";
var deploy_method = "deployed";
var deploy_service = "/HPItemClassStockInfoTest";

//Parkies LIVE Old connection
//var deploy_server = "mcjs";
//var server_path = "http://MCJS-HPERPAPP1.net.JohnLewis.co.uk:8980";
//var service_path = "/mobilerest/rest/mobilerest/";
//var deploy_method = "created";

//Parkies LIVE New connection
//var deploy_server = "spectre";
//var server_path = "http://MCJS-HPERPAPP1.net.JohnLewis.co.uk:8980";
//var service_path = "/HPItemClassStockInfo/rest/test1/";
//var deploy_method = "deployed";
//var deploy_service = "/HPItemClassStockInfo";


// END_CUSTOM_CODE_kendoUiMobileApp