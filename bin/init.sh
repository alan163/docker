if [ ! -d "~/www/code"]; then
    git clone  https://alan163:5488142wt@bitbucket.org/yitao/familyfarm2-server-code.git ~/www/code
else
    cd ~/www/code && git pull
fi

if [ ! -d "~/www/conf"]; then
    git clone  https://alan163:5488142wt@bitbucket.org/yitao/familyfarm2-server-conf.git ~/www/conf
else
    cd ~/www/conf && git pull
fi

if [ ! -d "~/www/pmconf"]; then
    git clone  https://alan163:5488142wt@bitbucket.org/yitao/familyfarm2-server-pmconf.git ~/www/pmconf
else
    cd ~/www/pmconf && git pull
fi

if [ ! -d "~/www/code/public/tools"]; then
    git clone  https://alan163:5488142wt@bitbucket.org/yitao/familyfarm2-server-tools.git ~/www/code/public/tools
else
    cd ~/www/code/public/tools && git pull
fi

cd ~/www/code && git checkout dev
cd ~/www/conf && git checkout dev
cd ~/www/pmconf && git checkout dev
cd ~/www/code/public/tools && git checkout dev

ip=$(ifconfig docker0 |grep "inet addr"| cut -f 2 -d ":"|cut -f 1 -d " ")
find ~/conf/ -name '*.php' | xargs perl -pi -e "s|127.0.0.1|$ip|g"
find ~/conf/ -name '*.php' | xargs perl -pi -e "s|localhost|$ip|g"
