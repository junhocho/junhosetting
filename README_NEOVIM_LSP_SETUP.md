# Neovim LSP 설정 가이드

이 문서는 Vimscript 기반 레거시 설정에서 Mason + LSP 기반 현대적 Neovim 설정으로 마이그레이션하는 전체 과정을 정리합니다.

## 📋 프로젝트 상태

- **마이그레이션 시작**: 2025-01-25
- **현재 상태**: ✅ 완료 (macOS, Linux 모두 확인)
- **설정 파일**: `~/junhosetting/init.lua`
- **설정 방식**: `~/.config/nvim/init.lua`에서 자동으로 로드
- **호환성 확인**: macOS (2025-01-25), Linux (2025-01-26)

## ⚠️ 시스템 요구사항

- **Neovim 버전**: 0.8.0 이상 필수 (lazy.nvim 요구사항)
- **Git 버전**: 2.19.0 이상 (partial clones 지원)
- **운영체제별 주의사항**:
  - Ubuntu 22.04 기본 저장소: Neovim 0.6.1 (❌ 업그레이드 필요)
  - Ubuntu 24.04 기본 저장소: Neovim 0.9.5 (✅ 사용 가능)
  - macOS (Homebrew): 최신 버전 (✅ 사용 가능)

## 🔄 마이그레이션 개요

### 주요 변경사항

| 구성 요소 | 기존 (vim-plug + Vimscript) | 새로운 설정 (lazy.nvim + Lua) |
|---------|---------------------------|---------------------------|
| 플러그인 매니저 | vim-plug | lazy.nvim |
| 설정 언어 | Vimscript | Lua |
| 자동완성 | completor.vim | nvim-cmp + LSP |
| 문법 검사 | syntastic | Mason + LSP + none-ls |
| Python 하이라이팅 | semshi | nvim-treesitter |
| 파일 검색 | ctrlp.vim | telescope.nvim |
| 파일 트리 | NERDTree | nvim-tree.lua |
| 상태바 | vim-airline | lualine.nvim |
| 버퍼 관리 | 기본 버퍼 명령 | bufferline.nvim |

### 달성 목표

- ✅ 외부 시스템 의존성 제거 (Python/Node 직접 설치 불필요)
- ✅ LSP 기반 지능형 코드 분석
- ✅ 더 빠른 시작 시간과 응답 속도
- ✅ 기존 키 매핑 최대한 유지
- ✅ 점진적 마이그레이션 가능한 구조

## 🛠️ 수행한 작업 내역

### 1. 설정 파일 변환
- `vimrc` (Vimscript) → `init.lua` (Lua) 전환
- 기존 설정과 키 매핑 보존
- Neovim 전용 최적화 적용

### 2. 플러그인 시스템 현대화
```lua
-- lazy.nvim 설치 및 설정
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
```

### 3. LSP 및 자동완성 설정
- **Mason**: LSP 서버 자동 관리
- **nvim-cmp**: 지능형 자동완성
- **none-ls**: 외부 린터/포매터 통합

### 4. 해결한 문제들
1. **init.vim과 init.lua 충돌**: 기존 init.vim 백업 처리
2. **호환되지 않는 옵션**: `nocompatible` 제거 (Neovim에서 불필요)
3. **iron.nvim 설정 오류**: 적절한 config 객체 전달
4. **mason-lspconfig API 변경**: 새로운 API에 맞게 수정
5. **none-ls 린터 누락**: 조건부 로딩으로 해결, flake8 경고는 제거
6. **vim-prosession 의존성**: dependencies 설정으로 해결
7. **lualine 버퍼 표시**: tabline 설정과 아이콘 비활성화로 개선
8. **버퍼 순서 이동 문제**: bufferline.nvim 도입으로 해결
9. **Python 구문 하이라이팅**: semshi 대신 nvim-treesitter 도입
10. **파일 검색 개선**: ctrlp.vim에서 telescope.nvim으로 전환
11. **nvim-tree 도입**: NERDTree에서 nvim-tree.lua로 전환
12. **Pyright workspace/symbol 미지원**: grep 기반 검색으로 대체

