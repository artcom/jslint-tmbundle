/*globals load, print, quit, esprima*/

load('../vendor/esprima/esprima.js');

(function (a) {
    var i, raw_data;
    if (!a[0]) {
        print('Usage: jslintrc.js -- "[your_jslintrc]"');
        quit(1);
    }
    var options = {};
    
    var my_result = esprima.parse(a[0], {comment: true});
    print(JSON.stringify(my_result));
    if (!my_result) {
        quit(2);
    } else {
        quit();
    }
}(arguments));