.pragma library

var grid = 8;
var minimal = 32;
var handle = 16;

var roomColor = "#567";

var button = {width: 32, height: 32};

function snap(val) {
    return Math.round(val / grid) * grid;
}
