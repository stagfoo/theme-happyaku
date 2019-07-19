function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end


function fish_prompt
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l red (set_color -o red)
  set -l yellow (set_color -o yellow)

  set -l orange_fish (set_color -o FFA500)
  set -l yellow_fish (set_color -o FFB732)
  set -l red_fish (set_color -o FF725A)
  set -l black_fish (set_color -o 3F3F3F)

  set_color $fish_color_cwd

  if [ -n "$SSH_CONNECTION" ]
    printf '%s | ' (hostname | head -c 10)
  end

  if [ "$HOME" = (pwd) ]
    printf "$red█$orange_fish█$yellow█$blue█$green█"
  else
    printf (pwd | grep -o '[^/]*$')
  end
  printf ' '

  if [ (_git_branch_name) ]

    if test (_git_branch_name) = "master"
      printf "$red MASTER "
    else
      printf "$red "(_git_branch_name)" "
    end
    if [ (_is_git_dirty) ]
      # printf "$blue(ﾉ•з•$blue)ﾉ$green~$yellow:$orange_fish･ﾟ$red✧$blue✧$green✧ "
      printf "$blue(ﾉ•з•$blue)ﾉ🌈 ✨ "
    else
      printf " $blue( •з•) "
    end

  else
    printf "$blue( •з•) "


  end

end
