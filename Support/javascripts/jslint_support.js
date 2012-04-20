(function (a) {
    if (!a[0]) {
        print('Usage: jslint.js -- "[your_javascript]"');
        quit(1);
    }
    var my_result = JSLINT(a[0], OPTIONS);
    
    if (!my_result) {
        print(JSON.stringify({data: JSLINT.data(), result: my_result}));
        quit(2);
    } else {
        print(JSON.stringify({data: JSLINT.data(), result: my_result}));
        quit();
    }
}(arguments));