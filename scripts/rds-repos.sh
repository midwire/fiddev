USER="$1"
SRCDIR="/home/${USER}/src"

echo "Cloning repos..."

mkdir -p /root/.ssh
echo "Host scm" > "$HOME/.ssh/config"
echo "  HostName scm.infrastructure.rds.americadirect.net" >> "$HOME/.ssh/config"
echo "  User cblackburn" >> "$HOME/.ssh/config"
echo "  IdentityFile /home/${USER}/.ssh/id_dsa" >> "$HOME/.ssh/config"

cd $SRCDIR
git clone git@scm:chef/chef_fla.git
git clone git@scm:chef/chef_rds.git
git clone git@scm:chef/chef_cd.git
git clone git@scm:chef/local_vm_host_data.git

chown -R ${USER}:${USER} "${SRCDIR}"
