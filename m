Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFED529D74B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgJ1WWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732648AbgJ1WWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:25 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE8A2477E;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895015;
        bh=Uz4OwRATxTLBlUxipo4jT2DyhNN6SugfL+n5rgIRc7U=;
        h=From:To:Cc:Subject:Date:From;
        b=dAoKbE8Z9+wkH4E+a9MrBJ1sK0oc/piiTNq1dnE57f4iwvbp+IW3wcWBYz9LWj8cj
         kowjODrZQw5IXD+9C2/iKRAT+v31kgL9rGzFMXqdE7WZVjbxC5rqrhV1S2dQph7DRP
         3ACu4tqjDeT8GZY2vtd2KeXplOo73jYJxiiRoEiI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMN-003hkl-VD; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Anton Vorontsov <anton@enomsg.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benson Leung <bleung@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Colin Cross <ccross@android.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Richard Cochran <richardcochran@gmail.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Tony Luck <tony.luck@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 00/33] ABI: add it to the documentation build system
Date:   Wed, 28 Oct 2020 15:22:58 +0100
Message-Id: <cover.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As requested, this is a rebased version on the top of v5.10-rc1
adding support for having the Linux ABI documentted inside
the Linux admin manual.

When compared with the version I sent years ago, this
version has:

- a logic to detect duplicated ABI symbols;
- it auto-generate cross-reference markups for ABI symbols,
  ABI files and .rst files;
- Other files from 5.10-rc1 required adjustments in order
  to be accepted by the script in rst-source mode;
- Some bug fixes.

PS.: I didn't try to merge it against linux-next yet. So,
I won't doubt that applying it could cause some conflicts.

Feel free to review it.

Regards,
Mauro


