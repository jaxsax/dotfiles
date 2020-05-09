export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

for file in ~/.{aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

unset file

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)