### 5. 개발 도구 설치
```bash
# Python 도구
pip install black isort pylint flake8

# Node.js 도구  
npm install -g prettier

# Rust 도구
cargo install stylua
```

## 🚀 설치 방법

### 0. Neovim 버전 확인 및 업그레이드 (중요!)
```bash
# 버전 확인
nvim --version

# Ubuntu 22.04에서 최신 버전 설치 (기본 저장소는 0.6.1이므로 업그레이드 필요)
# 방법 1: PPA 사용
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

# 방법 2: Snap 사용 (최신 버전)
sudo snap install nvim --classic

# 방법 3: AppImage 사용
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo mv squashfs-root /opt/nvim
sudo ln -s /opt/nvim/AppRun /usr/local/bin/nvim
```

### 1. 기존 설정 백업 (선택사항)
```bash
cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
```

### 2. Neovim 설정 파일 생성
```bash
# ~/.config/nvim/init.lua 생성
echo "-- junhosetting의 init.lua를 불러오기" > ~/.config/nvim/init.lua
echo "vim.cmd('luafile ~/junhosetting/init.lua')" >> ~/.config/nvim/init.lua
```

### 3. Neovim 실행
```bash
nvim
# 첫 실행 시 플러그인이 자동으로 설치됩니다
```

## 📚 사용 방법

### 기본 키 매핑

#### LSP 기능 (언어 서버 활성 시)
- `gd` - 정의로 이동
- `gD` - 선언으로 이동
- `K` - 호버 정보 표시
- `gi` - 구현으로 이동
- `gr` - 참조 찾기
- `<leader>rn` - 심볼 이름 변경
- `<leader>ca` - 코드 액션
- `<leader>f` - 코드 포매팅
- `gl` - 진단 메시지 보기
- `[d` - 이전 진단으로
- `]d` - 다음 진단으로

#### Python 함수 검색 (⭐ 새로 추가)
- `<leader>lf` (,lf) - 현재 파일의 함수/클래스 목록 (아웃라인)
- `<leader>pf` (,pf) - 함수명 입력해서 정의 검색
- `<leader>pF` (,pF) - 현재 단어로 함수 정의 검색
- `<leader>gf` (,gf) - 현재 단어가 사용된 모든 곳 검색
- `<leader>go` (,go) - 현재 파일 구조 보기
- `:PyDef <함수명>` - Python 함수/클래스 정의 찾기
- `:Grepn <패턴>` - grep 스타일 검색 (라인 번호 포함)
- `:Outline` - 현재 파일 구조 보기

#### Telescope 검색 (파일/텍스트)
- `<C-p>` - 파일 찾기 (파일명으로)
- `<leader>ff` (,ff) - 파일 찾기
- `<leader>fg` (,fg) - 텍스트 검색 (프로젝트 전체)
- `<leader>fb` (,fb) - 열린 버퍼 검색
- `<leader>fh` (,fh) - 도움말 검색
- `<leader>fr` (,fr) - 최근 파일
- `<leader>fs` (,fs) - 현재 단어로 텍스트 검색
- `<leader>fc` (,fc) - 명령어 검색
- `<leader>fk` (,fk) - 키맵 검색

#### Git 관련 (Telescope)
- `<leader>gf` (,gf) - Git 파일
- `<leader>gc` (,gc) - Git 커밋
- `<leader>gb` (,gb) - Git 브랜치
- `<leader>gs` (,gs) - Git 상태

#### LSP + Telescope 통합
- `<leader>ld` (,ld) - 정의로 이동
- `<leader>lr` (,lr) - 참조 찾기
- `<leader>ls` (,ls) - 문서 심볼
- `<leader>lw` (,lw) - 작업공간 심볼
- `<leader>le` (,le) - 진단 정보

#### 파일 탐색 (nvim-tree)
- `<F1>` - 파일 트리 토글
- `<F5>` - 파일 트리 새로고침
- `<leader>e` (,e) - 파일 트리에 포커스
- `<leader>fc` (,fc) - 현재 파일을 트리에서 찾기

