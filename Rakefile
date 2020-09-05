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

  install_mac_packages if mac_os?
  install_linux_packages if linux?

  install_rvm_binstubs

  install_files(Dir.glob('irb/*')) if want_to_install?('irb/pry configs (more colorful)')
  install_files(Dir.glob('ruby/*')) if want_to_install?('rubygems config (faster/no docs)')
  install_files(Dir.glob('ctags/*')) if want_to_install?('ctags config (better js/ruby support)')
  install_files(Dir.glob('tmux/*')) if want_to_install?('tmux config')
  if want_to_install?('zsh config')
    # TODO, erase code after checking that oh my zsh installation already does this
    # set_zsh_as_default_shell
    install_oh_my_zsh
    install_spaceship_theme
    install_zplugin
    install_zsh_config
  end
  if want_to_install?('git configs (color, aliases)')
    write_git_user_file
    install_files(Dir.glob('git/*'))
  end
  if want_to_install?('vim configuration (highly recommended)')
    install_files(Dir.glob('{vim,vimrc}'))
    install_vim
  end

  install_instant_markdown

  install_fonts

  install_term_theme if mac_os?

  run_bundle_config

  success_msg("installed")
end

desc 'Updates the installation'
task :update do
  Rake::Task["install"].execute
end

desc 'Removes all installation files'
task :clean do
  # TODO, delete created files
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

def install_mac_packages
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}
  puts
  puts
  puts "======================================================"
  puts "Installing Homebrew packages...There may be some warnings."
  puts "======================================================"
  run %{brew install zsh ctags tmux ripgrep z}
  puts
  puts
end

