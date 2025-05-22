#!/usr/bin/env bash

################################### OH-MY-ZSH Settings ##########################################

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="roc"

plugins=(git zsh-syntax-highlighting node nvm web-search yum vundle urltools systemadmin docker python pip pyenv npm yarn)

if [[ -s $ZSH/oh-my-zsh.sh ]]; then
	source $ZSH/oh-my-zsh.sh
else
	autoload -U colors && colors
	echo "$bold_color$fg[red]Please visit 'https://github.com/robbyrussell/oh-my-zsh' and install oh-my-zsh."
fi

########################################## Env ##########################################

# Load NVM. Node version manager.
[[ -s "$HOME/.nvm/nvm.sh" ]] && source $HOME/.nvm/nvm.sh

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

########################################## Functions ##########################################

rp-file-toggle() {
	isVisible=$(defaults read com.apple.finder AppleShowAllFiles)

	# toggle visibility based on variables value
	if [[ $isVisible = FALSE ]]; then
		defaults write com.apple.finder AppleShowAllFiles TRUE
	else
		defaults write com.apple.finder AppleShowAllFiles FALSE
	fi

	killall Finder
}

rp-key() {
	cat $HOME/.ssh/id_rsa.pub && cat $HOME/.ssh/id_rsa.pub | pbcopy
	echo 'ssh public key copied.'
}

rp-ping() {
	ret=$(python -c "
import urlparse
s = '$1'
if s.find('://') < 0:
  s = 'http://' + s
host = urlparse.urlparse(s).netloc
print(host)
")
	ping $ret
}

rp-proxy-open() {
	export ALL_PROXY="http://127.0.0.1:1082"
	echo "http Proxy already open"
}

rp-proxy-close() {
	unset ALL_PROXY
	echo "http Proxy closed"
}

# 开启代理（HTTP/HTTPS/SOCKS5）
function rp-proxy-on() {
	NETWORK_SERVICE="Wi-Fi" # 默认网络接口名称（通常是 Wi-Fi）
	HTTP_PROXY="127.0.0.1"  # 替换为你的代理地址
	HTTP_PORT="8002"        # HTTP/HTTPS 代理端口
	SOCKS_PORT="1082"       # SOCKS5 代理端口

	# 设置并启用 HTTP 代理
	sudo networksetup -setwebproxy "$NETWORK_SERVICE" $HTTP_PROXY $HTTP_PORT
	sudo networksetup -setwebproxystate "$NETWORK_SERVICE" on

	# 设置并启用 HTTPS 代理
	sudo networksetup -setsecurewebproxy "$NETWORK_SERVICE" $HTTP_PROXY $HTTP_PORT
	sudo networksetup -setsecurewebproxystate "$NETWORK_SERVICE" on

	# 设置并启用 SOCKS5 代理
	sudo networksetup -setsocksfirewallproxy "$NETWORK_SERVICE" $HTTP_PROXY $SOCKS_PORT
	sudo networksetup -setsocksfirewallproxystate "$NETWORK_SERVICE" on

	# 设置绕过代理的地址（可选，根据需求修改）
	sudo networksetup -setproxybypassdomains "$NETWORK_SERVICE" 127.0.0.1 localhost

	echo "✅ 代理已启用 | HTTP/HTTPS: $HTTP_PROXY:$HTTP_PORT | SOCKS5: $HTTP_PROXY:$SOCKS_PORT"
}

# 关闭所有代理
function rp-proxy-off() {
	NETWORK_SERVICE="Wi-Fi"

	# 关闭 HTTP 代理
	sudo networksetup -setwebproxystate "$NETWORK_SERVICE" off

	# 关闭 HTTPS 代理
	sudo networksetup -setsecurewebproxystate "$NETWORK_SERVICE" off

	# 关闭 SOCKS5 代理
	sudo networksetup -setsocksfirewallproxystate "$NETWORK_SERVICE" off

	# 清空绕过代理列表（可选）
	sudo networksetup -setproxybypassdomains "$NETWORK_SERVICE" empty

	echo "❌ 代理已关闭"
}

########################################## Personal Profile ##########################################

[[ -s "$HOME/.alias" ]] && source $HOME/.alias
[[ -s "$HOME/.private.alias" ]] && source $HOME/.private.alias

export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