Mauro Carvalho Chehab (33):
  scripts: get_abi.pl: change script to allow parsing in ReST mode
  scripts: get_abi.pl: fix parsing on ReST mode
  scripts: get_abi.pl: Allow optionally record from where a line came
    from
  scripts: get_abi.pl: improve its parser to better catch up indentation
  scripts: get_abi.pl: cleanup ABI cross-reference logic
  scripts: get_abi.pl: detect duplicated ABI definitions
  scripts: get_abi.pl: output users in ReST format
  scripts: get_abi.pl: prevent duplicated file names
  scripts: get_abi.pl: use bold font for ABI definitions
  scripts: get_abi.pl: auto-generate cross references
  docs: kernellog.py: add support for info()
  docs: kernel_abi.py: add a script to parse ABI documentation
  docs: kernel_abi.py: fix UTF-8 support
  docs: kernel_abi.py: make it compatible with Sphinx 1.7+
  docs: kernel_abi.py: use --enable-lineno for get_abi.pl
  docs: kernel_abi.py: Handle with a lazy Sphinx parser
  docs: add ABI documentation to the admin-guide book
  docs: ABI: README: specify that files should be ReST compatible
  docs: ABI: stable: make files ReST compatible
  docs: ABI: testing: make the files compatible with ReST output
  docs: ABI: make it parse ABI/stable as ReST-compatible files
  docs: ABI: create a 2-depth index for ABI
  docs: ABI: don't escape ReST-incompatible chars from obsolete and
    removed
  docs: abi-testing.rst: enable --rst-sources when building docs
  docs: Kconfig/Makefile: add a check for broken ABI files
  docs: ABI: convert testing/configfs-acpi to ReST
  docs: ABI: fix syntax to be parsed using ReST notation
  docs: ABI: vdso: use the right format for ABI
  docs: ABI: sysfs-bus-nvdimm: use the right format for ABI
  docs: ABI: cleanup several ABI documents
  docs: ABI: change read/write attributes
  docs: ABI: stable: remove a duplicated documentation
  docs: ABI: unify /sys/class/leds/<led>/max_brightness documentation

 Documentation/ABI/README                      |  10 +-
 Documentation/ABI/obsolete/sysfs-class-dax    |   8 +-
 .../ABI/obsolete/sysfs-driver-hid-roccat-pyra |   3 +
 Documentation/ABI/obsolete/sysfs-gpio         |   2 +
 Documentation/ABI/removed/devfs               |   1 +
 Documentation/ABI/removed/raw1394             |   1 +
 Documentation/ABI/removed/sysfs-class-rfkill  |   2 +-
 Documentation/ABI/removed/video1394           |   1 +
 Documentation/ABI/stable/firewire-cdev        |  67 ++--
 Documentation/ABI/stable/sysfs-acpi-pmprofile |  26 +-
 Documentation/ABI/stable/sysfs-bus-firewire   |   3 +
 Documentation/ABI/stable/sysfs-bus-nvmem      |  19 +-
 Documentation/ABI/stable/sysfs-bus-usb        |   6 +-
 Documentation/ABI/stable/sysfs-bus-vmbus      |   7 -
 Documentation/ABI/stable/sysfs-bus-w1         |   1 +
 .../ABI/stable/sysfs-class-backlight          |   1 +
 .../ABI/stable/sysfs-class-infiniband         |  93 +++--
 Documentation/ABI/stable/sysfs-class-rfkill   |  13 +-
 Documentation/ABI/stable/sysfs-class-tpm      |  94 ++---
 Documentation/ABI/stable/sysfs-devices        |   5 +-
 .../ABI/stable/sysfs-driver-firmware-zynqmp   |  62 ++--
 Documentation/ABI/stable/sysfs-driver-ib_srp  |   1 +
 Documentation/ABI/stable/sysfs-driver-speakup |   4 +
 .../ABI/stable/sysfs-firmware-efi-vars        |   4 +
 .../ABI/stable/sysfs-firmware-opal-dump       |   5 +
 .../ABI/stable/sysfs-firmware-opal-elog       |   2 +
 Documentation/ABI/stable/sysfs-hypervisor-xen |   3 +
 Documentation/ABI/stable/vdso                 |  11 +-
 Documentation/ABI/testing/configfs-acpi       |  34 +-
 Documentation/ABI/testing/configfs-most       | 135 ++++---
 .../ABI/testing/configfs-spear-pcie-gadget    |  36 +-
 Documentation/ABI/testing/configfs-usb-gadget |  83 +++--
 .../ABI/testing/configfs-usb-gadget-ecm       |  12 +-
 .../ABI/testing/configfs-usb-gadget-eem       |  10 +-
 .../ABI/testing/configfs-usb-gadget-hid       |  10 +-
 .../ABI/testing/configfs-usb-gadget-loopback  |   6 +-
 .../testing/configfs-usb-gadget-mass-storage  |  18 +-
 .../ABI/testing/configfs-usb-gadget-midi      |  14 +-
 .../ABI/testing/configfs-usb-gadget-printer   |   6 +-
 .../ABI/testing/configfs-usb-gadget-rndis     |  16 +-
 .../testing/configfs-usb-gadget-sourcesink    |  18 +-
 .../ABI/testing/configfs-usb-gadget-subset    |  10 +-
 .../ABI/testing/configfs-usb-gadget-uac1      |  18 +-
 .../ABI/testing/configfs-usb-gadget-uac2      |  14 +-
 .../ABI/testing/configfs-usb-gadget-uvc       | 220 ++++++-----
 .../ABI/testing/debugfs-cec-error-inj         |   2 +-
 .../ABI/testing/debugfs-driver-habanalabs     |  12 +-
 Documentation/ABI/testing/debugfs-ec          |  11 +-
 Documentation/ABI/testing/debugfs-moxtet      |  30 +-
 .../ABI/testing/debugfs-pfo-nx-crypto         |  28 +-
 Documentation/ABI/testing/debugfs-pktcdvd     |  13 +-
 .../ABI/testing/debugfs-turris-mox-rwtm       |  15 +-
 Documentation/ABI/testing/debugfs-wilco-ec    |  21 +-
 Documentation/ABI/testing/dell-smbios-wmi     |  32 +-
 Documentation/ABI/testing/dev-kmsg            |  27 +-
 Documentation/ABI/testing/evm                 |  17 +-
 Documentation/ABI/testing/gpio-cdev           |  13 +-
 Documentation/ABI/testing/ima_policy          |  30 +-
 Documentation/ABI/testing/procfs-diskstats    |  46 ++-
 Documentation/ABI/testing/procfs-smaps_rollup |  48 +--
 Documentation/ABI/testing/pstore              |  19 +-
 Documentation/ABI/testing/sysfs-block         |  38 +-
 Documentation/ABI/testing/sysfs-block-device  |   2 +
 Documentation/ABI/testing/sysfs-block-rnbd    |   4 +-
 Documentation/ABI/testing/sysfs-bus-acpi      |  19 +-
 .../testing/sysfs-bus-coresight-devices-cti   |  60 +--
 .../testing/sysfs-bus-coresight-devices-etb10 |  21 +-
 .../testing/sysfs-bus-coresight-devices-etm3x |  10 +-
 .../testing/sysfs-bus-coresight-devices-etm4x |  76 ++--
 .../testing/sysfs-bus-coresight-devices-stm   |   2 +-
 .../testing/sysfs-bus-coresight-devices-tmc   |  20 +-
 Documentation/ABI/testing/sysfs-bus-css       |   3 +
 Documentation/ABI/testing/sysfs-bus-dfl       |   2 +
 .../sysfs-bus-event_source-devices-dfl_fme    |  14 +-
 .../sysfs-bus-event_source-devices-format     |   3 +-
 .../sysfs-bus-event_source-devices-hv_24x7    |   6 +-
 .../sysfs-bus-event_source-devices-hv_gpci    |   7 +-
 Documentation/ABI/testing/sysfs-bus-fcoe      |  68 ++--
 Documentation/ABI/testing/sysfs-bus-fsl-mc    |  12 +-
 .../ABI/testing/sysfs-bus-i2c-devices-fsa9480 |  26 +-
 .../ABI/testing/sysfs-bus-i2c-devices-pca954x |  27 +-
 Documentation/ABI/testing/sysfs-bus-i3c       |   2 +
 Documentation/ABI/testing/sysfs-bus-iio       |  30 +-
 .../sysfs-bus-iio-adc-envelope-detector       |   5 +-
 .../ABI/testing/sysfs-bus-iio-adc-hi8435      |   5 +
 .../ABI/testing/sysfs-bus-iio-adc-stm32       |   3 +
 .../ABI/testing/sysfs-bus-iio-cros-ec         |   2 +-
 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 |   8 +-
 .../ABI/testing/sysfs-bus-iio-distance-srf08  |   7 +-
 .../testing/sysfs-bus-iio-frequency-ad9523    |   2 +
 .../testing/sysfs-bus-iio-frequency-adf4371   |  10 +-
 .../ABI/testing/sysfs-bus-iio-health-afe440x  |  12 +-
 .../ABI/testing/sysfs-bus-iio-light-isl29018  |   6 +-
 .../ABI/testing/sysfs-bus-iio-lptimer-stm32   |  29 +-
 .../sysfs-bus-iio-magnetometer-hmc5843        |  19 +-
 .../sysfs-bus-iio-temperature-max31856        |  19 +-
 .../ABI/testing/sysfs-bus-iio-timer-stm32     | 137 ++++---
 .../testing/sysfs-bus-intel_th-devices-gth    |  11 +-
 .../testing/sysfs-bus-intel_th-devices-msc    |   4 +
 Documentation/ABI/testing/sysfs-bus-most      |   6 +-
 .../ABI/testing/sysfs-bus-moxtet-devices      |   6 +-
 Documentation/ABI/testing/sysfs-bus-nfit      |   2 +-
 Documentation/ABI/testing/sysfs-bus-nvdimm    |   6 +
 Documentation/ABI/testing/sysfs-bus-papr-pmem |  23 +-
 Documentation/ABI/testing/sysfs-bus-pci       |  22 +-
 .../testing/sysfs-bus-pci-devices-aer_stats   | 119 +++---
 .../ABI/testing/sysfs-bus-pci-devices-catpt   |   1 +
 .../testing/sysfs-bus-pci-drivers-ehci_hcd    |   4 +-
 Documentation/ABI/testing/sysfs-bus-rapidio   |  23 +-
 Documentation/ABI/testing/sysfs-bus-rbd       |  37 +-
 Documentation/ABI/testing/sysfs-bus-siox      |   3 +
 .../ABI/testing/sysfs-bus-thunderbolt         |  58 +--
 Documentation/ABI/testing/sysfs-bus-usb       |  32 +-
 .../testing/sysfs-bus-usb-devices-usbsevseg   |   7 +-
 Documentation/ABI/testing/sysfs-bus-vfio-mdev |  10 +-
 .../sysfs-class-backlight-driver-lm3533       |  26 +-
 Documentation/ABI/testing/sysfs-class-bdi     |   1 -
 .../ABI/testing/sysfs-class-chromeos          |  15 +-
 Documentation/ABI/testing/sysfs-class-cxl     |  23 +-
 Documentation/ABI/testing/sysfs-class-devfreq |   6 +-
 Documentation/ABI/testing/sysfs-class-devlink |  30 +-
 Documentation/ABI/testing/sysfs-class-extcon  |  34 +-
 .../ABI/testing/sysfs-class-fpga-manager      |   5 +-
 Documentation/ABI/testing/sysfs-class-gnss    |   2 +
 Documentation/ABI/testing/sysfs-class-led     |  28 +-
 .../testing/sysfs-class-led-driver-el15203000 | 229 ++++++------
 .../ABI/testing/sysfs-class-led-driver-lm3533 |  44 ++-
 .../ABI/testing/sysfs-class-led-driver-sc27xx |   4 +-
 .../ABI/testing/sysfs-class-led-flash         |  27 +-
 .../ABI/testing/sysfs-class-led-multicolor    |  23 +-
 .../testing/sysfs-class-led-trigger-netdev    |   7 +
 .../testing/sysfs-class-led-trigger-usbport   |   1 +
 .../ABI/testing/sysfs-class-leds-gt683r       |   8 +-
 Documentation/ABI/testing/sysfs-class-mic     |  52 ++-
 Documentation/ABI/testing/sysfs-class-net     |  61 +++-
 .../ABI/testing/sysfs-class-net-cdc_ncm       |   6 +-
 .../ABI/testing/sysfs-class-net-phydev        |   2 +
 Documentation/ABI/testing/sysfs-class-ocxl    |  17 +-
 Documentation/ABI/testing/sysfs-class-pktcdvd |  36 +-
 Documentation/ABI/testing/sysfs-class-power   |  85 ++++-
 .../ABI/testing/sysfs-class-power-mp2629      |   1 +
 .../ABI/testing/sysfs-class-power-twl4030     |  33 +-
 .../ABI/testing/sysfs-class-power-wilco       |  18 +-
 Documentation/ABI/testing/sysfs-class-rapidio |  46 +--
 Documentation/ABI/testing/sysfs-class-rc      |  30 +-
 .../ABI/testing/sysfs-class-regulator         |  36 +-
 .../ABI/testing/sysfs-class-remoteproc        |  14 +-
 .../ABI/testing/sysfs-class-rnbd-client       |  93 ++---
 ...ysfs-class-rtc-rtc0-device-rtc_calibration |   1 +
 .../ABI/testing/sysfs-class-rtrs-client       |  23 +-
 .../ABI/testing/sysfs-class-scsi_host         |   7 +-
 Documentation/ABI/testing/sysfs-class-typec   |  12 +-
 Documentation/ABI/testing/sysfs-class-uwb_rc  |  13 +-
 .../ABI/testing/sysfs-class-watchdog          |   7 +-
 Documentation/ABI/testing/sysfs-dev           |   7 +-
 .../ABI/testing/sysfs-devices-mapping         |  41 ++-
 .../ABI/testing/sysfs-devices-memory          |  15 +-
 .../testing/sysfs-devices-platform-ACPI-TAD   |   4 +
 .../sysfs-devices-platform-_UDC_-gadget       |  10 +-
 .../ABI/testing/sysfs-devices-platform-docg3  |  10 +-
 .../ABI/testing/sysfs-devices-platform-ipmi   |  52 +--
 .../sysfs-devices-platform-sh_mobile_lcdc_fb  |   8 +-
 .../sysfs-devices-platform-stratix10-rsu      |  10 +
 .../ABI/testing/sysfs-devices-system-cpu      | 101 ++++--
 .../ABI/testing/sysfs-devices-system-ibm-rtl  |   6 +-
 .../testing/sysfs-driver-bd9571mwv-regulator  |   4 +
 Documentation/ABI/testing/sysfs-driver-genwqe |  11 +-
 .../ABI/testing/sysfs-driver-hid-lenovo       |  10 +
 .../testing/sysfs-driver-hid-logitech-lg4ff   |  18 +-
 .../ABI/testing/sysfs-driver-hid-ntrig        |  13 +-
 .../ABI/testing/sysfs-driver-hid-roccat-kone  |  19 +
 .../ABI/testing/sysfs-driver-hid-wiimote      |  12 +-
 .../ABI/testing/sysfs-driver-input-exc3000    |   2 +
 .../ABI/testing/sysfs-driver-jz4780-efuse     |   6 +-
 .../ABI/testing/sysfs-driver-pciback          |   6 +-
 .../ABI/testing/sysfs-driver-samsung-laptop   |  13 +-
 .../ABI/testing/sysfs-driver-toshiba_acpi     |  26 ++
 .../ABI/testing/sysfs-driver-toshiba_haps     |   2 +
 Documentation/ABI/testing/sysfs-driver-ufs    | 228 +++++++++---
 .../ABI/testing/sysfs-driver-w1_ds28e17       |   3 +
 .../ABI/testing/sysfs-driver-w1_therm         |  75 ++--
 Documentation/ABI/testing/sysfs-driver-wacom  |   4 +-
 Documentation/ABI/testing/sysfs-firmware-acpi | 237 ++++++------
 .../ABI/testing/sysfs-firmware-dmi-entries    |  50 +--
 .../ABI/testing/sysfs-firmware-efi-esrt       |  28 +-
 .../testing/sysfs-firmware-efi-runtime-map    |  14 +-
 Documentation/ABI/testing/sysfs-firmware-gsmi |   2 +-
 .../ABI/testing/sysfs-firmware-memmap         |  16 +-
 .../ABI/testing/sysfs-firmware-qemu_fw_cfg    |  20 +-
 Documentation/ABI/testing/sysfs-firmware-sfi  |   6 +-
 .../ABI/testing/sysfs-firmware-sgi_uv         |   6 +-
 .../testing/sysfs-firmware-turris-mox-rwtm    |  10 +-
 Documentation/ABI/testing/sysfs-fs-ext4       |   4 +-
 Documentation/ABI/testing/sysfs-fs-f2fs       |  48 ++-
 .../ABI/testing/sysfs-hypervisor-xen          |  13 +-
 .../ABI/testing/sysfs-kernel-boot_params      |  23 +-
 .../ABI/testing/sysfs-kernel-mm-hugepages     |  12 +-
 Documentation/ABI/testing/sysfs-kernel-mm-ksm |   5 +-
 Documentation/ABI/testing/sysfs-kernel-slab   |   3 +
 Documentation/ABI/testing/sysfs-module        |  17 +-
 .../ABI/testing/sysfs-platform-asus-laptop    |  21 +-
 .../ABI/testing/sysfs-platform-asus-wmi       |   1 +
 Documentation/ABI/testing/sysfs-platform-at91 |  10 +-
 .../ABI/testing/sysfs-platform-dell-laptop    |  10 +-
 .../ABI/testing/sysfs-platform-dell-smbios    |   4 +-
 .../ABI/testing/sysfs-platform-dfl-fme        |  14 +-
 Documentation/ABI/testing/sysfs-platform-dptf |  11 +-
 .../ABI/testing/sysfs-platform-eeepc-laptop   |  14 +-
 .../testing/sysfs-platform-i2c-demux-pinctrl  |   4 +-
 .../ABI/testing/sysfs-platform-ideapad-laptop |   9 +-
 .../sysfs-platform-intel-wmi-sbl-fw-update    |   1 +
 .../sysfs-platform-intel-wmi-thunderbolt      |   1 +
 Documentation/ABI/testing/sysfs-platform-kim  |   1 +
 .../testing/sysfs-platform-mellanox-bootctl   |  50 ++-
 .../testing/sysfs-platform-phy-rcar-gen3-usb2 |  10 +-
 .../ABI/testing/sysfs-platform-renesas_usb3   |  10 +-
 .../ABI/testing/sysfs-platform-sst-atom       |  13 +-
 .../ABI/testing/sysfs-platform-usbip-vudc     |  11 +-
 .../ABI/testing/sysfs-platform-wilco-ec       |   1 +
 Documentation/ABI/testing/sysfs-power         |  21 +-
 Documentation/ABI/testing/sysfs-profiling     |   2 +-
 Documentation/ABI/testing/sysfs-ptp           |   2 +-
 Documentation/ABI/testing/sysfs-uevent        |  10 +-
 Documentation/ABI/testing/sysfs-wusb_cbaf     |   3 +-
 Documentation/ABI/testing/usb-charger-uevent  |  82 +++--
 Documentation/ABI/testing/usb-uevent          |  32 +-
 Documentation/Kconfig                         |  10 +
 Documentation/Makefile                        |   5 +
 Documentation/admin-guide/abi-obsolete.rst    |  11 +
 Documentation/admin-guide/abi-removed.rst     |   5 +
 Documentation/admin-guide/abi-stable.rst      |  14 +
 Documentation/admin-guide/abi-testing.rst     |  20 +
 Documentation/admin-guide/abi.rst             |  11 +
 Documentation/admin-guide/index.rst           |   2 +
 Documentation/conf.py                         |   3 +-
 Documentation/sphinx/kernel_abi.py            | 194 ++++++++++
 Documentation/sphinx/kernellog.py             |   6 +-
 lib/Kconfig.debug                             |   2 +
 scripts/get_abi.pl                            | 342 ++++++++++++------
 239 files changed, 3767 insertions(+), 2111 deletions(-)
 create mode 100644 Documentation/admin-guide/abi-obsolete.rst
 create mode 100644 Documentation/admin-guide/abi-removed.rst
 create mode 100644 Documentation/admin-guide/abi-stable.rst
 create mode 100644 Documentation/admin-guide/abi-testing.rst
 create mode 100644 Documentation/admin-guide/abi.rst
 create mode 100644 Documentation/sphinx/kernel_abi.py

-- 
2.26.2


