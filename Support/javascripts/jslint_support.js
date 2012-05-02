/*globals JSLINT, print, quit */

(function (a) {
    var i, raw_data;
    if (!a[0]) {
        print('Usage: jslint.js -- "[your_javascript]" "[your_options]"');
        quit(1);
    }
    var options = {};
    if (a[1]) {
        options = JSON.parse(a[1]);
    }
    
    var my_result = JSLINT(a[0], options);
    try {
        raw_data = JSLINT.data();
        // break cyclic references
        if ("functions" in raw_data) {
            for (i = 0; i < raw_data.functions.length; i++) {
                delete raw_data.functions[i].params;
            }
        }
        print(JSON.stringify({data: raw_data, result: my_result}));
    } catch (e) {
        print(e);
    }
    if (!my_result) {
        quit(2);
    } else {
        quit();
    }
}(arguments));