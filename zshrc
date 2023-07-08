ZSH=$HOME/.oh-my-zsh

# Você pode alterar o tema com outro de https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Plugins úteis oh-my-zsh para bootcamps Le Wagon
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search)

# (somente macOS) Impedir que o Homebrew relate - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
exportar HOMEBREW_NO_ANALYTICS=1

# Desative o aviso sobre diretórios dependentes de conclusão inseguros
ZSH_DISABLE_COMPFIX=verdadeiro

# Na verdade, carregue Oh-My-Zsh
fonte "${ZSH}/oh-meu-zsh.sh"
unalias rm # Sem rm interativo por padrão (trazido por plugins/common-aliases)
unalias lt # precisamos de `lt` para https://github.com/localtunnel/localtunnel

# Carregar rbenv se instalado (para gerenciar suas versões do Ruby)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Necessário para Linux/WSL
digite -a rbenv > /dev/null && eval "$(rbenv init -)"

# Carregar pyenv (para gerenciar suas versões do Python)
exportar PYENV_VIRTUALENV_DISABLE_PROMPT=1
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)" && RPROMPT+='[🐍 $(pyenv version-name) ]'

# Carregar nvm (para gerenciar suas versões de node)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # Isso carrega nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # Isso carrega nvm bash_completion

# Chame `nvm use` automaticamente em um diretório com um arquivo `.nvmrc`
autoload -U add-zsh-hook
load-nvmrc() {
  se nvm -v &> /dev/null; então
    local node_version="$(versão nvm)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    se [ -n "$nvmrc_path"]; então
      local nvmrc_node_version=$(versão nvm "$(cat "${nvmrc_path}")")

      if ["$nvmrc_node_version" = "N/A"]; então
        instalação nvm
      elif [ "$nvmrc_node_version" != "$node_version" ]; então
        uso nvm --silent
      fi
    elif [ "$node_version" != "$(padrão da versão nvm)" ]; então
      nvm usa padrão --silent
    fi
  fi
}
digite -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
digite -a nvm > /dev/null && load-nvmrc

# Rails e Ruby usam a pasta `bin` local para armazenar binstubs.
# Então ao invés de executar `bin/rails` como diz o doc, apenas execute `rails`
# O mesmo para `./node_modules/.bin` e nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Armazene seus próprios apelidos no arquivo ~/.aliases e carregue-os aqui.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Codificando coisas para o terminal
exportar LANG=en_US.UTF-8
exportar LC_ALL=en_US.UTF-8

exportar BUNDLER_EDITOR=código
EDITOR de exportação=código

# Defina ipdb como o depurador Python padrão
exportar PYTHONBREAKPOINT=ipdb.set_trace
