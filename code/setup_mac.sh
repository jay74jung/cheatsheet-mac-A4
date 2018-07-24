#!/usr/bin/env bash -e
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT
## https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: setup_mac.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-12-04>
## Updated: Time-stamp: <2018-07-18 16:24:46>
##-------------------------------------------------------------------
set -e

function brew_install() {
    echo "Brew install packages"
    brew cask install iterm2
    brew install gpg aspell w3m shadowsocks-libev wget imagemagick msmtp
    brew install telnet shellcheck go getmail tmux
    brew install python3 getmail
    brew install jq ansible
    brew install reattach-to-user-namespace
    brew cask install ngrok
}

function python_setup() {
    pip3 install pylint
}

function download_files() {
    echo "Download files"
    wget -O /usr/local/bin/gh-md-toc https://raw.githubusercontent.com/ekalinin/github-markdown-toc/master/gh-md-toc
    chmod a+x /usr/local/bin/gh-md-toc
    which gh-md-toc
}
function fix_gpg() {
    # https://github.com/Homebrew/homebrew-core/issues/14737
    brew install pinentry-mac
    echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
    killall gpg-agent
}

function fetch_email() {
    echo "Fetch emails"
    cp ~/Dropbox/private_data/emacs_stuff/backup_small/fetch_mail/.msmtprc ~/.msmtprc
    chmod 400 ~/.msmtprc
}

function create_crontab() {
    echo "Define crontab"
    # TODO
    # ~/Dropbox/private_data/emacs_stuff/backup_small/fetch_mail/fetch_mail.sh
    # ~/Dropbox/private_data/emacs_stuff/backup_small/hourly_cron.sh
    # ~/Dropbox/private_data/emacs_stuff/backup_small/monthly_cron.sh
    # ~/Dropbox/private_data/emacs_stuff/backup_small/weekly_cron.sh
}

function ssh_config() {
    if [ ! ~/.ssh/config ]; then
       ln ~/Dropbox/private_data/emacs_stuff/backup_small/ssh_key/config ~/.ssh/config
    fi
    chmod 600 ~/Dropbox/private_data/emacs_stuff/backup_small/ssh_key/aws/denny-ssh-key1
    chmod 600 ~/Dropbox/private_data/emacs_stuff/backup_small/ssh_key/id_rsa.txt
    for f in $(find ~/Dropbox/private_data/emacs_stuff/backup_small/ssh_key -name "*_id_rsa"); do
        echo "chmod 600 $f"
        chmod 600 $f
    done
}

function config_bashrc() {
    if [ ! -f ~/.zshrc ]; then
        # https://github.com/robbyrussell/oh-my-zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    if [ ! ~/.bashrc ]; then
       ln ~/Dropbox/private_data/emacs_stuff/backup_small/bashrc ~/.bashrc
    fi

create_crontab
ssh_config

download_files
brew_install
fetch_email
fix_gpg
## File: setup_mac.sh ends
