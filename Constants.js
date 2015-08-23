.pragma library

var grid = 8;
var minimal = 32;
var border = 4;
var handle = 8;

var roomColor = "#567";

var button = {width: 32, height: 32};

function snap(val) {
    return Math.round(val / grid) * grid;
}
