#!/bin/bash
set -e

# 진행 중 멈추지 않게 깃 사용자 정보 미리 입력받기
read -p "username for gitconfig: " username
read -p "email for gitconfig: " useremail
echo "🎉 감사. 설치 시작!"

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "🎉 양조장 설치!"

# set up homebrew PATH
export PATH=/opt/homebrew/bin:$PATH
export GITHUB_RAW_URL="https://raw.githubusercontent.com/username/repo/main"

# run brew bundle
curl -O "$GITHUB_RAW_URL/Brewfile"
brew bundle --verbose --no-lock
echo "🎉 맥주 양조 다 됨!"

# set up git config
git config --global user.name $username
git config --global user.email $useremail
git config --global core.editor "code --wait"
git config --global pull.ff true
git config --global fetch.prune true
git config --global push.autoSetupRemote "always"
echo "🎉 깃 설정 끝!"

# add ssh-agent to zprofile for booting
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
echo "🎉 sshkey 생성 끝!"

# create project directory
mkdir ~/Projects
echo "🎉 ~/Projects 디렉토리 생성!"

# set up vscode preferences and extensions
curl -o "~/Library/Application\ Support/Code/User/settings.json $GITHUB_RAW_URL/vscode_settings.json"
echo "🎉 vscode 설정 복사 완료!"

curl -O "$GITHUB_RAW_URL/Iterm2 State.itermexport"
echo "🎉 iterm 설정파일 복사!"

# open app and stick to dock
open /Applications/Notion.app
open /Applications/Postman.app
open /Applications/Google\ Chrome.app
open /Applications/iTerm.app
open /Applications/Slack.app
open /Applications/Visual\ Studio\ Code.app
open /Applications/DBeaver.app/
open /Applications/ChatGPT.app/
open /Applications/Lens.app/
open /Applications/Karabiner-Elements.app/
open /Applications/Medis.app/
open /Applications/Rancher\ Desktop.app/
echo "🎉 앱들염!"

# install oh-my-zsh
echo 'eval `ssh-agent -s`' >> ~/.zprofile
echo 'export PATH=/opt/homebrew/bin:$PATH' >> ~/.zprofile
echo 'export PATH=/opt/homebrew/sbin:$PATH' >> ~/.zprofile
echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> ~/.zprofile

# zsh completion 모음 자동 로드 설정
cat << 'EOF' >> ~/.zprofile
fpath=($fpath ~/.zsh/completion)
autoload -U compinit
compinit
EOF

# alias 설정
cat << 'EOF' >> ~/.zprofile
alias k=kubectl
alias dk=docker
alias ne=nerdctl
alias eks="eksctl"
EOF
echo "🎉 zsh 설정 추가됨!"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "🎉 oh-my-zsh 설치. 닫혀도 놀라지마셔라!"

# p10k 설치
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# zsh 기본 테마값 변경
$ sed -i '' 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

echo "🎉 완료~~ 🎉"


