# Install main user
USER=$1
PUBKEY="$2"
PRIVKEY="$3"
HOMEDIR="/home/${USER}"
SSH_KEYPATH="/home/${USER}/.ssh"
SSH_AUTH="${SSH_KEYPATH}/authorized_keys"
SSH_PUBKEY="${SSH_KEYPATH}/id_dsa.pub"
SSH_PRIVKEY="${SSH_KEYPATH}/id_dsa"

echo "Creating user [${USER}]..."
adduser --gecos "" --home "$HOMEDIR" --shell "/bin/bash" ${USER}
usermod -a -G sudo,adm ${USER}
mkdir -p "${SSH_KEYPATH}"
chmod 700 "${SSH_KEYPATH}"

echo "Adding ssh key to authorized_keys file for [${USER}]..."
echo "${PUBKEY}" > ${SSH_AUTH}
chmod 600 "${SSH_AUTH}"

echo "Copying ssh public key for [${USER}]..."
echo "${PUBKEY}" > ${SSH_PUBKEY}
chmod 600 "${SSH_PUBKEY}"

echo "Copying ssh private key for [${USER}]..."
echo "${PRIVKEY}" > ${SSH_PRIVKEY}
chmod 600 "${SSH_PRIVKEY}"

echo "Changing ssh key file ownership for [${USER}]..."
chown -R ${USER}:${USER} "${SSH_KEYPATH}"
