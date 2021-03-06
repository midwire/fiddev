# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define "fiddev" do |cc|
    # Every Vagrant virtual environment requires a box to build off of.
    cc.vm.box = "ubuntu-12.04.1-server-amd64-clean"
    cc.vm.hostname = 'fiddev'

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    # config.vm.box_url = "http://domain.com/path/to/above.box"

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network :forwarded_port, guest: 80, host: 8080

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # config.vm.network :private_network, ip: "192.168.33.10"
    cc.vm.network :private_network, ip: "192.168.99.10"

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network :public_network

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    cc.vm.provider :virtualbox do |vb|
      # Don't boot with headless mode
      #vb.gui = true

      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "1024", "--name", "fiddev"]
    end
  end

  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Update apt
  config.vm.provision :shell, :path => "scripts/apt.sh"

  # Install Git and Curl
  config.vm.provision :shell, :inline => "sudo apt-get install --no-install-recommends --assume-yes git curl"

  # Load the ssh keyfile to pass to the users.sh script
  if File.exists?("#{ENV['HOME']}/.ssh/id_rsa.pub")
    pubkey = File.read("#{ENV['HOME']}/.ssh/id_rsa.pub")
    privkey = File.read("#{ENV['HOME']}/.ssh/id_rsa")
  else
    pubkey = File.read("#{ENV['HOME']}/.ssh/id_dsa.pub")
    privkey = File.read("#{ENV['HOME']}/.ssh/id_dsa")
  end
  config.vm.provision :shell, :path => "scripts/users.sh", :args => %Q("#{ENV['USER']}" "#{pubkey}" "#{privkey}")

  # Ruby
  config.vm.provision :shell, :path => "scripts/rbenv.sh"

  # Dot-Env
  config.vm.provision :shell, :path => "scripts/dot-env.sh", :args => %Q("#{ENV['USER']}")

  # Open VPN
  config.vm.provision :shell, :path => "scripts/vpn.sh", :args => %Q("#{ENV['USER']}")

  # RDS Repos
  config.vm.provision :shell, :path => "scripts/rds-repos.sh", :args => %Q("#{ENV['USER']}")

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.log_level = :debug
  #   chef.run_list.clear
  #   chef.json = {
  #     :chef_server => {
  #       :url => "http://localhost:4000",
  #       :webui_enabled => true
  #     }
  #   }
  #   chef.add_recipe "build-essentials"
  #   chef.add_recipe "rbenv"
  #   chef.add_recipe "ruby_build"
  #   # chef.cookbooks_path = "#{ENV['CHEF_DIR_FLA']}/chef_fla/cookbooks"
  #   # chef.roles_path     = "#{ENV['CHEF_DIR_FLA']}/chef_fla/roles"
  #   # chef.data_bags_path = "#{ENV['CHEF_DIR_FLA']}/chef_fla/data_bags"

  #   # You may also specify custom JSON attributes:
  #   # chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