def install_linux_packages
  puts "======================================================"
  puts "Updating Linux."
  puts "======================================================"
  run %{ sudo apt-get update }
  run %{ sudo apt-get upgrade }

  puts "======================================================"
  puts "Installing linux pakages."
  puts "======================================================"
  run %{ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb }
  run %{ sudo dpkg -i ripgrep_11.0.2_amd64.deb }
  run %{ rm ripgrep_11.0.2_amd64.deb }

  # install Z
  run %{ sudo wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/z.sh }
  z_path = ". #{ENV['HOME']}/z.sh"
  File.open("#{ENV['HOME']}/.zshrc", 'a+') do |zshrc|
    if zshrc.readlines.grep(/#{Regexp.escape(z_path)}/).empty?
      zshrc.puts(z_path)
    end
  end

  run %{ sudo apt-get -y install zsh ctags tmux terminator }
end

def want_to_install? (section)
  if ENV["ASK"]=="true"
    puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
    STDIN.gets.chomp == 'y'
  else
    true
  end
end

def write_git_user_file
  puts "======================================================"
  puts "Git user configuration."
  puts "======================================================"

  file_name = "#{ENV["HOME"]}/.gitconfig.user"

  if File.exists?(file_name)
    puts "gitconfig.user file already exists, skipping."
  else
    gh_user = text_input("Git name")
    gh_email = text_input("Git email")

    File.open(file_name, 'w') do |f|
      f.puts("[user]\n  name = #{gh_user}  email = #{gh_email}")
    end
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
  if mac_os?
    run %{ sysctl -n hw.ncpu }
  else
    run %{ nproc }
  end.to_i
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

def install_vim
  run %{which vim}
  unless $?.success?
    puts "======================================================"
    puts "Installing VIM."
    puts "======================================================"
    run %{ sudo apt-get install vim }
  end

  Rake::Task["install_plugs"].execute
end

def install_instant_markdown
  puts "======================================================"
  puts "Installing instant markdown."
  puts "======================================================"
  run %{ npm install -g instant-markdown-d } unless system("npm list -g | grep instant-markdown-d") # dont know if this if is working
  puts
end

def install_fonts
  puts "======================================================"
  puts "Installing patched font Roboto Mono."
  puts "======================================================"
  run %{ cp -f $HOME/.gdf/fonts/* $HOME/Library/Fonts } if RUBY_PLATFORM.downcase.include?("darwin")
  run %{ mkdir -p ~/.fonts && cp ~/.gdf/fonts/* ~/.fonts && fc-cache -vf ~/.fonts } if RUBY_PLATFORM.downcase.include?("linux")
  puts
end

def install_term_theme
  puts "======================================================"
  puts "Installing iTerm2 gruvbox theme."
  puts "======================================================"
  run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Gruvbox Light' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Gruvbox Light.itermcolors' :'Custom Color Presets':'Gruvbox Light'" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Gruvbox Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Gruvbox Dark.itermcolors' :'Custom Color Presets':'Gruvbox Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist }

  # If iTerm2 is not installed or has never run, we can't autoinstall the profile since the plist is not there
  if !File.exists?(File.join(ENV['HOME'], '/Library/Preferences/com.googlecode.iterm2.plist'))
    puts "======================================================"
    puts "To make sure your profile is using the gruvbox theme"
    puts "Please check your settings under:"
    puts "Preferences> Profiles> [your profile]> Colors> Load Preset.."
    puts "======================================================"
    return
  end

  # Ask the user which theme he wants to install
  message = "Which theme would you like to apply to your iTerm2 profile?"
  color_scheme = ask message, iTerm_available_themes

  return if color_scheme == 'None'

  color_scheme_file = File.join('iTerm2', "#{color_scheme}.itermcolors")

  # Ask the user on which profile he wants to install the theme
  profiles = iTerm_profile_list
  message = "I've found #{profiles.size} #{profiles.size>1 ? 'profiles': 'profile'} on your iTerm2 configuration, which one would you like to apply the Gruvbox theme to?"
  profiles << 'All'
  selected = ask message, profiles

  if selected == 'All'
    (profiles.size-1).times { |idx| apply_theme_to_iterm_profile_idx idx, color_scheme_file }
  else
    apply_theme_to_iterm_profile_idx profiles.index(selected), color_scheme_file
  end
end

def iTerm_available_themes
  Dir['iTerm2/*.itermcolors'].map { |value| File.basename(value, '.itermcolors')} << 'None'
end

def iTerm_profile_list
  profiles=Array.new
  begin
    profiles <<  %x{ /usr/libexec/PlistBuddy -c "Print :'New Bookmarks':#{profiles.size}:Name" ~/Library/Preferences/com.googlecode.iterm2.plist 2>/dev/null}
  end while $?.exitstatus==0
  profiles.pop
  profiles
end

def text_input(field)
  puts "#{field}: "
  STDIN.gets
end

def ask(message, values)
  puts message
  while true
    values.each_with_index { |val, idx| puts " #{idx+1}. #{val}" }
    selection = STDIN.gets.chomp
    if (Float(selection)==nil rescue true) || selection.to_i < 0 || selection.to_i > values.size+1
      puts "ERROR: Invalid selection.\n\n"
    else
      break
    end
  end
  selection = selection.to_i-1
  values[selection]
end

def apply_theme_to_iterm_profile_idx(index, color_scheme_path)
  values = Array.new
  16.times { |i| values << "Ansi #{i} Color" }
  values << ['Background Color', 'Bold Color', 'Cursor Color', 'Cursor Text Color', 'Foreground Color', 'Selected Text Color', 'Selection Color']
  values.flatten.each { |entry| run %{ /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':#{index}:'#{entry}'" ~/Library/Preferences/com.googlecode.iterm2.plist } }

  run %{ /usr/libexec/PlistBuddy -c "Merge '#{color_scheme_path}' :'New Bookmarks':#{index}" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ defaults read com.googlecode.iterm2 }
end

def install_oh_my_zsh
  run %{ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" }
end

def install_spaceship_theme
  run %{ git clone https://github.com/denysdovhan/spaceship-prompt.git "#{ENV['HOME']}/.oh-my-zsh/themes/spaceship-prompt" }
  run %{ ln -s "#{ENV['HOME']}/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "#{ENV['HOME']}/.oh-my-zsh/themes/spaceship.zsh-theme" }

  puts "Setting ZSH_THEME to spaceship."
  filename = "#{ENV['HOME']}/.zshrc"
  zshrc = File.readlines(filename)
  # remove current ZSH_THEME
  run %{ awk '!/ZSH_THEME/' #{filename} > ~/.temp && mv ~/.temp #{filename} }
  # add spaceship theme
  run %{ echo ZSH_THEME="'spaceship'" | sudo tee -a "#{ENV['HOME']}/.zshrc" }
end

def install_zplugin
  run %{ mkdir ~/.zplugin }
  run %{ git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin }
  zplugin = "source ~/.zplugin/bin/zplugin.zsh"
  File.open("#{ENV['HOME']}/.zshrc", 'a+') do |zshrc|
    if zshrc.readlines.grep(/#{Regexp.escape(zplugin)}/).empty?
      zshrc.puts(zplugin)
    end
  end
end

def install_zsh_config
  puts "Installing all zsh config"
  source_config_code = "for config_file ($HOME/.gdf/zsh/*.zsh) source $config_file"
  File.open("#{ENV['HOME']}/.zshrc", 'a+') do |zshrc|
    if zshrc.readlines.grep(/#{Regexp.escape(source_config_code)}/).empty?
      zshrc.puts(source_config_code)
    end
  end
  oh_my_zsh = "source $ZSH/oh-my-zsh.sh"
  filename = "#{ENV['HOME']}/.zshrc"
  zshrc = File.readlines(filename)
  run %{ awk '!/source $ZSH/' #{filename} > ~/.temp && mv ~/.temp #{filename} }
  run %{ echo source $ZSH/oh-my-zsh.sh | sudo tee -a "#{ENV['HOME']}/.zshrc" }
end

def set_zsh_as_default_shell
  if "#{ENV['SHELL']}".include? 'zsh' then
    puts "Zsh is already configured as your shell of choice. Restart your session to load the new settings"
  else
    puts "Setting zsh as your default shell"
    if File.exists?("/usr/local/bin/zsh")
      if File.readlines("/private/etc/shells").grep("/usr/local/bin/zsh").empty?
        puts "Adding zsh to standard shell list"
        run %{ echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells }
      end
      run %{ chsh -s /usr/local/bin/zsh }
    else
      run %{ chsh -s /bin/zsh }
    end
  end
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
