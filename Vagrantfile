require 'yaml'

guests = YAML.load_file('machine-config.yaml')

Vagrant.configure("2") do |config|
    guests.each do |guest|
        config.vm.define guest['machine'] do |node|
            node.vm.box = guest['box']
            node.vm.hostname = guest['machine']
            node.vm.network "private_network", ip: guest['ip']
#             node.vm.provision "ansible" do |ansible|
#                 ansible.playbook = "provision/playbook.yaml"
#                 ansible.verbose = true
#             end
        end
    end
end