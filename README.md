# PlantZoner
A minimal content management system for keeping track of the plants you grow in any hardiness zone.

This application is designed to give gardeners/growers a simple, basic interface that anyone can use to keep track of individually grown plants. Some recordable attributes include the hardiness zone in which you are growing that plant, plant name, scientific name, & a link to an image of your individual plant. This is all combined into one simple "Garden" (or "Patch") to contain all the information in one place.

See what plants are being grown in other hardiness zones, you may be surprised to see someone growing a plant somewhere far from its native land!

## Summary

  - [Getting Started](#getting-started)
  - [Built With](#built-with)
  - [Contributing](#contributing)
  - [Authors](#authors)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Getting Started

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes.

### Prerequisites

What you'll need to get the project up-and-running:

    Bundler

### Installing

After forking the project:
Copy the SSH link, then in the desired directory, type:

    `git clone <SSH LINK HERE>'

then, cd into the directory and open the project in your text editor/development environment.

In the project's terminal, type:

    `bundle' > Installs necessary libraries/dependencies

Now, create a session_secret in order to ensure all users' passwords and private keys are safe from exploitation:
In the project's main directory, in the terminal, type (in order):

    `touch .env'
    `ruby -e "require 'securerandom'; puts SecureRandom.hex(40)"'

Copy the long string of random characters, then open the .env file and type:

    `AUTH_USER_PASSWORD = <INSERT CHARACTERS HERE>'

Now, all of your user passwords will be secure.

Unless the application is being accessed from an external server that has already been set-up, make sure you:

- Sign into the Trefle API's website, and request an API key
- Sign into GitHub's developer settings and request both a GitHub key and GitHub secret

Define these values in your .env the same way as the 'AUTH_USER_PASSWORD':
- API KEY =
- GITHUB KEY =
- GITHUB SECRET =

In the project's terminal, type (in order):

    `rake db:migrate' > Sets up the database & necessary tables
    `rake db:seed' > OPTIONAL: Fills the database with dummy data to provide a more immersive experience
    `rails s' > Starts the server on your local machine

After running 'rails s', take note of the port displayed in the terminal (usually 3000), then in your browser, go to "localhost:(PORT)"

## Built With
  - [Contributor Covenant](https://www.contributor-covenant.org/) - Used
    for Contributing section of README
  - [MIT License](LICENSE) - Used to choose
    the license

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fancybandit/PlantZoner This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Authors

  - **Jacob Klimenko** - *Created project in it's entirety* -
    [FancyBandit](https://github.com/fancybandit)

## License

This project is licensed under the [MIT](LICENSE) License - see the [LICENSE](LICENSE) file for
details

## Acknowledgments
  - Thank you to my coaches, Matteo & Katie, for helping me with keeping things on track through the creation of this project during a personally very demanding time.