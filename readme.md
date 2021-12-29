webz.io client for Ruby
============================

[![Gem](https://img.shields.io/gem/dv/webzio-ruby/stable.svg)](https://rubygems.org/gems/webzio-ruby)

A simple way to access the [Webz.io](https://webz.io) API from your Ruby code

```ruby
require 'webzio'

webzio = Webzio::Client.new('YOUR_API_KEY')
output = webzio.query('filterWebContent', {'q': 'github'})
puts output['posts'][0]['text'] # Print the text of the first post
puts output['posts'][0]['published'] # Print the text of the first post publication date

# Get the next batch of posts
output = webzio.get_next()
puts output['posts'][0]['thread']['site'] # Print the site of the first post
```

API Key
-------

To make use of the webz.io API, you need to obtain a token that would be
used on every request. To obtain an API key, create an account at
https://webz.io/auth/signup, and then go into
https://webz.io/dashboard to see your token.


Installing
----------

You can install this SDK by simply downloading `webzio.rb` and including it to your project.

Or using `gem`

```bash
$ gem install webzio-ruby
```

Use the API
-----------

To get started, you need to import the library, and set your access token.
(Replace `YOUR_API_KEY` with your actual API key).

```ruby
require 'webzio'
webzio = Webzio.new('YOUR_API_KEY')
```

**API Endpoints**

The first parameter the query() function accepts is the API endpoint string. Available endpoints:
* filterWebContent - access to the news/blogs/forums/reviews API
* productFilter - access to data about eCommerce products/services
* darkFilter - access to the dark web (coming soon)

Now you can make a request and inspect the results:

```ruby
output = webzio.query('filterWebContent', {'q': 'github'})
puts output['totalResults']
# 15565094
puts output['posts'].size
# 100
puts output['posts'][0]['language']
# english
puts output['posts'][0]['title']
# Putting quotes around dictionary keys in JS
```

For your convenience, the output object is iterable, so you can loop over it
and get all the results of this batch (up to 100).

```ruby
total_words = 0
output['posts'].each do |post|
  total_words += post['text'].split(' ').size
end
puts total_words
```

Full documentation
------------------

* ``config(token)``

  * token - your API key

* ``query(end_point_str, params)``

  * end_point_str:
    * filterWebContent - access to the news/blogs/forums/reviews API
    * productFilter - access to data about eCommerce products/services
    * darkFilter - access to the dark web (coming soon)
  * params: A key value dictionary. The most common key is the "q" parameter that hold the filters Boolean query. [Read about the available filters](https://webz.io/documentation).

* ``get_next()`` - a method to fetch the next page of results.


Polling
-------

If you want to make repeated searches, performing an action whenever there are
new results, use code like this:

```ruby
r = webzio.query('filterWebContent', {'q': 'skyrim'})
while true do
  r['posts'].each do |post|
    perform_action(post)
    sleep(0.3)
    r = webzio.get_next()
  end
end
```
