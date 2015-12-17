== README

# Otters.io
*An adorable little blogging system*

Otters.io is small and simple Rails-based blogging system. This app is only intended for my personal use at [Otters.io](http://otters.io), but you are free to use bits and pieces that you find useful. 

The source code is under the MIT License. Take what you want. I make no promises of anything. Have fun. 🎉 


## Core Assumptions:

### 1. I'm in charge:
  - The blog has **1** author, and that's me.
  - The author will write posts as plain text or html.
  - The author has access to a [Unix system](https://youtu.be/URVS4H7vrdU?t=6) that the blog will be deployed to.

### 2. Other people are smarter than me:
  - A web-based editing interface that I would make would not be better than native writing apps.
  - Therefore, Otters.io implements [metaWeblog](http://xmlrpc.scripting.com/spec.html). An API that native writing apps can tie into.
  - Whatever code I write probably won't be faster than existing technologies.
  - Therefore, Otters.io offloads as much work as possible on to the web server, the cache, and the database.

### 3. I may have chose wrong:
  - The app should not to depend on any operating system or database.
  - It is currently set to deploy to a stack of NGINX, MySQL, [Phusion Passenger](https://www.phusionpassenger.com), and Memcached, all on Linux.
  - This should all be able to be changed at a later date.


## Deploying

Before anything can be done you need to make your own `secrets.yml` file.
Beyond `secret_key_base`, you need to define `app_url` for development and production as wherever your blog is running. Example: `'http://127.0.0.1:3000'` for development and `'http://otters.io'` for production. 

For deployment you will need to change the Capistrano settings in `/config/deploy.rb` and `/config/deploy/production.rb` to match your server ip and deploy user.

To deploy the blog to your server you need ssh access to your deployment user on the server. Make sure the key in your `~/.ssh/id_rsa.pub` is in `/home/your_deploy_user/.ssh/authorized_keys` on the server.

After all of that is squared away, you need to either be up to date with this git repo or disable this check in `/config/deploy.rb` by removing: 

```
before :deploy, 'deploy:check_revision'
```

Finally, you can use Capistrano to deploy the blog to production. You need to upload your `database.yml` and `secrets.yml`.

```
bundle exec cap production setup:upload_yml
bundle exec cap production deploy
```


## Creating Users

To start posting articles to the blog you need to create a User to be an author.
There is no web interface for creating users that can create/edit articles on the blog. However, you can add a User from the Rails console via:

```
rails c production

u = User.new
u.name = 'My Name'
u.password = 'My Super Secret Password'
u.password_confirmation = 'My Super Secret Password'

u.save
```


## Creating/Editing/Deleting Articles

Articles are created, edited, and deleted through any app on your machine that supports the [metaWeblog](http://xmlrpc.scripting.com/spec.html) XML-RPC logging API.

I use [MarsEdit](https://red-sweater.com/marsedit/) and highly recommend it.

Just point the app to `http://your_domain_or_ip.com/xmlrpc` and make sure to put in the username and password you created for your User.


## Themes and Looks

The colors and fonts used by the site can be changed in the `_color_settings.sass` and `_font_settings.sass` located in the `/app/assets/stylesheets/settings/` directory.

Changing anything beyond that requires modifying the app's views and stylesheets on your own.


- - -

*Made with ❤️ in Kansas.*
