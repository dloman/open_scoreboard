 # open_scoreboard

Open Scoreboard

## Getting Started

Make it do things.

## Deploy stuff

### Recreate encrypted secrets file

```sh
$ tar cvf secrets.tar android/key.properties android/app/serviceAccount.json android/app/upload.keystore
$ travis encrypt-file secrets.tar
```

## Credits
App icon made by [mavadee](https://www.flaticon.com/authors/mavadee) from [Flaticon](https://www.flaticon.com)
