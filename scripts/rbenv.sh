echo "Installing rbenv..."
apt-get -y install build-essential bison openssl zlib1g zlib1g-dev \
  libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev \
  libxslt-dev autoconf libc6-dev nodejs

if [ ! -d /usr/local/rbenv ]; then
  git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv

  if [ $? -gt 0 ]; then
    echo >&2 "Error: Git clone error! See above."
    exit 1
  fi
fi

# Add rbenv to the path:
echo '# rbenv setup' > /etc/profile.d/rbenv.sh
echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

# Install ruby-build:
pushd /tmp
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  ./install.sh
popd

# Install Rubies
rbenv install 2.0.0-p247
rbenv install 1.9.3-p448
rbenv global 1.9.3-p448

cat << EOF > /root/.gemrc
---
:sources:
- http://gems.rubyforge.org
gem: --no-ri --no-rdoc
EOF
