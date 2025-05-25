# Neovim LSP 설정 가이드

이 문서는 Vimscript 기반 레거시 설정에서 Mason + LSP 기반 현대적 Neovim 설정으로 마이그레이션하는 전체 과정을 정리합니다.

## 📋 프로젝트 상태

- **마이그레이션 시작**: 2025-01-25
- **현재 상태**: ✅ 완료
- **설정 파일**: `~/junhosetting/init.lua`
- **설정 방식**: `~/.config/nvim/init.lua`에서 자동으로 로드

## 🔄 마이그레이션 개요

### 주요 변경사항

| 구성 요소 | 기존 (vim-plug + Vimscript) | 새로운 설정 (lazy.nvim + Lua) |
|---------|---------------------------|---------------------------|
| 플러그인 매니저 | vim-plug | lazy.nvim |
| 설정 언어 | Vimscript | Lua |
| 자동완성 | completor.vim | nvim-cmp + LSP |
| 문법 검사 | syntastic | Mason + LSP + none-ls |
| Python 하이라이팅 | semshi | nvim-treesitter |
| 파일 검색 | ctrlp.vim | ctrlp.vim (유지) |
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

#### 진단 도구
- `<leader>xx` - Trouble 토글 (모든 진단)
- `<leader>xw` - 워크스페이스 진단
- `<leader>xd` - 현재 문서 진단

#### 기존 키 매핑 (유지됨)
- `,` - Leader 키
- `<F1>` - NERDTree 토글
- `<F3>` / `<C-s>` - 파일 저장
- `<F4>` - 공백 문자 제거
- `<F8>` - SrcExpl 토글
- `<F9>` - Tagbar 토글

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
```vim
:LspInfo
```
로 상태 확인 후 conda 환경 설정 확인

#### 플러그인 문제
```vim
:Lazy  " 플러그인 상태 확인
:Lazy update  " 플러그인 업데이트
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

**현재 상태**: 미해결. 프로젝트별로 `pyrightconfig.json` 생성이 가장 확실한 해결책이지만, 매번 생성하기 번거로움

**임시 해결책**:
```json
// 프로젝트 루트에 pyrightconfig.json 생성
{
  "venvPath": "/Users/junho/opt/anaconda3",
  "venv": ".",
  "pythonVersion": "3.8"
}
```

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

## 🚀 다음 단계 추천

### 1. 추가 최적화 가능한 플러그인
- **파일 탐색**: NERDTree → nvim-tree.lua 또는 neo-tree.nvim
- **검색**: ctrlp.vim → telescope.nvim
- **Git**: vim-signify → gitsigns.nvim

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