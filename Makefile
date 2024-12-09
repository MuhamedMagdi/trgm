SCRIPT_NAME = trgm
SCRIPT_PATH = ./trgm.sh
INSTALL_DIR = /usr/local/bin

install:
	echo "Installing jq"
	sudo apt update
	sudo apt install -y jq
	echo "jq has been installed successfully."

	cp $(SCRIPT_PATH) $(INSTALL_DIR)/$(SCRIPT_NAME)
	chmod +x $(INSTALL_DIR)/$(SCRIPT_NAME)
	echo "$(SCRIPT_NAME) has been installed to $(INSTALL_DIR) and is now executable."

uninstall:
	rm -f $(INSTALL_DIR)/$(SCRIPT_NAME)
	echo "$(SCRIPT_NAME) has been removed from $(INSTALL_DIR)."

