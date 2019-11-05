require 'rake'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'bin', 'gdf', 'plug')

desc "Hook our dotfiles into system-standard positions."
task :install do
  puts
  puts "======================================================"
  puts "Welcome to GDF Installation."
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
    Rake::Task["install_plugs"].execute
  end

  # Rake::Task["install_prezto"].execute

  # install_fonts

  # install_term_theme if RUBY_PLATFORM.downcase.include?("darwin")

  # run_bundle_config

  success_msg("installed")
end

desc 'Updates the installation'
task :update do
  Rake::Task["install"].execute
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
