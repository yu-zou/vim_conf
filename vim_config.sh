# Install newest vim inside current folder
echo "Install Vim 9.1 inside current folder"

sudo apt install libncurses5-dev libncurses-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python2-dev python3-dev libperl-dev git -y

git submodule update --progress --init --recursive
cd vim
git checkout v9.1.0

vim_dest=$PWD
./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=$vim_dest

make -j VIMRUNTIMEDIR=$vim_dest/share/vim/vim91
make -j install

# Add to path variable
echo 'export PATH='"$vim_dest"'/bin:$PATH' >> $HOME/.bashrc

cd ..
echo "Configuring .vimrc"
echo 'source '"$PWD/vimrc" >> $HOME/.vimrc

echo "Install newest node"
tar -xvf ./node-v20.17.0-linux-x64.tar.xz
echo 'export PATH='"$PWD"'/node-v20.17.0-linux-x64.tar.xz/bin:$PATH' >> $HOME/.bashrc

echo "Configuration done"
