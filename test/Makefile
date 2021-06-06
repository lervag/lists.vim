MYVIM ?= nvim --headless
# MYVIM ?= vim -T dumb --not-a-term --noplugin -n
export QUIT = 1

tests := $(wildcard test*.vim)

.PHONY: test sysinfo $(tests)

test: $(tests)

$(tests):
	@$(MYVIM) -u $@

sysinfo:
	@echo "**** SYSTEM INFORMATION ****"
	@-git log -1
	@-$(MYVIM) --version
	@echo "**** SYSTEM INFORMATION ****"

# Ensure that some goals are run first/last
ifndef MAKECMDGOALS
$(TESTS): sysinfo
endif
