#!/bin/bash
set -e

# 진행 중 멈추지 않게 깃 사용자 정보 미리 입력받기
read -p "username for gitconfig: " username
read -p "email for gitconfig: " useremail
echo "🎉 감사. 설치 시작\!"

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "🎉 양조장 설치\!"

# set up homebrew PATH
export PATH=/opt/homebrew/bin:$PATH
export GITHUB_RAW_URL="https://raw.githubusercontent.com/catenoid-jeongmin/install.sh/main"

# run brew bundle
if [ ! -f "Brewfile" ]; then
  curl -O "$GITHUB_RAW_URL/Brewfile"
fi
brew bundle --verbose --no-lock
echo "🎉 맥주 양조 다 됨\!"

# set up git config
git config --global user.name $username
git config --global user.email $useremail
git config --global core.editor "code --wait"
git config --global pull.ff true
git config --global fetch.prune true
git config --global push.autoSetupRemote true
echo "🎉 깃 설정 끝\!"

# add ssh-agent to zprofile for booting
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
echo "🎉 sshkey 생성 끝\!"

# create project directory
mkdir ~/Projects
echo "🎉 ~/Projects 디렉토리 생성!"

# set up vscode preferences and extensions
if [ ! -f "vscode_settings.json" ]; then
  curl -O "$GITHUB_RAW_URL/vscode_settings.json"
fi
mv vscode_settings.json ~/Library/Application\ Support/Code/User/settings.json
echo "🎉 vscode 설정 복사 완료\!"

curl -o "iTerm State.itermexport" "$GITHUB_RAW_URL/iTerm2%20State.itermexport"
echo "🎉 iterm 설정파일 복사\!"

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
echo "🎉 앱들염\!"

# set up zsh
cat << 'EOF' >> ~/.zprofile
eval `ssh-agent -s`

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# zsh completion 모음 자동 로드 설정
fpath=($fpath ~/.zsh/completion)
autoload -U compinit
compinit

# alias 설정
alias k=kubectl
alias dk=docker
alias ne=nerdctl
alias eks=eksctl
EOF
echo "🎉 zsh 설정 추가됨\!"

# p10k 설치
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# zsh 기본 테마값 변경
sed -i '' 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
echo "🎉 powerlevel10k 설치됨\!"

read -p "oh-my-zsh을 설치합니다. 설치 후 창이 닫힙니다. 계속 하시겠습니까? (y/n): " user_input
# install oh-my-zsh
if [ "$user_input" = "y" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "🎉 ~~완료~~ 🎉"
fi
