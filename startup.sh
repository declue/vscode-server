#!/bin/bash
[[ -f /home/developer/.homedir-initialized ]] || (
    echo "Remove this file to re-copy files from /etc/skel /opt/default_home at next container startup" > /home/developer/.homedir-initialized
    # dotglob to catch files like `.bashrc`
    shopt -s dotglob
    cp -r /etc/skel/* /home/developer
    cp -r /opt/default_home/* /home/developer
    shopt -u dotglob
    # install kubernetes ext
    #su code --login -c "/usr/bin/code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools"
)
# make workspace dir if it doesn't exist
[[ -d /home/developer/workspace ]] || mkdir /home/developer/workspace
# chown stuff to kube:kube
chown developer:developer /home/developer -R
# generate env whitelist from su using.. a blacklist, pretty much.
env_whitelist=$(env | cut -d = -f 1 | grep -v -e HOSTNAME -e PWD -e HOME -e TERM -e SHLVL -e LC_ALL -e ^_$ | tr "\n" "," | head -c -1)
# configure kubectl so vscode's kubernetes extension works
# su code --login -w "$env_whitelist" -c "/usr/local/bin/generate-kubeconfig.sh"
# start code-server
# su code --login -w "$env_whitelist" -c "/usr/bin/code-server --bind-addr 0.0.0.0:8080 /home/developer/workspace" # --enable-proposed-api [\"ms-vsliveshare.vsliveshare\",\"ms-vscode.node-debug\",\"ms-vscode.node-debug2\"]
runuser developer --login -w "$env_whitelist" -c "/usr/bin/code-server --bind-addr 0.0.0.0:8080 /home/developer/workspace" # --enable-proposed-api [\"ms-vsliveshare.vsliveshare\",\"ms-vscode.node-debug\",\"ms-vscode.node-debug2\"]
