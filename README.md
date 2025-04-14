# Dotfiles

You found my dotfiles! 🐦

## What is this?

This repository houses my [dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments), and a few other niceities. I use the contents of this repository to set up my development environment, and customize my system. It contains:

 - Configuration files for various tools I use (e.g. [Neovim](https://neovim.io/), [Tmux](https://github.com/tmux/tmux/wiki), etc.), for both Windows and WSL2.
 - Installation scripts for setting up my Windows and WSL2 development environment. (Installing tools, setting up symlinks, etc.)
 - A few scripts to automate common tasks, or that improve my workflow (such as AHK scripts that open my terminal).
 - A few templates for files I use often (e.g. [.editorconfig](https://editorconfig.org/) ).

## Who is this for?

Well honestly, this repository is mostly just for my personal use. However, I have made it public in case someone else finds it interesting to see my setup, or otherwise useful! 
There are a few reasons why you might want to use a setup like this:

 - **Consistency:** You can use the same configuration files across all your systems, and keep them in sync.
 - **Ease of use:** You can set up your development environment with a single command. (If everything goes well, that is.)
 - **Customization:** You can tailor the configuration files to your own needs.
 - **Versioning:** You can keep track of changes to your configuration files, and revert to older versions if needed.

### When should you *not* use this repository?

 - **If you are not a fan of tinkering:** This repository is likely not a one-size-fits-all solution to your problems. You will need to customize it to your own needs.
 - **If you are not familiar with WSL:** This repository is tailored to a Linux Mint setup. AFAIK it works on WSL too, though not everything is as useful there.
 - **If you expect everything to work forever:** Software evolves, and so do the tools in this repository. You will need to keep your configuration files up-to-date, and potentially fix issues that arise from breaking changes in the tools you use.
 - **If you are not a ['smelly nerd' 😏](https://github.com/sherlock-project/sherlock/issues/2011#issue-2143280124)**

### When *would* you use (a setup similar to) this repository?

 - **If you work on multiple systems:** You can keep your configuration files in sync across all your systems. (Who hasn't tried to hit that one keyboard shortcut that only works on your personal system, or tried to use that one CLI tool that you forgot to install on your work laptop?)
 - **If you like to automate things:** You can automate the setup of your development environment. (It may take longer to set up your installation scripts, but there is a great satisfaction in just running `install/install-linux.sh` and having everything set up and ready to go.)
 - **If you like to be on top of things:** You are ultimately responsible for your own setup, and are not reliant on others to keep your tools up-to-date. (This can be a double-edged sword)
 - **If you want to learn:** You can learn a lot about how your tools work, and how to automate your own setup.
 - **If you came here to ~steal my config~ be inspired:** Feel free to dig around in my .dotfiles and nab just the parts you like, I took inspiration from many-a-dotfile. Just promise to not attempt to monetize them.

Just know that you *will* need to invest some time to get everything set up the way you like it, and you *will* inevitably run into some unforeseen issue some day, as software evolves and things start introducing breaking changes. (But honestly, that's part of the fun, right?)

## How does it work?

A brief overview of how my setup in this repository works:

 - The repository houses configuration files, and lives at the home directory (`~/.dotfiles`) on your system. 
 - The installation scripts in this repository set up your development environment by:
   - Installing the tools you need.
   - Setting up symlinks to the configuration files in this repository (leveraging GNU [stow](https://www.gnu.org/software/stow/))
   - Performing other tasks, such as installing fonts, adding programs to Windows' startup cycle, etc.
 - The installation script `/install/install-linux.sh` is the global entry point for all installations. It runs all the scripts that are listed in `install/active.conf`, in consecutive order.
 - A primitive dependency system is in place:
   - An installation script may depend on other installations to be run before it (e.g. we need `git` before we can `git clone`).
   - Before installing, the installation script scans all the files in its respective `active.conf` file line by line, and checks if they list any dependencies (using a line with the format `# Deps: <tool1>, <tool2>, etc...`), if they do, these must be listed with a prior install script.
   - e.g. if a script `install-foo.sh` lists two dependencies with `# Deps: bar, baz`, then the installation will only start if there are two scripts `install-bar.sh` and `install-baz.sh` listed before `install-foo.sh` in the `active.conf` file.
   - a.e.g. if a script `install-foo.sh` contains a `git clone` command, we need git to execute the installer. So, you should add the line `# Deps: git` to the install file, then add a script that installs git named `install-git.sh`, and list it before `install-foo.sh` in the `active.conf` file.
   - ⚠️ This is a very primitive system, and it relies on you to list the dependencies correctly, but it is very helpful when troubleshooting installation issues down the line.

## How do I use this?

> ⚠️ This repository is tailored to my own workflow, and you might not need everything in here. That is why I would recommend you to fork this repository and customize it to your own needs. I may add or remove configuration and tooling from this repository over time, and you may not want to keep up with those changes. By forking this repository, you can keep your own version of the configuration files, and cherry-pick the changes you want to keep up with. You can also [contribute](#contributing) useful additions or bugfixes to this repository by submitting pull requests.

Simply cloning this repository won't be enough. Your system needs to know to use the configuration files listed in this repository. It also needs to install the related software. This is done automatically by running the `install/install.sh` script in this repository. You can configure exactly which install scripts run, or the order in which they run, by editing the `install/active.conf`.


### Installation

> ⚠️ Any shell commands listed below should be run in your WSL bash shell, unless otherwise specified.

For an **as-is installation**, you can follow these steps:

 1. Fork this repository. (Click the "Fork" button in the top right corner of this page)
 2. Open up a terminal in WSL (e.g. run `wsl` in cmd).
 3. Clone your fork: `git clone <LINK TO YOUR FORK HERE> ~/.dotfiles`
 4. `cd ~/.dotfiles/install`
 5. `chmod +x install.sh`
 6. `./install.sh`
 7. Follow the instructions on the screen.

### Customization

For a customized installation, you can alter the `install/install.sh` script to your liking.

 - **Example customization 1:** You don't want to install Neovim.
   - Remove or comment out the `./apt/install-neovim.sh` line in `install/bash/active.conf`.
 - **Example customization 2:** You want to add a new tool to install.
   - Create a new bash script in (a sub-directory of) `install`. (e.g. `echo #!/bin/bash >> ~/.dotfiles/install/bash/apt/install-foo.sh`)
   - Write the installation instructions for that script (e.g. `sudo apt-get foo -y`, then also perform any potential symlinks, etc.)
   - Add a line that says `# Deps: <tool1> <tool2> ...` to the script, listing the dependencies of the script. (ℹ️  Any dependencies listed here should be installed with an install script sharing the same name as the dependency (e.g. if `install-foo.sh` lists `bar` as a dependency, there should be an `install-bar.sh` script listed before `install-foo.sh` in the `active.conf` file.)
   - Add the absolute or relative path of the new installation script to the `active.conf` file.

### Updating and versioning

Updating your configuration across systems is as simple as editing the .dotfiles in this repository, and then committing and pushing the changes.
You can then pull the changes on your other systems, and optionally run the `install.sh` script again to apply additional changes to your software. Git also keeps track of the changes you made, so you can always revert to an older version of your configuration if you run into issues.

> ℹ️  Tip: You can also run separate install scripts manually, if you `chmod +x` them first.

Updating already installed software, or targeting specific versions, is a bit more involved. Some of these installation files try to get the latest version of some software. You can alter the installation scripts to suit your specific versioning needs. Try to use the package manager of your UNIX-system to install software where possible (`apt` for Ubuntu, which is the WSL2 default). If you run into specific versioning issues, it may be best to consult the documentation of the software you are trying to update.

## Contributing

If you have any suggestions, improvements, or additions to this repository, feel free to submit a pull request! I am always open to new ideas, and I would love to see how you have customized your own setup. If you have any questions, feel free to open an issue, and I will try to help you out on my own time.
However, please keep in mind that this repository is tailored to my own workflow, and I may not accept all changes, even if they are really cool! 

I would recommend you to fork this repository and customize it to your own needs. I have no specific rules or style-guides for contributing to this repository, I just expect you to be sensible ♥️ .
