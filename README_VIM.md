# Neovim Python Provider 설정

## 문제 상황
Neovim 실행 시 다음과 같은 에러 발생:
- `Completor requires vim compiled with python or python3`
- `Failed to load python3 host`
- `Error executing lua ... Failed to load python3 host`

## 원인
Neovim에서 Python 기반 플러그인(Completor, Semshi 등)을 사용하려면 `pynvim` 패키지가 필요합니다. 다음과 같은 경우 에러가 발생합니다:
1. `pynvim`이 설치되지 않음
2. Neovim이 올바른 Python 인터프리터를 찾지 못함
3. 여러 Python 설치(시스템 Python, Homebrew Python, Anaconda 등)가 충돌

## 해결 방법

### 1단계: pynvim 설치
macOS에서 Anaconda 사용 시:
```bash
~/opt/anaconda3/bin/python -m pip install pynvim
```

Linux에서 Anaconda 사용 시:
```bash
~/anaconda3/bin/python -m pip install pynvim
# 또는
~/miniconda3/bin/python -m pip install pynvim
```

Anaconda를 사용하지 않는 시스템:
```bash
python3 -m pip install --user pynvim
```

### 2단계: Neovim이 올바른 Python을 사용하도록 설정
`vimrc`에 다음 내용 추가 (이 저장소에는 이미 구현됨):

```vim
"=== NEOVIM ===
" Python3 host program (auto-detect)
if has('nvim')
  " 1. 환경변수 VIRTUAL_ENV 확인 (가상환경)
  if !empty($VIRTUAL_ENV)
    let g:python3_host_prog = $VIRTUAL_ENV . '/bin/python'
  " 2. conda 환경 확인
  elseif !empty($CONDA_PREFIX)
    let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
  " 3. 시스템별 기본값
  elseif has('mac') && isdirectory('/Users/junho/opt/anaconda3')
    let g:python3_host_prog = '/Users/junho/opt/anaconda3/bin/python'
  " 4. 그 외는 Neovim이 자동으로 찾도록 설정하지 않음
  endif
endif
```

이 설정의 특징:
- 가상환경 자동 감지
- conda 환경 자동 감지
- macOS에서 특정 경로로 폴백
- 다른 시스템에서는 Neovim이 자동 감지

### 3단계: 설정 확인
```bash
# Neovim이 사용하는 Python 확인
nvim -c ':echo g:python3_host_prog' -c ':qa'

# Python provider 상태 확인
nvim -c ':checkhealth provider' -c ':qa'
```

## 시스템별 참고사항

### macOS (현재 설정)
- Anaconda Python 사용: `/Users/junho/opt/anaconda3/bin/python`
- Python 버전: 3.8
- Anaconda의 pip로 pynvim 설치됨

### Linux (테스트 예정)
- `$CONDA_PREFIX`를 통해 conda 환경 자동 감지
- conda 환경이 없으면 시스템 Python으로 폴백
- 하드코딩된 경로 불필요

## 문제 해결

에러가 계속 발생하는 경우:
1. Neovim이 사용하는 Python 환경에 `pynvim`이 설치되었는지 확인
2. 로컬 설정에서 `g:python3_host_prog`를 명시적으로 설정
3. Neovim에서 `:checkhealth` 실행하여 상세 진단
4. 문제가 되는 플러그인(Completor, Semshi)의 업데이트나 대체 필요 여부 확인

## 대체 방안

특정 플러그인이 계속 문제를 일으키는 경우:
- **Completor** → `coc.nvim` 또는 Neovim 내장 LSP로 마이그레이션 검토
- **Semshi** → 구버전 Python과 호환성 문제 있을 수 있음