# elm-webpack-game-quarter


## About this project
A minimalist Elm Game together with Webpack and gulp tooling to easily develop, build for production and deploy to S3 with static site hosting (assuming subdomain configured)

Fork this to get up and running with creating a minimalist game in Elm (without having to figure out all the tedious details around production builds + deploys)

## Quarter Past

Quarter Past is a simple game of coordination, skill and not panicking.

It is written in Elm 0.18.

Inspired/adapted from [an article](http://ohanhi.github.io/base-for-game-elm-017.html).

But that article didn't really include an actual working game or the kinds of performance optimistation necessary for good performance on mobile.

E.g. on selecting a cell, don't cause DOM change, do those on the animation frame

    selectCell : Cell -> Model -> Model
    selectCell cell model =
        { model | pendingCell = Just cell }

then when doing update on animation frame include:

                    , cell =
                        case model.pendingCell of
                            Just c ->
                                c

                            Nothing ->
                                model.cell
                    , pendingCell = Nothing

i.e. set new state + clear the pending/requested change.

### Serve locally:
```
npm start
```
* Open [http://localhost:8080/](http://localhost:8080/)
* The main Elm file is `src/elm/Game.elm`
* Will auto reload on changes


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder; will require web server due to paths (can't just open in browser)

### Deploy (route 53, subdomain example; other options should be fine as very simple `dist/` )

Having configured/created aws-config.json

```
gulp deploy
```

Needs S3 bucket ID (which matches sub domain)

configuration of route 53

create record set
name (must match s3 id)
choose alias
target should appear as option if subdomain + s3 bucket name match

will take a few minutes to actually work

### Deploy with now

Install if required:

```
npm i -g now
```

To actually deploy

```
cd dist
now
```

### Alternative deployments

Whatever option selected must ensure that serving from route as js url is relative to `/` i.e. treat `dist` as root.