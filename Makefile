
VERSION := 23.1
RELEASE :=
ARCH_BUILD :=$(shell uname -m)

all: build

build:
	# --- From old deepin-desktop-base ---
        ifeq (${ARCH_BUILD}, mipsel)
		cp -v files/appstore_loongson.json files/appstore.json
        else ifeq (${ARCH_BUILD}, mips64)
		cp -v files/appstore_loongson.json files/appstore.json
        else ifeq (${ARCH_BUILD}, mips)
		cp -v files/appstore_loongson.json files/appstore.json
        endif
        ifeq (${ARCH_BUILD}, x86_64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version.in > files/desktop-version
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/os-version-amd > files/os-version
        else ifeq (${ARCH_BUILD}, x86_32)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version.in > files/desktop-version
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/os-version-amd > files/os-version
        else ifeq (${ARCH_BUILD}, mipsel)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version-loongson.in > files/desktop-version
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/os-version-loongson > files/os-version
        else ifeq (${ARCH_BUILD}, mips64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version-loongson.in > files/desktop-version
        else ifeq (${ARCH_BUILD}, sw_64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version-sw.in > files/desktop-version
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/os-version-sw > files/os-version
        else ifeq (${ARCH_BUILD}, aarch64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version-arm.in > files/desktop-version
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/os-version-arm > files/os-version
        else ifeq (${ARCH_BUILD}, riscv64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version-riscv.in > files/desktop-version
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/os-version-riscv > files/os-version
        else ifeq (${ARCH_BUILD}, loongarch64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version-loong.in > files/desktop-version
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/os-version-loong > files/os-version
        endif
	sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/lsb-release.in > files/lsb-release

install:
	# --- From old deepin-default-settings ---
	mkdir -p $(DESTDIR)/usr/share
	mkdir -p $(DESTDIR)/etc/fonts/conf.d
	mkdir -p $(DESTDIR)/usr/bin
	cp -r etc.d/* $(DESTDIR)/etc/
	cp -r usr.share.d/* $(DESTDIR)/usr/share
	install -Dm755 dde-first-run $(DESTDIR)/usr/libexec/dde-first-run
	ln -s /usr/libexec/dde-first-run $(DESTDIR)/usr/bin/dde-first-run
	install -Dm644 sysctl.d/00-deepin.conf $(DESTDIR)/usr/lib/sysctl.d/00-deepin.conf
	install -Dm644 udev.rules.d/99-deepin.rules $(DESTDIR)/lib/udev/rules.d/99-deepin.rules
	for i in `ls $(DESTDIR)/usr/share/fontconfig/conf.avail/ | grep .conf$$`;do \
		ln -sf /usr/share/fontconfig/conf.avail/$${i} $(DESTDIR)/etc/fonts/conf.d/$${i}; \
	done
	# --- From old deepin-desktop-base ---
	mkdir -p ${DESTDIR}/etc
	mkdir -p ${DESTDIR}/usr/share/i18n
	mkdir -p ${DESTDIR}/usr/share/distro-info
	mkdir -p ${DESTDIR}/usr/share/python-apt/templates
	#mkdir -p ${DESTDIR}/usr/share/backgrounds/deepin
	mkdir -p ${DESTDIR}/usr/share/deepin
	install -Dm644 files/i18n_dependent.json  ${DESTDIR}/usr/share/i18n/i18n_dependent.json
	install -Dm644 files/language_info.json  ${DESTDIR}/usr/share/i18n/language_info.json
	install -Dm644 files/desktop-version ${DESTDIR}/usr/lib/deepin/desktop-version
	install -Dm644 files/lsb-release     ${DESTDIR}/etc/lsb-release
	#install -Dm644 files/appstore.json     ${DESTDIR}/etc/appstore.json
	install -Dm644 files/deepin-logo.png ${DESTDIR}/usr/share/plymouth/deepin-logo.png
	#install -Dm644 files/desktop.jpg     ${DESTDIR}/usr/share/backgrounds/deepin/desktop.jpg
	#install -Dm644 files/eff98ab2b2d91574a79fabd2b79eb7a9.jpg ${DESTDIR}/var/cache/image-blur/eff98ab2b2d91574a79fabd2b79eb7a9.jpg
	[ -e files/systemd.conf ] && install -Dm644 files/systemd.conf ${DESTDIR}/etc/systemd/system.conf.d/deepin-base.conf
	[ -e files/logind.conf ] && install -Dm644 files/logind.conf ${DESTDIR}/etc/systemd/logind.conf.d/deepin-base.conf
	install -Dm644 files/Deepin.info     ${DESTDIR}/usr/share/python-apt/templates/Deepin.info
	install -Dm644 files/Deepin.mirrors     ${DESTDIR}/usr/share/python-apt/templates/Deepin.mirrors
