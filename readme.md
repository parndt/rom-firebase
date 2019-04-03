# ROM-Firebase Adapter

This project builds on the excellent [rom-http](https://github.com/rom-rb/rom-http) and [firebase](https://github.com/oscardelben/firebase-ruby) libraries to provide an interface for communicating with a Firebase Realtime Database.

## How this works

To start using this, create a `ROM::Configuration` like so:

```ruby
require 'rom/firebase'

configuration = ROM::Configuration.new(
  :firebase,
  uri: 'https://your-firebase-db-name.firebaseio.com',
  headers: { Accept: 'application/json' },
  request_handler: ROM::Firebase::RequestHandler.new(
    File.expand_path('../config/your-firebase-db-name.json', __dir__)
  ), # or your own class
  response_handler: ROM::Firebase::ResponseHandler # or your own class
)
```

Notes:

- You'll need to change the path to your Firebase JSON file to match where it is stored for you.
- You can use your own RequestHandler or ResponseHandler class if you want customised interactions.

This configuration can be passed to a repository class which mirrors a schema inside your Firebase Realtime Database's key value store, e.g. let's say we are storing Pages, here is a working example. Note the use of `key` as the primary key.

```ruby
class PageRepository < ROM::Firebase::Repository[:pages]
end

class Pages < ROM::Relation[:firebase]
  schema do
    attribute :createdAt, ::ROM::Firebase::Types::Timestamp
    attribute :title, Types::Strict::String
    attribute :description, Types::Strict::String
    attribute :key, Types::Strict::String.meta(primary_key: true)
  end
end

configuration.register_relation(Pages)
container = ROM.container(configuration)
repo = PageRepository.new(container)
```

Now you can query it:

```ruby
page = repo.create(
  createdAt: ::Firebase::ServerValue::TIMESTAMP,
  title: 'Hello World',
  description: 'A wild page appears'
)
```

This should return a `ROM::Struct::Page` with the created attributes:

```ruby
=> #<ROM::Struct::Page createdAt=1552999123000 title="Hello World" description="A wild page appears" key="-LaKxW4D8LTpwIWN3N9J">
```

And, in your Firebase Database console, you'll see a new pages node with one record.

To query this, you can use some of the built in functionality:

```ruby
repo.where { |page| page.title == 'Hello World' }
=> [#<ROM::Struct::Page createdAt="1552999123000" title="Hello World" description="A wild page appears" key="-LaKxW4D8LTpwIWN3N9J">]
```

To update it, use a ROM changeset:

```ruby
repo.by_pk(page.key).changeset(:update, description: 'A wild page is updated').commit
=> [#<ROM::Struct::Page createdAt="1552999123000" title="Hello World" description="A wild page is updated" key="-LaKxW4D8LTpwIWN3N9J">]
```

To delete our page is simple:

```ruby
repo.by_pk(page.key).delete
=> nil
```

You can't currently delete multiple records at once through relations, but there
is a workaround on the repository level:

```
keys = ["-LaKxW4D8LTpwIWN3N9J", "-LaKxW4D8LTpwIWN3N9K"]
repo.delete(keys)
```

So, for example, if you wanted to delete the last 2 entries you could:

```
repo.delete(repo.limit(2).to_a.map(&:key))
```
