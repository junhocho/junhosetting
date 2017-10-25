#!/bin/sh



SESSION_NAME="server"
tmux has-session -t ${SESSION_NAME}

if [ $? != 0 ]
then
  # Create the session
  tmux new-session -s ${SESSION_NAME} -n setup -d
  tmux split-window -h -t ${SESSION_NAME}
  tmux split-window -v -t ${SESSION_NAME}:1.1
  tmux split-window -v -t ${SESSION_NAME}:1.2

  tmux send-keys -t ${SESSION_NAME}:1.1 'htop' C-m
  tmux send-keys -t ${SESSION_NAME}:1.2 'wn' C-m
  tmux send-keys -t ${SESSION_NAME}:1.3 'while ; do ;  th -ldisplay.start 8000 0.0.0.0 ; done' C-m
  tmux send-keys -t ${SESSION_NAME}:1.4 'python -m visdom.server -port 8090' C-m

  ## First window (0) -- vim and console
  #tmux send-keys -t ${SESSION_NAME} 'vim' C-m

  ## shell (1)
  #tmux new-window -n bash -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:1 'git status' C-m

  ## mysql (2)
  #tmux new-window -n mysql -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:2 'mysql -u <username> <database>' C-m

  ## server/debug log (3)
  #tmux new-window -n server -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:3 'bundle exec rails s' C-m
  #tmux split-window -v -t ${SESSION_NAME}:3
  #tmux send-keys -t ${SESSION_NAME}:3.1 'tail -f log/development.log | grep "DEBUG"' C-m

  ## rails console (4)
  #tmux new-window -n console -t ${SESSION_NAME}
  #tmux send-keys -t ${SESSION_NAME}:4 'pry -r ./config/environment' C-m

  ## Start out on the first window when we attach
  #tmux select-window -t ${SESSION_NAME}:0
fi

SESSION_NAME="TitanX-MAIN"
tmux has-session -t ${SESSION_NAME}

if [ $? != 0 ]
then
  tmux new-session -s ${SESSION_NAME} -n setup -d
fi
tmux attach -t ${SESSION_NAME}
