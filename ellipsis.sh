#!/bin/bash

osx() {
	${PKG_PATH}/lib/brew
	if utils.prompt "This step may modify your OS X system defaults. Continue? (y/n)"; then
		${PKG_PATH}/lib/osxdefaults
	fi
}

##############################################################################

linux() {
	${PKG_PATH}/lib/apt

	if utils.prompt "This step may modify your Ubuntu system defaults. Continue? (y/n)"; then
		${PKG_PATH}/lib/ubuntudefaults
	fi
}

##############################################################################

pkg.link() {
	fs.link_files shell
}

##############################################################################

pkg.install() {
	# Install Ellipsis-TPM if not already installed
	ellipsis install ellipsis-tpm
	case $(os.platform) in
		osx)
			osx
			;;
		linux)
			linux
			;;
	esac
	# Install plugins
	ellipsis-tpm install
}

##############################################################################

 pkg.pull() {
    # Update dot-tmux repo
    git.pull
		# Update/install packages
		case $(os.platform) in
			osx)
				osx
				;;
			linux)
				linux
				;;
		esac
    # Clean and update plugins
    ellipsis-tpm clean
    ellipsis-tpm update
 }
