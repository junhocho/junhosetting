# 클립보드 공유 가이드 (SSH + tmux + Neovim)

이 문서는 로컬과 원격 서버 간에 클립보드를 공유하는 방법을 설명합니다.

## 📋 개요

SSH로 원격 서버에 접속하여 tmux와 Neovim을 사용할 때, 로컬 컴퓨터의 클립보드와 원격 서버의 클립보드를 통합하는 설정 가이드입니다.

### 지원 방식
1. **OSC 52**: 터미널 이스케이프 시퀀스를 통한 클립보드 공유
2. **X11 포워딩**: X11 프로토콜을 통한 클립보드 공유
3. **tmux 버퍼**: tmux 내부 버퍼를 통한 복사/붙여넣기

## 🖥️ 로컬 설정 (macOS/Linux)

### 1. 터미널 에뮬레이터 확인

#### 지원하는 터미널 (OSC 52)
- **iTerm2** (macOS)
  - Preferences → General → Selection → "Applications in terminal may access clipboard" ✓
- **kitty**
- **WezTerm**
- **Windows Terminal**

#### 지원하지 않는 터미널
- Terminal.app (macOS 기본 터미널)
- 오래된 버전의 gnome-terminal

### 2. SSH 클라이언트 설정

`~/.ssh/config` 파일에 추가:

```bash
Host myserver
    HostName 192.168.1.100
    User junho
    # X11 포워딩 활성화 (OSC 52가 안 될 때 대안)
    ForwardX11 yes
    ForwardX11Trusted yes
    # SSH 연결 유지
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

## 🖥️ 원격 서버 설정 (Ubuntu 22.04)

### 1. 필요한 패키지 설치

```bash
# tmux 최신 버전 설치 (3.3a 이상 필요)
sudo apt update
sudo apt install tmux

# X11 클립보드 도구 (OSC 52 대안)
sudo apt install xclip xsel

# Neovim 설치
sudo apt install neovim
```

### 2. SSH 서버 설정 (선택사항)

X11 포워딩을 사용하려면 `/etc/ssh/sshd_config` 편집:

```bash
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
```

변경 후 SSH 서비스 재시작:
```bash
sudo systemctl restart sshd
```

### 3. tmux 설정

`~/junhosetting/tmux.conf`에 이미 포함된 설정:

```bash
# Vi 모드 활성화
setw -g mode-keys vi

# 클립보드 설정
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

# OSC 52 지원
set -g set-clipboard on

# 플랫폼별 클립보드 명령
if-shell "uname | grep -q Darwin" \
  "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'"
if-shell "uname | grep -q Linux && command -v xclip > /dev/null" \
  "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'"
```

### 4. Neovim 설정

`~/junhosetting/init.lua`에 이미 포함된 설정:

```lua
-- 시스템 클립보드 사용
vim.opt.clipboard = "unnamedplus"

-- SSH 환경에서 tmux 클립보드 통합
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
  if vim.env.TMUX then
    vim.g.clipboard = {
      name = "tmux",
      copy = {
        ["+"] = {"tmux", "load-buffer", "-"},
        ["*"] = {"tmux", "load-buffer", "-"},
      },
      paste = {
        ["+"] = {"tmux", "save-buffer", "-"},
        ["*"] = {"tmux", "save-buffer", "-"},
      },
      cache_enabled = true,
    }
  end
end

-- OSC 52 플러그인 (lazy.nvim에 추가됨)
{
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({
      max_length = 0,
      silent = false,
      trim = false,
    })
    -- Visual 모드에서 <leader>c로 복사
    vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
  end
}
```

## 🧪 테스트 방법

### 1. OSC 52 지원 확인

로컬 터미널에서:
```bash
# OSC 52 테스트 (터미널이 지원하면 클립보드에 "Hello OSC52" 복사됨)
printf "\033]52;c;$(printf "Hello OSC52" | base64)\a"

# macOS에서 확인
pbpaste  # "Hello OSC52"가 출력되면 성공

# Linux에서 확인
xclip -o -selection clipboard
```

### 2. SSH + tmux 테스트

```bash
# 1. SSH 접속
ssh myserver

