# RingCentral Events API - OAuth Example

This very small app demonstrates a simple OAuth authentication flow for RingCentral Events, allowing calling apps to access the API.

## Installing

This is a ruby 3.0 app, which you'll need to install. If you use asdf then
activating [this](https://github.com/asdf-vm/asdf-ruby) plugin should install
the correct version.

```bash
bundle
```

## Running

Run the script with the following environment variables set:
 - RCE_CALLBACK_URL
 - RCE_APP_ID
 - RCE_APP_SECRET

```bash
RCE_CALLBACK_URL=http://localhost:3000/auth/hopin/callback RCE_APP_ID={your client id} RCE_APP_SECRET={your app secret} bundle exec rackup -p3000
```

## Thanks

Examples borrowed from https://github.com/assembly-edu/oauth-sample-sinatra
