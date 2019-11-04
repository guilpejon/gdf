require 'rake'
require 'fileutils'
# require File.join(File.dirname(__FILE__), 'bin', 'gdf', 'plug')

desc "Hook our dotfiles into system-standard positions."
task :install => [:submodule_init, :submodules] do
  puts
  puts "======================================================"
  puts "Welcome to GDR Installation."
  puts "======================================================"
  puts

  # install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")
  # install_rvm_binstubs

  # # this has all the runcoms from this directory.
  # install_files(Dir.glob('git/*')) if want_to_install?('git configs (color, aliases)')
  # install_files(Dir.glob('irb/*')) if want_to_install?('irb/pry configs (more colorful)')
  # install_files(Dir.glob('ruby/*')) if want_to_install?('rubygems config (faster/no docs)')
  # install_files(Dir.glob('ctags/*')) if want_to_install?('ctags config (better js/ruby support)')
  # install_files(Dir.glob('tmux/*')) if want_to_install?('tmux config')
  # install_files(Dir.glob('vimify/*')) if want_to_install?('vimification of command line tools')
  if want_to_install?('vim configuration (highly recommended)')
    install_files(Dir.glob('{vim,vimrc}'))
    # Rake::Task["install_plug"].execute
  end

  # Rake::Task["install_prezto"].execute

  # install_fonts

  # install_term_theme if RUBY_PLATFORM.downcase.include?("darwin")

  # run_bundle_config

  success_msg("installed")
end

task :submodule_init do
  # unless ENV["SKIP_SUBMODULES"]
  #   run %{ git submodule update --init --recursive }
  # end
end

desc "Init and update submodules."
task :submodules do
  # unless ENV["SKIP_SUBMODULES"]
  #   puts "======================================================"
  #   puts "Downloading GDR submodules...please wait"
  #   puts "======================================================"

  #   run %{
  #     cd $HOME/.yadr
  #     git submodule update --recursive
  #     git clean -df
  #   }
  #   puts
  # end
end

private

def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def want_to_install? (section)
  if ENV["ASK"]=="true"
    puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
    STDIN.gets.chomp == 'y'
  else
    true
  end
end

def install_files(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %{ mv "$HOME/.#{file}" "$HOME/.#{file}.backup" }
    end

    if method == :symlink
      run %{ ln -nfs "#{source}" "#{target}" }
    else
      run %{ cp -f "#{source}" "#{target}" }
    end

    # Temporary solution until we find a way to allow customization
    # This modifies zshrc to load all of gdf's zsh extensions.
    # Eventually gdf's zsh extensions should be ported to prezto modules.
    source_config_code = "for config_file ($HOME/.gdf/zsh/*.zsh) source $config_file"
    if file == 'zshrc'
      File.open(target, 'a+') do |zshrc|
        if zshrc.readlines.grep(/#{Regexp.escape(source_config_code)}/).empty?
          zshrc.puts(source_config_code)
        end
      end
    end

    puts "=========================================================="
    puts
  end
end

desc "Runs Plug installer in a clean vim environment"
task :install_plug do
  # puts "======================================================"
  # puts "Installing and updating plugins."
  # puts "The installer will now proceed to run PluginInstall to install plugins."
  # puts "======================================================"

  # puts ""

  # plug_path = File.join('vim', 'plugged')
  # unless File.exists?(plug_path)
  #   run %{
  #     cd $HOME/.gdf
  #     git clone https://github.com/gmarik/vundle.git #{vundle_path}
  #   }
  # end

  # Plug::update_plugs
end

def success_msg(action)
  # puts ""
  # puts "   _     _           _         "
  # puts "  | |   | |         | |        "
  # puts "  | |___| |_____  __| | ____   "
  # puts "  |_____  (____ |/ _  |/ ___)  "
  # puts "   _____| / ___ ( (_| | |      "
  # puts "  (_______\_____|\____|_|      "
  # puts ""
  puts "GDR has been #{action}. Please restart your terminal and vim."
end
