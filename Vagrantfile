# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box="shekeriev/centos-stream-9"
    jenkins.vm.hostname = "jenkins.martin.bg"
    jenkins.vm.network "private_network", ip: "192.168.34.201"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
    jenkins.vm.provision "shell", path: "setup-hosts.sh"
    jenkins.vm.provision "shell", path: "setup-firewall.sh"
    jenkins.vm.provision "shell", path: "setup-additional-packages.sh"
    jenkins.vm.provision "shell", path: "setup-docker.sh"
    jenkins.vm.provision "shell", path: "setup-jenkins.sh"
    jenkins.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3072"]
    end
  end

  config.trigger.after :up do |trigger|
    trigger.info = "*** Get jenkins initial admin password ..."
    trigger.run = {inline: "vagrant ssh -c 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword || true' jenkins"}             
  end

  config.trigger.after :up do |trigger|
    trigger.info = "*** Open default browser ..."
    if Vagrant::Util::Platform.windows?
      trigger.run = {inline: "start http://localhost:8080"}
    end
    if Vagrant::Util::Platform.linux?
      trigger.run = {inline: "bash -c 'xdg-open http://localhost:8080'"}
    end
    if Vagrant::Util::Platform.darwin?
      trigger.run = {inline: "open http://localhost:8080"}
    end
  end

end
