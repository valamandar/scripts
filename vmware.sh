git clone -b workstation-15.0.2 https://github.com/mkubecek/vmware-host-modules.git
cd vmware-host-modules
tar -cf vmmon.tar vmmon-only
tar -cf vmnet.tar vmnet-only
sudo cp -v vmmon.tar vmnet.tar /usr/lib/vmware/modules/source/
sudo vmware-modconfig --console --install-all
