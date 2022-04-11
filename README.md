# Hopin Example Oauth

This very small app demonstrates a simple oauth authentication flow for Hopin, allowing calling apps to access the API.

## Installing

This is a ruby 3.0 app, which you'll need to install. If you use asdf then
activating [this](https://github.com/asdf-vm/asdf-ruby) plugin should install
the correct version.

```bash
bundle
```

## Running

Run the script with the following environment variables set:
 - HOPIN_CALLBACK_URL
 - HOPIN_APP_ID
 - HOPIN_APP_SECRET

```bash
HOPIN_CALLBACK_URL=http://localhost:3000/auth/hopin/callback HOPIN_APP_ID={your client id} HOPIN_APP_SECRET={your app secret} bundle exec rackup -p3000
```

## Thanks

Examples borrowed from https://github.com/assembly-edu/oauth-sample-sinatra
