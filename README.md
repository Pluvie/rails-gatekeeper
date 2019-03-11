# Gatekeeper
Gatekeeper is a Rails engine for MongoDB which adds two simple functionalities:

* Model methods to control which informations can be seen by a specific user.
* Controller concern to handle HTML, JS and JSON responses.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'gatekeeper'
```

And then execute:
```bash
$ bundle install
```

## Usage

### Models
The first basic use is to define a model for your application and the information that can be accessed.

```ruby
# app/models/book.rb
class Book

  include Mongoid::Document

  field   :name,          type: String
  field   :internal_id,   type: Integer

  allowed_info do |user|
    case user.role
    when :librarian
      [ :name, :internal_id ]
    when :customer
      [ :name ]
    end
  end

end
```

```ruby
# app/models/user.rb
class User

  include Mongoid::Document

  field   :name,          type: String
  field   :role,          type: Symbol

end
```

When accessing the model info:

```ruby
book = Book.new(name: 'Lord of the Rings', internal_id: 1234567)
librarian = User.new(name: 'Tony', role: :librarian)
customer = User.new(name: 'Bob', role: :customer)

book.info               # { :name => "Lord of the Rings", :internal_id => 1234567 }
book.info(librarian)    # { :name => "Lord of the Rings", :internal_id => 1234567 }
book.info(customer)     # { :name => "Lord of the Rings" }
```

### Controllers
On controllers, you can include `Gatekeeper::Respondable` to generate automatic responses for your HTML, JS, or JSON views. These responses contains information based on the `allowed_info` method specified in your models.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
