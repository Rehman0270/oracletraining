#!/bin/bash
dest=bashtestR
mkdir $dest
for i in  (find "$HOME" -maxdepth 1 -type f -name 'test*')
do
mv i $HOME/$dest
done


