require 'berkshelf/vagrant'

Vagrant::Config.run do |config|

  config.vm.host_name = "openfire-berkshelf"

  config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
  config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"

  config.vm.network :hostonly, "33.33.33.2"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.provision :chef_solo do |chef|
    chef.json = {
        :java => {
          :jdk_version => '7',
        },
        :openfire => {
          :database => {
            :type => 'postgresql',
            :password => 'foobar'
          }
        },
        :postgresql => {
          :password => {
            :postgres => 'bazfaz'
          }
        }
    }

    chef.run_list = [
      "recipe[openfire::default]"
    ]

    chef.log_level = :info
  end
end
