alias aptul='echo "sudo apt update && apt list --upgradable" && sudo apt update && apt list --upgradable'
alias au='echo "sudo apt upgrade" && sudo apt upgrade'
alias ipa='ip -c addr'
alias pingg='ping 8.8.8.8'
alias reloadbashrc='echo "source ~/.bashrc" && source ~/.bashrc'
alias lfs='echo "!squashfs" && lsblk --fs | grep -v squashfs'
alias iptraffic='ip -d -s -h addr | grep ": bytes" -A 2'
alias dkrls='docker container ls -a --format "table {{.Image}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Names}}\t{{.Size}}\t{{.Networks}}"'
alias alied='vim ~/.bash_aliases'
alias dfh='echo "Excluding loop and tmpfs:" && df -h | grep -v "/dev/loop" | grep -v tmpfs'
alias sshh='ssh alkas@10.0.73.8'
alias timeit='date && time '
alias iperf3c='iperf3 -c 10.0.73.8 -R -i 2 -t 20'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles'
alias dockdbox='docker exec dropbox dropbox filestatus'