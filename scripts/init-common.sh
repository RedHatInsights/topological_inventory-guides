if [ -f "$HOME/.rvm/scripts/rvm" ]; then
  source "$HOME/.rvm/scripts/rvm"
  rvm use $RVM_RUBY_VERSION_TP_INV
  rvm gemset use $RVM_GEMSET_NAME_TP_INV
fi