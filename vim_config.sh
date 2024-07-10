# Install newest vim inside current folder
echo "Install newest vim inside current folder"

#sudo apt install libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python2-dev python3-dev libperl-dev git -y

#vim_dest=$(pwd)

#cd vim

#./configure --with-features=huge \
            #--enable-multibyte \
            #--enable-python3interp=yes \
            #--with-python3-config-dir=$(python3-config --configdir) \
            #--enable-perlinterp=yes \
            #--enable-gui=gtk2 \
            #--enable-cscope \
            #--prefix=$vim_dest

#make -j VIMRUNTIMEDIR=$vim_dest/share/vim/vim91
#make -j install

# Add to path variable
echo 'export PATH='"$vim_dest"'/bin:$PATH' >> $(home)/.bashrc
