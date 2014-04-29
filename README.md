# Install Development Environment

## Installation:

### MacOS

#### Install Homebrew

First, install [Homebrew](http://brew.sh/).

```
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
```

#### Install Virtualbox and Vagrant

Install VirtualBox and Vagrant using [Brew Cask](https://github.com/phinze/homebrew-cask).

```
brew tap phinze/homebrew-cask
brew install brew-cask
brew cask install virtualbox
brew cask install vagrant
```

##  Install BV Env
```
git clone https://github.com/alan163/docker
cd docker
sh setup.sh
```

## Retart BV Env

```
./bin/dev restart
```

## Stop BV Env

```
./bin/dev stop
```


## Update BV code

```
./bin/dev update
```

## Update BV env (lnmp)

```
./bin/dev update_all
vagrant reload
```

## See Log

```
vagrant ssh
cd ~/apps/
```

