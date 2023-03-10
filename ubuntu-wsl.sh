#!/bin/bash
RED='\033[0;31m'
CYAN='\033[0;36m'

function main {
sudo apt-get update && sudo apt-get upgrade -y
SHELL_RC_FILE="$HOME/.$(echo $SHELL | awk -F '/' '{print $NF}')"rc
mkdir ~/lab
cd ~/lab

echo -e ${RED}'Installing Volatility 2 and 3'${CYAN}
        sudo apt-get install -y curl build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata
        sudo apt-get install -y python2 python2.7-dev libpython2-dev
        curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
        sudo python2 get-pip.py
        sudo python2 -m pip install -U setuptools wheel
        python2 -m pip install -U distorm3 yara-python pycryptodome pillow openpyxl ujson pytz ipython capstone construct==2.5.5-reupload
        sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so
        python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git

        sudo apt-get install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel
        python3 -m pip install -U distorm3 pillow openpyxl ujson pytz ipython capstone pefile yara-python pycryptodome jsonschema leechcorepyc python-snappy
        python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git
        echo -e "export PATH=/home/$USER/.local/bin:$PATH" >> $SHELL_RC_FILE
        git clone https://github.com/superponible/volatility-plugins.git
        sudo cp ~/lab/volatility-plugins/* ~/.local/lib/python2.7/site-packages/volatility/plugins/
        git clone https://github.com/volatilityfoundation/volatility.git

echo -e ${RED}'Press ENTER to continue'${CYAN}
read a

echo -e ${RED}'Installing Networking tools'${CYAN}
        sudo apt-get install tshark -y
        git clone https://github.com/mandiant/flare-fakenet-ng.git
        sudo apt-get install build-essential python2-dev libnetfilter-queue-dev
        python2 -m pip install requests
        sudo python2 -m pip install https://github.com/mandiant/flare-fakenet-ng/zipball/master
        cd ~/lab/flare-fakenet-ng
        sudo python2.7 setup.py install
        python3 -m pip install pyshark

echo -e ${RED}'Installing Cracking tools & Wordlists'${CYAN}
        sudo apt-get install hashcat snapd -y
        sudo snap install john-the-ripper
        git clone https://github.com/danielmiessler/SecLists.git
        git clone https://github.com/3ndG4me/KaliLists.git
        cd KaliLists/ 
        gunzip rockyou.txt.gz 
        echo "alias 'wordlists'='echo ~/lab/KaliLists ~/lab/SecLists'" >> $SHELL_RC_FILE
        cd ~/lab && git clone https://github.com/Yara-Rules/rules.git

echo -e ${RED}'Installing Stego and OSINT tools'${CYAN}
        cd ~/lab
        sudo apt-get install exiftool steghide -y
        sudo gem install zsteg
        wget https://github.com/RickdeJager/stegseek/releases/download/v0.6/stegseek_0.6-1.deb
        chmod +x ./stegseek_0.6-1.deb
        sudo apt-get install ./stegseek_0.6-1.deb -y
        sudo apt-get install default-jre -y
        wget http://www.caesum.com/handbook/Stegsolve.jar -O stegsolve.jar
        chmod +x stegsolve.jar
        git clone https://github.com/p1ngul1n0/blackbird
        cd blackbird
        python3 -m pip install -r requirements.txt
        python3 -m pip install pipx
        pipx ensurepath
        sudo apt-get install python3.10-venv -y
        pipx install ghunt
        sed -i '1i#!/usr/bin/python3' ~/lab/blackbird/blackbird.py
        sudo cp ~/lab/blackbird/blackbird.py /usr/bin/blackbird.py
        cd ~/lab
        wget https://mark0.net/download/trid_linux_64.zip && mkdir trid && unzip trid_linux_64.zip -d ./trid
        cd trid && wget https://mark0.net/download/tridupdate.zip && unzip tridupdate.zip
        python3 triupdate.py
        sudo cp trid /usr/bin/trid && sudo chmod +x /usr/bin/trid
        sudo cp *.trd /usr/bin/
        echo "echo "LANG=/usr/lib/locale/en_US" | $(echo $SHELL | awk -F '/' '{print $NF}\')" >> $SHELL_RC_FILE
        cd ~/lab && git clone https://github.com/megadose/holehe.git && cd holehe
        sudo python3 setup.py install

echo -e ${RED}'Press ENTER to continue'${CYAN}
read a

echo -e ${RED}'Installing File analizing tools'${CYAN}
        sudo -H python3 -m pip install -U oletools[full]
        cd ~/lab
        git clone https://github.com/jesparza/peepdf.git
        cd peepdf
        sed -i '1i#!/usr/bin/python2.7' peepdf.py
        cd ~/lab && sudo cp -r peepdf/ /usr/bin
        echo -e "export PATH=/usr/bin/peepdf:$PATH" >> $SHELL_RC_FILE

echo -e ${RED}'Press ENTER to continue'${CYAN}
read a
        sudo apt-get update
        sudo apt-get install -y neofetch lolcat batcat nala htop bpytop openssh-server net-tools openvpn dos2unix ewf-tools
        sudo apt-get upgrade -y 
}

main 2>&1 | tee install_log.txt
