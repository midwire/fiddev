USER=$1
HOMEDIR="/home/${USER}"
ENVDIR="${HOMEDIR}/.env"
PROFILE_FILE="${HOMEDIR}/.bashrc"

echo "Installing .env for [${USER}]..."
cd "/home/${USER}"
git clone https://github.com/midwire/.env.git
chown -R ${USER}:${USER} "${ENVDIR}"

if [[ -f "${PROFILE_FILE}" ]] &&
  ! grep '$HOME/.env/dot-env.sh' "$PROFILE_FILE" >/dev/null 2>&1
then
  echo '[[ -r $HOME/.env/dot-env.sh ]] && . $HOME/.env/dot-env.sh' >> "${HOMEDIR}/.bashrc"
  echo ".env will now load on login."
else
  echo ".env is already setup to load on login."
fi
