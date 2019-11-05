require 'rake'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'bin', 'gdf', 'plug')

desc "Hook gdf dotfiles into system-standard positions."
task :install do
  puts
  puts "======================================================"
  puts "Welcome to GDF Installation."
  puts "======================================================"
  puts

  install_homebrew if mac_os?
  install_rvm_binstubs

  # install_files(Dir.glob('git/*')) if want_to_install?('git configs (color, aliases)')
  # install_files(Dir.glob('irb/*')) if want_to_install?('irb/pry configs (more colorful)')
  # install_files(Dir.glob('ruby/*')) if want_to_install?('rubygems config (faster/no docs)')
  # install_files(Dir.glob('ctags/*')) if want_to_install?('ctags config (better js/ruby support)')
  # install_files(Dir.glob('tmux/*')) if want_to_install?('tmux config')
  # install_files(Dir.glob('vimify/*')) if want_to_install?('vimification of command line tools')
  if want_to_install?('vim configuration (highly recommended)')
    install_files(Dir.glob('{vim,vimrc}'))
    Rake::Task["install_plugs"].execute
  end

  # Rake::Task["install_prezto"].execute

  # install_fonts

  # install_term_theme if mac_os?

  run_bundle_config

  success_msg("installed")
end

desc 'Updates the installation'
task :update do
  Rake::Task["install"].execute
end

private

def mac_os?
  RUBY_PLATFORM.downcase.include?("darwin")
end

def linux?
  RUBY_PLATFORM.downcase.include?("linux")
end

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
    # source_config_code = "for config_file ($HOME/.gdf/zsh/*.zsh) source $config_file"
    # if file == 'zshrc'
    #   File.open(target, 'a+') do |zshrc|
    #     if zshrc.readlines.grep(/#{Regexp.escape(source_config_code)}/).empty?
    #       zshrc.puts(source_config_code)
    #     end
    #   end
    # end

    puts "=========================================================="
    puts
  end
end

desc "Runs Plug installer in a clean vim environment"
task :install_plugs do
  puts "======================================================"
  puts "Installing and updating plugins."
  puts "The installer will now proceed to run PluginInstall to install plugins."
  puts "======================================================"

  puts ""

  Plug::update_plugs
end

def number_of_cores
  cores = if mac_os?
    run %{ sysctl -n hw.ncpu }
  else
    run %{ nproc }
  end.to_i
end

def install_homebrew
  run %{which brew}
  unless $?.success?
    puts "======================================================"
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end
  puts
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}
  puts
  puts
  puts "======================================================"
  puts "Installing Homebrew packages...There may be some warnings."
  puts "======================================================"
  run %{brew install zsh ctags git tmux}
  # run %{brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher ghi}
  puts
  puts
end

def install_rvm_binstubs
  puts "======================================================"
  puts "Installing RVM Bundler support. Never have to type"
  puts "bundle exec again! Please use bundle --binstubs and RVM"
  puts "will automatically use those bins after cd'ing into dir."
  puts "======================================================"
  run %{ chmod +x $rvm_path/hooks/after_cd_bundler }
  puts
end

def run_bundle_config
  return unless system("which bundle")

  n_of_cores = number_of_cores
  bundler_jobs = n_of_cores - 1
  puts "======================================================"
  puts "Configuring Bundlers for parallel gem installation."
  puts "Bundle will use #{bundler_jobs} of #{number_of_cores} cores avilable."
  puts "======================================================"
  run %{ bundle config --global jobs #{bundler_jobs} }
  puts
end

def success_msg(action)
  puts ""
  puts "            _ .-') _              "
  puts "           ( (  OO) )             "
  puts "  ,----.    \     .'_    ,------. "
  puts " '  .-./-') ,`'--..._)('-| _.---' "
  puts " |  |_( O- )|  |  \  '(OO|(_\     "
  puts " |  | .--, \|  |   ' |/  |  '--.  "
  puts "(|  | '. (_/|  |   / :\_)|  .--'  "
  puts " |  '--'  | |  '--'  /  \|  |_)   "
  puts "  `------'  `-------'    `--'     "
  puts ""
  puts "GDF has been #{action}. Please restart your terminal and vim."
end
