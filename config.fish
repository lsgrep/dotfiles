
function  rebridge
  kill -9  (lsof -i :8888 |grep -i ssh |  awk '{print $2}' | uniq)
  ssh  -fCND 8888 root@my
end

function  aaa
  kill -9  (lsof -i :8888 |grep -i ssh |  awk '{print $2}' | uniq)
  ssh  -fCND 8888 ubuntu@aws
end

function  goog
  kill -9  (lsof -i :8888 |grep -i ssh |  awk '{print $2}' | uniq)
  ssh  -fCND 8888 awklsgrep@vpn
end


function gsh
    gcloud compute ssh shell --zone asia-east1-c
end

function gce
    ssh awklsgrep@vpn
end

function gho
  open https://(git config --get remote.origin.url|sed -e s/.git//g|sed s,:,/,g)/$argv
end

function reload
    source ~/.config/fish/config.fish
end

function subl
    open -a "Sublime Text.app" $argv
end

function ll
    ls -lhG $argv
end

function la
    ls -lahG $argv
end

function lsd
    ls -d */
end

 function ls
      command ls -hG $argv
 end

 function grep
      command grep --color=auto $argv
 end

set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

set -gx PYTHONPATH /usr/local/lib/python2.7/site-packages/
set -gx PATH /usr/local/share/python $PATH
set -gx PATH /usr/local/bin/ $PATH
set -gx PATH /work/google-cloud-sdk/bin  $PATH

function gclist
    gcloud compute instances list 
end


function gcstart 
    gcloud compute instances start $argv
end


function gcstop
    gcloud compute instances stop $argv
end


function gssh
    gcloud compute ssh --zone  asia-east1-c $argv 
end