# 2. tmux 실행
tmux new -s test

# 3. tmux 버전 확인 (3.3a 이상 필요)
tmux -V

# 4. tmux 복사 모드 테스트
echo "Test tmux clipboard"
# Ctrl-a [ 로 복사 모드 진입
# v로 선택 시작
# 텍스트 선택
# y로 복사

# 5. 로컬에서 붙여넣기 테스트
# Cmd+V (macOS) 또는 Ctrl+V (Linux)
```

### 3. Neovim 테스트

```bash
# tmux 세션 내에서
nvim test.txt

# 1. 일반 모드에서 텍스트 입력
i
Hello from Neovim
ESC

# 2. 시스템 클립보드로 복사
# 라인 전체 복사
"+yy

# 또는 Visual 모드에서
V
"+y

# 또는 OSC 52 사용 (Visual 모드)
v
,c  # <leader>c

# 3. 로컬에서 붙여넣기 확인
# 로컬 터미널이나 다른 앱에서 Cmd+V/Ctrl+V
```

### 4. 통합 테스트 시나리오

```bash
# 1. 로컬에서 텍스트 복사
echo "Local clipboard test" | pbcopy  # macOS
echo "Local clipboard test" | xclip -selection clipboard  # Linux

# 2. SSH 접속 후 tmux 실행
ssh myserver
tmux

# 3. Neovim에서 붙여넣기
nvim
# Normal 모드에서
"+p

# 4. Neovim에서 새 텍스트 작성 후 복사
i
Remote server text
ESC
"+yy

# 5. 로컬에서 확인
# 로컬 터미널 새 탭에서
pbpaste  # "Remote server text" 출력되면 성공
```

## 🔧 문제 해결

### OSC 52가 작동하지 않을 때

1. **tmux 버전 확인**
   ```bash
   tmux -V  # 3.3a 이상 필요
   ```

2. **터미널 설정 확인**
   - iTerm2: Preferences → General → Selection → clipboard 권한 확인

3. **대안: X11 포워딩 사용**
   ```bash
   # SSH 접속 시 -X 옵션 추가
   ssh -X myserver
   
   # DISPLAY 환경 변수 확인
   echo $DISPLAY  # 값이 있어야 함
   ```

### 복사가 안 될 때 체크리스트

1. **로컬 → 원격**
   - [ ] SSH X11 포워딩 활성화 확인
   - [ ] xclip/xsel 설치 확인
   - [ ] DISPLAY 환경 변수 설정 확인

2. **원격 → 로컬**
   - [ ] 터미널의 OSC 52 지원 확인
   - [ ] tmux `set-clipboard` 설정 확인
   - [ ] Neovim OSC 52 플러그인 설치 확인

### 디버깅 명령어

```bash
# Neovim 클립보드 상태 확인
:checkhealth provider

# tmux 클립보드 버퍼 확인
tmux show-buffer

# X11 포워딩 테스트
xsel -b <<< "X11 test"
xsel -b  # 출력 확인

# OSC 52 직접 테스트
echo -ne "\033]52;c;$(echo -n "Direct OSC52 test" | base64)\a"
```

## 📚 참고 자료

- [OSC 52 Escape Sequences](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Operating-System-Commands)
- [tmux clipboard integration](https://github.com/tmux/tmux/wiki/Clipboard)
- [nvim-osc52 plugin](https://github.com/ojroques/nvim-osc52)
- [Neovim clipboard provider](https://neovim.io/doc/user/provider.html#clipboard)

## 💡 팁

1. **가장 간단한 설정**: iTerm2 + tmux 3.3a + OSC 52
2. **가장 안정적인 설정**: SSH X11 포워딩 + xclip
3. **tmux 없이 사용**: Neovim에서 직접 OSC 52 사용 (`,c`)
4. **대용량 텍스트**: OSC 52는 크기 제한이 있을 수 있으므로 X11 포워딩 권장

---

문제가 있거나 추가 설정이 필요하면 이 문서를 참고하여 단계별로 확인하세요.