# -*- mode: ruby -*-
# vim: set ft=ruby :
home = ENV['HOME']
ENV["LC_ALL"] = "en_US.UTF-8"

MACHINES = {
  :zfs => {
        :box_name => "centos/7",
        :box_version => "2004.01",
        :provision => "script.sh",
        
    :disks => {
        :sata1 => {
            :dfile => home + './sata1.vdi',
            :size => 512,
            :port => 1
        },
        :sata2 => {
            :dfile => home + './sata2.vdi',
            :size => 512, # Megabytes
            :port => 2
        },
        :sata3 => {
            :dfile => home + './sata3.vdi',
            :size => 512, # Megabytes
            :port => 3
        },
        :sata4 => {
            :dfile => home + './sata4.vdi',
            :size => 512,
            :port => 4
        },
        :sata5 => {
            :dfile => home + './sata5.vdi',
            :size => 512,
            :port => 5
        },
        :sata6 => {
            :dfile => home + './sata6.vdi',
            :size => 512,
            :port => 6
        },
        :sata7 => {
            :dfile => home + './sata7.vdi',
            :size => 512,
            :port => 7
        },
        :sata8 => {
            :dfile => home + './sata8.vdi',
            :size => 512,
            :port => 8
        },
    }
  },
}
Vagrant.configure("2") do |config|

    config.vm.box_version = "2004.01"
    MACHINES.each do |boxname, boxconfig|
  
        config.vm.define boxname do |box|
  
            box.vm.box = boxconfig[:box_name]
            box.vm.box_version = boxconfig[:box_version]
            box.vm.host_name = "zfs"
  
            box.vm.provider :virtualbox do |vb|
                    vb.customize ["modifyvm", :id, "--memory", "1024"]
                    needsController = false
            boxconfig[:disks].each do |dname, dconf|
                unless File.exist?(dconf[:dfile])
                  vb.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                                  needsController =  true
                            end
  
            end
                    if needsController == true
                       vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                       boxconfig[:disks].each do |dname, dconf|
                           vb.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                       end
                    end
            end
  
        box.vm.provision "shell", inline: <<-SHELL
            mkdir -p ~root/.ssh
            cp ~vagrant/.ssh/auth* ~root/.ssh
            yum install -y http://download.zfsonlinux.org/epel/zfs-release.el7_8.noarch.rpm
            rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux
            yum install -y epel-release kernel-devel zfs
            yum-config-manager --disable zfs
            yum-config-manager --enable zfs-kmod
            yum install -y zfs
            modprobe zfs
            yum install -y wget
          SHELL
        box.vm.provision "shell", path: boxconfig[:provision]
  
        end
        
    
    end
  end
  
