// pull in styl
require('./styles/main.styl');

// inject bundled Elm app into div#main
var Elm = require('../elm/Present');
Elm.Present.embed(document.getElementById('main'));
