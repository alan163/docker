# Install Development Environment

## Installation:

### MacOS

#### Install Homebrew

First, install [Homebrew](http://brew.sh/).

```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
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
git clone https://github.com/alan163/docker  <dev_dir>
cd  <dev_dir>
sh setup.sh

```
更新bv代码：

```
./bin/dev update
```

## Run dev start

Start the dev container:

```
./bin/dev start
```

You should see:

```
Started PHP in container 16797891a5ae6d633c1b7095416e2186b5ade80bd32ab126705edafe54c4af18
Started MYSQL in container 65447e0e636509cbcfd94bac2fe46f3cff8a04711c4bc1ea536f31f776273a90
Started REDIS in container 3b1ce1b0948b1b2aa39d7fc85c99850101af26a03aba0c05595844d21568faee
Started MEMCACHED in container 960f84de3d1ceeb1ef3fb5dedfa51c513e0d451512c0d778e63860fb3281977d
Started MONGO in container 73e779e46b0d9590b3c107885355d191bea9a42e6095e06978d4f3e447c1ef61
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

## FAQ
### 查看日志
```
cd <dev_dir>
vagrant ssh
cd ~/apps/
ll 
drwxr-xr-x 4 root root 4096 Apr 28 08:45 mongo #mongo 日志
drwxr-xr-x 4 root root 4096 Apr 28 08:35 mysql #mysql 日志
drwxr-xr-x 3 root root 4096 Apr 28 08:35 php   #php,nginx 日志
drwxr-xr-x 4 root root 4096 Apr 28 08:35 redis $redis 日志
```

### 开发过程中修改代码 
只需在本届修改<dev_dir>/www目录中的代码即可生效
（该目录自动挂载到docker中，先挂载到vagrant:~/www, 后再挂载到docker container的/code中）

### 修改环境配置
开发过程中, 调试修改环境参数, 可以直接修改images目录下对应的配置。
注意修改后，需要重启环境。（./bin/dev restart）
```
cd <dev_dir>
images/php/conf
drwxr-xr-x 4 root root 4096 Apr 28 08:35 mysql #mysql  配置
drwxr-xr-x 3 root root 4096 Apr 28 08:35 php   #php,nginx 配置
drwxr-xr-x 4 root root 4096 Apr 28 08:35 redis $redis 配置
```

### 查看lnmp环境运行状态
```
cd <dev_dir>
./bin/dev status
```



