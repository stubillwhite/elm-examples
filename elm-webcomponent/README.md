# elm-webcomponent

This shows how to get a basic web component (<https://www.webcomponents.org/>) working with Elm.

## General process

### Get a pure HTML version of the component working

In general this is just a case of following the documentation. For this example:

- `bower init`
- `bower install --save Polymer/polymer`
- `bower install --save pushkar8723/paper-dropdown`
- `python -m SimpleHTTPServer 8080`

Edit the index.html file and get something working. For this example, it's just a case of the following:

```
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Simple HTML example</title>
        <script src="bower_components/webcomponentsjs/webcomponents.js"></script>
        <link rel="import" href="bower_components/paper-dropdown/paper-dropdown.html">
        <link rel="import" href="bower_components/paper-item/paper-item.html">
    </head>
    <body>
        <paper-dropdown label="HTML dropdown" value="{{value}}">
            <paper-item>Apple</paper-item>
            <paper-item>Banana</paper-item>
            <paper-item>Mango</paper-item>
        </paper-dropdown>
    </body>
</html>
```

## Get the HTML version working in your Elm server

- Create functions to generate the HTML nodes in the DOM
- Subscribe to events to receive updates
