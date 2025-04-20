# Makefile for mpm
# Version 2.3-3

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib/mpm
DOCDIR ?= $(PREFIX)/share/doc/mpm
LICENSEDIR ?= /usr/share/licenses/mpm

.PHONY: all install uninstall

all: install

install:
	@echo "Starting mpm installation..."
	@install -v -Dm755 mpm $(DESTDIR)$(BINDIR)/mpm
	@install -v -dm755 $(DESTDIR)$(LIBDIR)
	@cp -v -r lib/* $(DESTDIR)$(LIBDIR)/
	@install -v -dm755 $(DESTDIR)$(DOCDIR)
	@install -v -m644 doc/* $(DESTDIR)$(DOCDIR)/
	@install -v -m644 README.md $(DESTDIR)$(DOCDIR)/
	@install -v -dm755 $(DESTDIR)$(LICENSEDIR)
	@install -v -m644 LICENSE $(DESTDIR)$(LICENSEDIR)/LICENSE
	@echo "Installation complete!"
	@echo "For usage run: mpm --help"

uninstall:
	@echo "Starting mpm uninstallation..."
	@rm -v -f $(DESTDIR)$(BINDIR)/mpm
	@rm -v -rf $(DESTDIR)$(LIBDIR)
	@rm -v -rf $(DESTDIR)$(DOCDIR)
	@rm -v -rf $(DESTDIR)$(LICENSEDIR)
	@echo "Uninstallation complete!"

help:
	@echo "Available targets:"
	@echo "  install   - Install mpm"
	@echo "  uninstall - Remove mpm"
	@echo "  help      - Show this help message"
	@echo
	@echo "Variables:"
	@echo "  PREFIX    - Installation prefix (default: /usr/local)"
	@echo "  BINDIR    - Binary directory (default: \$${PREFIX}/bin)"
	@echo "  LIBDIR    - Library directory (default: \$${PREFIX}/lib/mpm)"
	@echo "  DOCDIR    - Documentation directory (default: \$${PREFIX}/share/doc/mpm)"
	@echo "  LICENSEDIR - License directory (default: /usr/share/licenses/mpm)"
