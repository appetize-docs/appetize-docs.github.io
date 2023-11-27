# Appetize Developer Center 

Welcome to the Developer Center for Appetize! This repository is designed to guide you through setting up your store in the Connect back office, configuring menus, and setting API-specific settings. It includes step-by-step guides, API references, and sections on common API considerations like versioning and Postman Collections. Additionally, you'll find information on how to obtain API access for security reasons and how to subscribe to release notes for timely updates on bug fixes and new features.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them:

- Ruby (managed by RVM)
- Bundler
- Jekyll

### Installation

A step-by-step series of examples that tell you how to get a development environment running:

1. **Clone the Repository**

 ```bash
   git clone https://github.com/appetize-docs/appetize-docs.github.io
   cd appetize-docs.github.io
 ```

2. **Set Up Ruby Environment**

   Use RVM to manage Ruby versions. The Makefile will automatically use the correct Ruby version for this project.

 ```bash
   make use-ruby
 ```

3. **Install Dependencies**

   Install the required Ruby gems (including Jekyll).

 ```bash
   make install-bundle
 ```

## Usage

Here's how you can use the Makefile commands:

- **Start Jekyll Server**

```bash
  make serve
```

  This command starts the Jekyll server on port 3001 and watches for file changes. It ensures that the correct Ruby version is being used and that all dependencies are installed.

- **Clean Jekyll Build**

```bash
  make clean
```

  Use this command to clean the Jekyll build, removing any generated files and caches.

- **Update Bundler and Gems**

```bash
  make update
```

  This command updates both Bundler and all the gems to their latest versions.

## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
