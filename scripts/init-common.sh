#!/usr/bin/env bash

if [[ -f "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
  rvm use ${RVM_RUBY_VERSION_TP_INV}
  rvm gemset use ${RVM_GEMSET_NAME_TP_INV}
fi

function start_svc_in_tmux {
    local svc=$1

    tmux new-window -t TpInv -n ${svc} "services/${svc}.sh"
}

function stop_svc_in_tmux {
    local svc=$1

    tmux kill-window -t TpInv:${svc} &> /dev/null
}
