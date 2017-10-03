# elm-present-data

An example of presenting data with Elm. A mini tutorial (where the source code is the final part).

### Deps

```
npm i
elm-package install
```

### Serve locally:
```
npm start
```
* Open [http://localhost:8080/](http://localhost:8080/)
* The main Elm file is `src/elm/Present.elm`
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