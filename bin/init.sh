GIT_USER=alan163:5488142wt
init_code(){
    if [ ! -d ~/www/code ]; then
        git clone  https://$GIT_USER@bitbucket.org/yitao/familyfarm2-server-code.git ~/www/code
    fi

    if [ ! -d ~/www/conf ]; then
        git clone  https://$GIT_USER@bitbucket.org/yitao/familyfarm2-server-conf.git ~/www/conf
    fi

    if [ ! -d ~/www/pmconf ]; then
        git clone  https://$GIT_USER@bitbucket.org/yitao/familyfarm2-server-pmconf.git ~/www/pmconf
    fi

    if [ ! -d ~/www/code/public/tools ]; then
        git clone  https://$GIT_USER@bitbucket.org/yitao/familyfarm2-server-tools.git ~/www/code/public/tools
    fi

    checkout_git
}

update_code(){
    if [ -d ~/www/code ]; then
        cd ~/www/code && git pull
    fi

    if [ -d ~/www/conf ]; then
        cd ~/www/conf && git pull
    fi

    if [ -d ~/www/pmconf ]; then
        cd ~/www/pmconf && git pull
    fi

    if [ -d ~/www/code/public/tools ]; then
        cd ~/www/code/public/tools && git pull
    fi
    checkout_git
}

checkout_git() {
    cd ~/www/code && git checkout dev
    cd ~/www/conf && git checkout dev
    cd ~/www/pmconf && git checkout dev
    cd ~/www/code/public/tools && git checkout dev

    ip=$(ifconfig docker0 |grep "inet addr"| cut -f 2 -d ":"|cut -f 1 -d " ")
    find ~/www/conf/ -name '*.php' | xargs sed -i "s|127.0.0.1|$ip|g"
    find ~/www/conf/ -name '*.php' | xargs sed -i "s|localhost|$ip|g"
    sed -i "s|'log_path'.*|'log_path' => '/nginx/log/',|g" ~/www/conf/farm_mobile/log.php
    sed -i "s|'replicaSet'.*||g" ~/www/conf/farm_mobile/*.php
}
