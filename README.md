# 개발환경 자동 설정하기

## 터미널에서 실행해야 함

spotlight(Command-스페이스 바) 실행해서 terminal.app 실행

## 설정되는 것들

- Brewfile의 패키지들(vscode확장 포함)
- vscode 설정
- ssh 설정
  1. keygen으로 키 생성
  2. agent 설정
  3. 키 복사
- 깃 설정
  1. 이메일 및 사용자이름
  2. 기본 에디터를 vscode로
  3. pull.ff true로
  4. fetch 시 prune 실행
  5. push 시 원격 브랜치 자동 연결
- 홈 디렉토리에 프로젝트 디렉토리 생성
- zsh 확장커스텀 oh-my-zsh 설치
- p10k 설치
- .zshrc 추가 설정

## Installation

스크립트 실행

`$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/catenoid-jeongmin/install.sh/main/install.sh)"`

- 입력값
  1. 깃용 email
  2. 깃용 username

깃허브에서 사용할 ssh key를 클립보드에 복사되어 있으니 Settings / SSH and GPG keys 메뉴에서 New SSH key 버튼 누르고 붙여넣고 저장

## iTerm2 profile 변경

General / Settings / Import All Settings and Data 를 눌러 .itermexport 파일 로드
