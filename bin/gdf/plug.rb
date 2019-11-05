module Plug
  def self.update_plugs
    system "vim --noplugin -N \"+set hidden\" \"+syntax on\" +PlugClean +PlugInstall! +PlugUpdate +qall"
  end
end