#### 진단 도구
- `<leader>xx` - Trouble 토글 (모든 진단)
- `<leader>xw` - 워크스페이스 진단
- `<leader>xd` - 현재 문서 진단

#### 기존 키 매핑 (유지됨)
- `,` - Leader 키
- `L` - 현재 위치에서 줄 나누기
- `<F3>` / `<C-s>` - 파일 저장
- `<F4>` - 공백 문자 제거
- `<F6>` - 수직 분할
- `<F7>` - 수평 분할
- `<F8>` - SrcExpl 토글
- `<F9>` - Tagbar 토글
- `<C-l>` - Clean mode 토글 (복사 시 UI 요소 숨기기)

#### 버퍼 관리 (bufferline.nvim)
- `<leader>'` (,') - 다음 버퍼로 이동 (표시된 순서)
- `<leader>;` (,;) - 이전 버퍼로 이동 (표시된 순서)
- `<leader><` (,<) - 현재 버퍼를 왼쪽으로 이동
- `<leader>>` (,>) - 현재 버퍼를 오른쪽으로 이동
- `<leader>1` ~ `<leader>9` (,1 ~ ,9) - 버퍼 번호로 직접 이동
- `<leader>T` (,T) - 새 버퍼 열기
- `<leader>bq` (,bq) - 현재 버퍼 닫기
- `<leader>bl` (,bl) - 버퍼 목록 보기

### Mason 명령어
- `:Mason` - Mason UI 열기
- `:LspInfo` - 현재 버퍼의 LSP 상태 확인
- `:Lazy` - 플러그인 관리자 UI

### Python 함수 검색 팁
터미널에서 `grepn "connect_on_off_entry"`로 검색하던 것을 이제 Neovim 내에서:

1. **가장 정확한 방법**: `gd` (정의로 바로 이동)
2. **함수 정의 찾기**: `:PyDef connect_on_off_entry`
3. **현재 파일 구조**: `<leader>lf` 또는 `:Outline`
4. **텍스트 검색**: `<leader>fg`로 전체 프로젝트 검색

**pyright가 workspace/symbol을 지원하지 않는 이유**: 
- Microsoft가 인덱싱 기능을 VS Code 전용 Pylance에만 제공
- 대신 grep 기반 검색으로 충분히 대체 가능

## 🔧 추가 설정

### 언어 서버 추가
`init.lua`의 `ensure_installed`에 추가:
```lua
ensure_installed = { 
  "pyright",        -- Python
  "lua_ls",         -- Lua
  "tsserver",       -- TypeScript/JavaScript
  "rust_analyzer",  -- Rust
  "gopls",          -- Go
},
```

### 문제 해결

#### Python 환경 문제
Flask 등의 패키지를 import할 때 오류가 발생하면:

1. **진단 확인**:
   ```vim
   :LspInfo
   ```

2. **해결 방법**:
   프로젝트 루트에 `pyrightconfig.json` 생성:
   ```bash
   # Python 버전 확인
   python --version
   
   # site-packages 경로 확인
   python -c "import site; print(site.getsitepackages()[0])"
   ```
   
   위 정보를 바탕으로 `pyrightconfig.json` 작성 (위의 예시 참조)

#### 플러그인 문제
```vim
:Lazy  " 플러그인 상태 확인
:Lazy update  " 플러그인 업데이트
```

#### Neovim 버전 문제
Ubuntu 22.04 사용자의 경우 "module 'vim.loader' not found" 등의 오류가 발생하면:
```bash
# 현재 버전 확인
nvim --version  # 0.6.1이면 업그레이드 필요

# 위의 "Neovim 버전 확인 및 업그레이드" 섹션 참조
```

#### 원래 설정으로 복구
```bash
mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.mason
cp ~/.config/nvim/init.vim.backup ~/.config/nvim/init.vim
```

## ⚠️ 알려진 이슈 및 시행착오

### 1. Pyright와 Conda 환경 충돌
**문제**: Pyright가 conda 환경의 패키지를 인식하지 못함 (예: Flask import 오류)

**시도한 해결책들**:
- Python 경로 동적 탐지 함수 구현
- `before_init`, `on_init`, `on_new_config` 훅 사용
- `extraPaths`에 site-packages 경로 추가
- `.python-version` 파일 생성

**현재 상태**: ✅ 해결 - 프로젝트별로 `pyrightconfig.json` 생성으로 완벽히 해결됨

**해결 방법**:
프로젝트 루트에 `pyrightconfig.json` 파일을 생성합니다:

```json
{
  "venvPath": "/Users/junho/opt/anaconda3",
  "venv": ".",
  "pythonVersion": "3.8",
  "executionEnvironments": [
    {
      "root": ".",
      "pythonVersion": "3.8",
      "pythonPlatform": "Darwin",
      "extraPaths": [
        "/Users/junho/opt/anaconda3/lib/python3.8/site-packages"
      ]
    }
  ],
  "typeCheckingMode": "basic",
  "useLibraryCodeForTypes": true,
  "autoImportCompletions": true,
  "autoSearchPaths": true
}
```

**설정 설명**:
- `venvPath`: Conda 설치 경로
- `pythonVersion`: 사용 중인 Python 버전
- `extraPaths`: site-packages 경로를 명시적으로 지정
- `typeCheckingMode`: "basic"으로 설정하여 과도한 타입 체크 방지

이 파일을 생성하면 Pyright가 즉시 conda 환경의 모든 패키지를 정상적으로 인식합니다.

### 2. none-ls flake8 경고
**문제**: flake8이 없어도 매번 경고 메시지 출력

**해결**: flake8 체크를 제거하고 pyright만 사용하도록 설정

### 3. nvim-treesitter 설치 오류
**문제**: Python 파서 설치 시 간헐적 tarball 추출 오류

**원인**: 네트워크 일시 장애 또는 동시 설치 충돌

**해결**: 자동 재시도로 대부분 해결됨. 수동 설치 필요시:
```vim
:TSInstall python
```

### 4. Linux에서 mason-lspconfig 버전 충돌
**문제**: mason-lspconfig v2.0이 Neovim 0.11.0-dev에서 `vim.lsp.enable()` 함수 미지원

**해결**: 
- mason-lspconfig을 v1.x로 버전 고정 (`version = "^1.0"`)
- `automatic_installation` 설정 제거하여 양 OS 호환성 확보

### 5. semshi Python 구문 하이라이터 호환성
**문제**: Python 3.12에서 semshi 플러그인 오류 발생

**해결**: semshi 제거하고 nvim-treesitter의 Python 파서 사용

## 🚀 다음 단계 추천

### 1. 추가 최적화 가능한 플러그인
- ~~**파일 탐색**: NERDTree → nvim-tree.lua~~ ✅ 완료
- ~~**검색**: ctrlp.vim → telescope.nvim~~ ✅ 완료
- **Git**: vim-signify → gitsigns.nvim (검토 중)

### 2. Tree-sitter 활성화
구문 하이라이팅 개선을 위해:
```lua
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
```

### 3. 디버깅 도구 추가
DAP (Debug Adapter Protocol) 지원:
```lua
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
```

## 📖 참고 자료

- [Mason.nvim 공식 문서](https://github.com/williamboman/mason.nvim)
- [nvim-cmp 설정 가이드](https://github.com/hrsh7th/nvim-cmp)
- [Neovim LSP 문서](https://neovim.io/doc/user/lsp.html)
- [lazy.nvim 문서](https://github.com/folke/lazy.nvim)
- [bufferline.nvim 문서](https://github.com/akinsho/bufferline.nvim)
- [lualine.nvim 문서](https://github.com/nvim-lualine/lualine.nvim)

---

**마이그레이션 완료!** 🎉

이제 현대적인 Neovim 개발 환경을 사용할 수 있습니다. 문제가 발생하거나 추가 기능이 필요하면 위의 가이드를 참조하세요.