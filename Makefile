# Makefile for mpm
# Version 2.5-1

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib/mpm
DOCDIR ?= $(PREFIX)/share/doc/mpm
LICENSEDIR ?= /usr/share/licenses/mpm
MANDIR ?= $(PREFIX)/share/man
USERNAME ?= $(shell whoami)
CONF_DIR = $(shell [ "$(USERNAME)" = "root" ] && echo "/etc/mpm" || echo "/home/$(USERNAME)/.config/mpm")
USERGROUP ?= $(shell id -g $(USERNAME))

.PHONY: all install uninstall upgrade config diff-config check-root

all: install

check-root:
	@if [ "$(USERNAME)" != "root" ]; then \
		echo "Error: Root privileges required for this operation"; \
		echo "Please run with sudo or as root"; \
		exit 1; \
	fi

install: check-root config
	@echo "Starting mpm installation..."
	@install -v -Dm755 mpm $(DESTDIR)$(BINDIR)/mpm
	@rm -v -rf $(DESTDIR)$(LIBDIR)
	@install -v -dm755 $(DESTDIR)$(LIBDIR)
	@cp -v -r lib/* $(DESTDIR)$(LIBDIR)/
	@chmod 755 $(DESTDIR)$(LIBDIR)/*
	@install -v -dm755 $(DESTDIR)$(DOCDIR)
	@install -v -m644 doc/* $(DESTDIR)$(DOCDIR)/
	@install -v -m644 README.md $(DESTDIR)$(DOCDIR)/
	@install -v -m644 README_FIRST $(DESTDIR)$(DOCDIR)/
	@install -v -dm755 $(DESTDIR)$(DOCDIR)/extra
	@cp -v -r extra/* $(DESTDIR)$(DOCDIR)/extra/
	@install -v -dm755 $(DESTDIR)$(LICENSEDIR)
	@install -v -m644 LICENSE $(DESTDIR)$(LICENSEDIR)/LICENSE
	@install -v -dm755 $(DESTDIR)$(MANDIR)/man1
	@install -v -m644 man/mpm.1 $(DESTDIR)$(MANDIR)/man1/mpm.1
	@gzip -f $(DESTDIR)$(MANDIR)/man1/mpm.1
	@echo "Installation complete!"
	@echo "For usage run: mpm --help"
	@echo "You can now as regular user run: make config"
	@echo "or make diff-config if you just upgraded mpm."

config:
	@if [ "$(USERNAME)" != "root" ]; then \
		echo "Setting up configuration files..."; \
		install -v -dm755 $(CONF_DIR); \
		if [ ! -f $(CONF_DIR)/mpmrc ]; then \
			install -v -m644 doc/mpmrc $(CONF_DIR)/mpmrc; \
			install -v -m644 doc/themerc $(CONF_DIR)/themerc; \
			chown -R $(USERNAME):$(USERGROUP) $(CONF_DIR); \
			echo "Created new config files in $(CONF_DIR)"; \
			echo "Please edit your mpmrc file before first run."; \
		fi \
	fi

diff-config:
	@if [ "$(USERNAME)" != "root" ] && [ -f $(CONF_DIR)/mpmrc ]; then \
		diff -u $(CONF_DIR)/mpmrc doc/mpmrc > $(CONF_DIR)/mpmrc.diff || true; \
		cp $(CONF_DIR)/mpmrc $(CONF_DIR)/mpmrc.orig; \
		patch $(CONF_DIR)/mpmrc < $(CONF_DIR)/mpmrc.diff || true; \
	fi
	@if [ "$(USERNAME)" != "root" ] && [ -f $(CONF_DIR)/themerc ]; then \
		diff -u $(CONF_DIR)/themerc doc/themerc > $(CONF_DIR)/themerc.diff || true; \
		cp $(CONF_DIR)/themerc $(CONF_DIR)/themerc.orig; \
		patch $(CONF_DIR)/themerc < $(CONF_DIR)/themerc.diff || true; \
	fi
	@if [ "$(USERNAME)" != "root" ]; then \
		echo "Configuration files have been updated."; \
		echo "Original files saved as *.orig"; \
		echo "Check $(CONF_DIR)/mpmrc.diff for changes"; \
	fi

upgrade: check-root uninstall install diff-config

uninstall: check-root
	@echo "Starting mpm uninstallation..."
	@rm -v -f $(DESTDIR)$(BINDIR)/mpm
	@rm -v -rf $(DESTDIR)$(LIBDIR)
	@rm -v -rf $(DESTDIR)$(DOCDIR)
	@rm -v -rf $(DESTDIR)$(LICENSEDIR)
	@rm -v -f $(DESTDIR)$(MANDIR)/man1/mpm.1.gz
	@echo "Uninstallation complete!"
	@echo "Note: User configuration in $(CONF_DIR) has been preserved"

help:
	@echo "Available targets:"
	@echo "  install     - Install mpm (requires root)"
	@echo "  uninstall   - Remove mpm (requires root, preserves user config)"
	@echo "  upgrade     - Upgrade mpm and update config files (requires root)"
	@echo "  config      - Set up initial config files (as regular user)"
	@echo "  diff-config - Update existing config files (as regular user)"
	@echo "  help        - Show this help message"
	@echo
	@echo "Variables:"
	@echo "  PREFIX     - Installation prefix (default: /usr/local)"
	@echo "  BINDIR     - Binary directory (default: \$${PREFIX}/bin)"
	@echo "  LIBDIR     - Library directory (default: \$${PREFIX}/lib/mpm)"
	@echo "  DOCDIR     - Documentation directory (default: \$${PREFIX}/share/doc/mpm)"
	@echo "  LICENSEDIR - License directory (default: /usr/share/licenses/mpm)"
	@echo "  MANDIR     - Manual pages directory (default: \$${PREFIX}/share/man)"
	@echo "  USERNAME   - User to own config files (default: current user)"
