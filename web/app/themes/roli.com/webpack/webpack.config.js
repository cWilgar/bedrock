// Plugin that means styles are no longer inlined into the javascript, but separate in a css bundle file (styles.css).
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
    entry: __dirname + "/entry.js",
    output: {
        path: __dirname + "/dist/",
        filename: "bundle.js"
    },
    module: {
        loaders: [
            {   
                test: /\.scss$/, 
                loader: ExtractTextPlugin.extract("style", "css!sass")
            }
        ]
    },
    plugins: [
        new ExtractTextPlugin("dist/styles.css")
    ]
};