#!/bin/bash

# Oh My Zsh をインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh My Zsh プラグインをインストール
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom} &&
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions &&
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting &&
  git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search

# LazyVim をクローン
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"

# 移動元ディレクトリ
SRC_DIR="$HOME/dotfiles/brave"
# 移動先ディレクトリ
DEST_DIR="$HOME/.config/BraveSoftware/Brave-Browser/Default/Extensions"

# 移動先ディレクトリが存在しない場合は作成
mkdir -p "$DEST_DIR"

# ファイルをコピー
cp -r "$SRC_DIR"/* "$DEST_DIR"/

# .zshrc をホームディレクトリにコピー
cp -r "$HOME/dotfiles/.zshrc" "$HOME/"

# 実行結果を表示
echo "Installed Oh My Zsh"
echo "Installed Oh My Zsh plugins"
echo "Cloned LazyVim to $HOME/.config/nvim"
echo "Copied all files from $SRC_DIR to $DEST_DIR"
echo "Copied .zshrc to $HOME"
