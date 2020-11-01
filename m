Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADA82A1E35
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgKANKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKANKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:10:19 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EE52223F;
        Sun,  1 Nov 2020 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236217;
        bh=BW2gVbmCrBLndvrxcFEZpY86C5npGBgIkYqONCDRrw4=;
        h=Date:From:To:Cc:Subject:From;
        b=r+wgwQOrITFXgZp9Nb9DLHMWa+jsEuC0uZyyQuEWWbFFTev/JHU3zTEERBNYXVbUN
         zj/OV1hXptxs0rGV7MA+l/0XxBV0OEvb5VzKd1ziteLoeDfEenLpgpJ8fjDllB9jxY
         DXOs052usglcImgKDD+f6BZvdYhU2OPMSLALC4LM=
Date:   Sun, 1 Nov 2020 14:11:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core / Documentation fixes for 5.10-rc2
Message-ID: <20201101131100.GA4127706@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc2

for you to fetch changes up to 2fcce37a3d2f2f3d7fa36aad2b71cbaca135ffd4:

  scripts: get_abi.pl: assume ReST format by default (2020-10-30 13:16:03 +0100)

----------------------------------------------------------------
Driver core / Documentation fixes for 5.10-rc2

Here is one tiny debugfs change to fix up an API where the last user was
successfully fixed up in 5.10-rc1 (so it couldn't be merged earlier),
and a much larger Documentation/ABI/ update to the files so they can be
automatically parsed by our tools.

The Documentation/ABI/ updates are just formatting issues, small ones to
bring the files into parsable format, and have been acked by numerous
subsystem maintainers and the documentation maintainer.  I figured it
was good to get this into 5.10-rc2 to help with the merge issues that
would arise if these were to stick in linux-next until 5.11-rc1.

The debugfs change has been in linux-next for a long time, and the
Documentation updates only for the last linux-next release.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      debugfs: remove return value of debugfs_create_devm_seqfile()

Mauro Carvalho Chehab (39):
      scripts: get_abi.pl: change script to allow parsing in ReST mode
      scripts: get_abi.pl: fix parsing on ReST mode
      scripts: get_abi.pl: Allow optionally record from where a line came from
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
      docs: ABI: sysfs-uevent: make it compatible with ReST output
      docs: ABI: make it parse ABI/stable as ReST-compatible files
      docs: ABI: create a 2-depth index for ABI
      docs: ABI: don't escape ReST-incompatible chars from obsolete and removed
      docs: abi-testing.rst: enable --rst-sources when building docs
      docs: Kconfig/Makefile: add a check for broken ABI files
      docs: ABI: convert testing/configfs-acpi to ReST
      docs: ABI: fix syntax to be parsed using ReST notation
      docs: ABI: vdso: use the right format for ABI
      docs: ABI: sysfs-bus-nvdimm: use the right format for ABI
      docs: ABI: cleanup several ABI documents
      docs: ABI: change read/write attributes
      docs: ABI: stable: remove a duplicated documentation
      docs: ABI: unify /sys/class/leds/<led>/brightness documentation
      docs: ABI: sysfs-class-power: unify duplicated properties
      docs: ABI: sysfs-c2port: remove a duplicated entry
      docs: ABI: sysfs-class-backlight: unify ABI documentation
      docs: ABI: sysfs-class-led-trigger-pattern: remove hw_pattern duplication
      scripts: get_abi.pl: assume ReST format by default

 Documentation/ABI/README                           |  10 +-
 Documentation/ABI/obsolete/sysfs-class-dax         |   8 +-
 .../ABI/obsolete/sysfs-driver-hid-roccat-pyra      |   3 +
 Documentation/ABI/obsolete/sysfs-gpio              |   2 +
 Documentation/ABI/removed/devfs                    |   1 +
 Documentation/ABI/removed/raw1394                  |   1 +
 Documentation/ABI/removed/sysfs-class-rfkill       |   2 +-
 Documentation/ABI/removed/video1394                |   1 +
 Documentation/ABI/stable/firewire-cdev             |  69 +--
 Documentation/ABI/stable/sysfs-acpi-pmprofile      |  26 +-
 Documentation/ABI/stable/sysfs-bus-firewire        |   3 +
 Documentation/ABI/stable/sysfs-bus-nvmem           |  19 +-
 Documentation/ABI/stable/sysfs-bus-usb             |   6 +-
 Documentation/ABI/stable/sysfs-bus-vmbus           |   7 -
 Documentation/ABI/stable/sysfs-bus-w1              |   1 +
 Documentation/ABI/stable/sysfs-class-backlight     |   1 +
 Documentation/ABI/stable/sysfs-class-infiniband    |  93 ++--
 Documentation/ABI/stable/sysfs-class-rfkill        |  13 +-
 Documentation/ABI/stable/sysfs-class-tpm           | 100 ++--
 Documentation/ABI/stable/sysfs-devices             |   5 +-
 .../ABI/stable/sysfs-driver-firmware-zynqmp        |  62 ++-
 Documentation/ABI/stable/sysfs-driver-ib_srp       |   1 +
 Documentation/ABI/stable/sysfs-driver-speakup      |   4 +
 Documentation/ABI/stable/sysfs-firmware-efi-vars   |   4 +
 Documentation/ABI/stable/sysfs-firmware-opal-dump  |   5 +
 Documentation/ABI/stable/sysfs-firmware-opal-elog  |   2 +
 Documentation/ABI/stable/sysfs-hypervisor-xen      |   3 +
 Documentation/ABI/stable/vdso                      |  11 +-
 Documentation/ABI/testing/configfs-acpi            |  34 +-
 Documentation/ABI/testing/configfs-most            | 135 ++++--
 .../ABI/testing/configfs-spear-pcie-gadget         |  36 +-
 Documentation/ABI/testing/configfs-usb-gadget      |  87 ++--
 Documentation/ABI/testing/configfs-usb-gadget-ecm  |  12 +-
 Documentation/ABI/testing/configfs-usb-gadget-eem  |  10 +-
 Documentation/ABI/testing/configfs-usb-gadget-hid  |  10 +-
 .../ABI/testing/configfs-usb-gadget-loopback       |   6 +-
 .../ABI/testing/configfs-usb-gadget-mass-storage   |  18 +-
 Documentation/ABI/testing/configfs-usb-gadget-midi |  14 +-
 .../ABI/testing/configfs-usb-gadget-printer        |   6 +-
 .../ABI/testing/configfs-usb-gadget-rndis          |  16 +-
 .../ABI/testing/configfs-usb-gadget-sourcesink     |  18 +-
 .../ABI/testing/configfs-usb-gadget-subset         |  10 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac1 |  18 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |  14 +-
 Documentation/ABI/testing/configfs-usb-gadget-uvc  | 220 +++++----
 Documentation/ABI/testing/debugfs-cec-error-inj    |   2 +-
 .../ABI/testing/debugfs-driver-habanalabs          |  12 +-
 Documentation/ABI/testing/debugfs-ec               |  11 +-
 Documentation/ABI/testing/debugfs-moxtet           |  30 +-
 Documentation/ABI/testing/debugfs-pfo-nx-crypto    |  28 +-
 Documentation/ABI/testing/debugfs-pktcdvd          |  13 +-
 Documentation/ABI/testing/debugfs-turris-mox-rwtm  |  15 +-
 Documentation/ABI/testing/debugfs-wilco-ec         |  21 +-
 Documentation/ABI/testing/dell-smbios-wmi          |  32 +-
 Documentation/ABI/testing/dev-kmsg                 |  27 +-
 Documentation/ABI/testing/evm                      |  17 +-
 Documentation/ABI/testing/gpio-cdev                |  13 +-
 Documentation/ABI/testing/ima_policy               |  30 +-
 Documentation/ABI/testing/procfs-diskstats         |  46 +-
 Documentation/ABI/testing/procfs-smaps_rollup      |  48 +-
 Documentation/ABI/testing/pstore                   |  19 +-
 Documentation/ABI/testing/sysfs-block              |  38 +-
 Documentation/ABI/testing/sysfs-block-device       |   2 +
 Documentation/ABI/testing/sysfs-block-rnbd         |   4 +-
 Documentation/ABI/testing/sysfs-bus-acpi           |  19 +-
 .../ABI/testing/sysfs-bus-coresight-devices-cti    |  60 +--
 .../ABI/testing/sysfs-bus-coresight-devices-etb10  |  21 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |  10 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  76 +--
 .../ABI/testing/sysfs-bus-coresight-devices-stm    |   2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  20 +-
 Documentation/ABI/testing/sysfs-bus-css            |   3 +
 Documentation/ABI/testing/sysfs-bus-dfl            |   2 +
 .../testing/sysfs-bus-event_source-devices-dfl_fme |  14 +-
 .../testing/sysfs-bus-event_source-devices-format  |   3 +-
 .../testing/sysfs-bus-event_source-devices-hv_24x7 |   6 +-
 .../testing/sysfs-bus-event_source-devices-hv_gpci |   7 +-
 Documentation/ABI/testing/sysfs-bus-fcoe           |  68 ++-
 Documentation/ABI/testing/sysfs-bus-fsl-mc         |  12 +-
 .../ABI/testing/sysfs-bus-i2c-devices-fsa9480      |  26 +-
 .../ABI/testing/sysfs-bus-i2c-devices-pca954x      |  27 +-
 Documentation/ABI/testing/sysfs-bus-i3c            |   2 +
 Documentation/ABI/testing/sysfs-bus-iio            |  30 +-
 .../testing/sysfs-bus-iio-adc-envelope-detector    |   5 +-
 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435 |   5 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-stm32  |   3 +
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |   2 +-
 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   8 +-
 .../ABI/testing/sysfs-bus-iio-distance-srf08       |   7 +-
 .../ABI/testing/sysfs-bus-iio-frequency-ad9523     |   2 +
 .../ABI/testing/sysfs-bus-iio-frequency-adf4371    |  10 +-
 .../ABI/testing/sysfs-bus-iio-health-afe440x       |  12 +-
 .../ABI/testing/sysfs-bus-iio-light-isl29018       |   6 +-
 .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |  29 +-
 .../ABI/testing/sysfs-bus-iio-magnetometer-hmc5843 |  19 +-
 .../ABI/testing/sysfs-bus-iio-temperature-max31856 |  19 +-
 .../ABI/testing/sysfs-bus-iio-timer-stm32          | 143 ++++--
 .../ABI/testing/sysfs-bus-intel_th-devices-gth     |  11 +-
 .../ABI/testing/sysfs-bus-intel_th-devices-msc     |   4 +
 Documentation/ABI/testing/sysfs-bus-most           |   6 +-
 Documentation/ABI/testing/sysfs-bus-moxtet-devices |   6 +-
 Documentation/ABI/testing/sysfs-bus-nfit           |   2 +-
 Documentation/ABI/testing/sysfs-bus-nvdimm         |   6 +
 Documentation/ABI/testing/sysfs-bus-papr-pmem      |  23 +-
 Documentation/ABI/testing/sysfs-bus-pci            |  22 +-
 .../ABI/testing/sysfs-bus-pci-devices-aer_stats    | 119 +++--
 .../ABI/testing/sysfs-bus-pci-devices-catpt        |   1 +
 .../ABI/testing/sysfs-bus-pci-drivers-ehci_hcd     |   4 +-
 Documentation/ABI/testing/sysfs-bus-rapidio        |  23 +-
 Documentation/ABI/testing/sysfs-bus-rbd            |  37 +-
 Documentation/ABI/testing/sysfs-bus-siox           |   3 +
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |  58 ++-
 Documentation/ABI/testing/sysfs-bus-usb            |  32 +-
 .../ABI/testing/sysfs-bus-usb-devices-usbsevseg    |   7 +-
 Documentation/ABI/testing/sysfs-bus-vfio-mdev      |  10 +-
 Documentation/ABI/testing/sysfs-c2port             |   7 -
 Documentation/ABI/testing/sysfs-class-backlight    |  60 +++
 .../ABI/testing/sysfs-class-backlight-adp8860      |  21 +-
 .../testing/sysfs-class-backlight-driver-adp8870   |  30 +-
 .../testing/sysfs-class-backlight-driver-lm3533    |  26 +-
 Documentation/ABI/testing/sysfs-class-bdi          |   1 -
 Documentation/ABI/testing/sysfs-class-chromeos     |  15 +-
 Documentation/ABI/testing/sysfs-class-cxl          |  23 +-
 Documentation/ABI/testing/sysfs-class-devfreq      |   6 +-
 Documentation/ABI/testing/sysfs-class-devlink      |  30 +-
 Documentation/ABI/testing/sysfs-class-extcon       |  34 +-
 Documentation/ABI/testing/sysfs-class-fpga-manager |   5 +-
 Documentation/ABI/testing/sysfs-class-gnss         |   2 +
 Documentation/ABI/testing/sysfs-class-led          |  28 +-
 .../ABI/testing/sysfs-class-led-driver-el15203000  | 130 -----
 .../ABI/testing/sysfs-class-led-driver-lm3533      |  44 +-
 .../ABI/testing/sysfs-class-led-driver-sc27xx      |  22 -
 Documentation/ABI/testing/sysfs-class-led-flash    |  27 +-
 .../ABI/testing/sysfs-class-led-multicolor         |  23 +-
 .../ABI/testing/sysfs-class-led-trigger-netdev     |   7 +
 .../ABI/testing/sysfs-class-led-trigger-pattern    |   4 +-
 .../ABI/testing/sysfs-class-led-trigger-usbport    |   1 +
 Documentation/ABI/testing/sysfs-class-leds-gt683r  |   8 +-
 Documentation/ABI/testing/sysfs-class-mic          |  52 +-
 Documentation/ABI/testing/sysfs-class-net          |  61 ++-
 Documentation/ABI/testing/sysfs-class-net-cdc_ncm  |   6 +-
 Documentation/ABI/testing/sysfs-class-net-phydev   |   2 +
 Documentation/ABI/testing/sysfs-class-ocxl         |  17 +-
 Documentation/ABI/testing/sysfs-class-pktcdvd      |  38 +-
 Documentation/ABI/testing/sysfs-class-power        | 525 +++++++++++----------
 Documentation/ABI/testing/sysfs-class-power-mp2629 |   1 +
 .../ABI/testing/sysfs-class-power-twl4030          |  33 +-
 Documentation/ABI/testing/sysfs-class-power-wilco  |  18 +-
 Documentation/ABI/testing/sysfs-class-rapidio      |  48 +-
 Documentation/ABI/testing/sysfs-class-rc           |  30 +-
 Documentation/ABI/testing/sysfs-class-regulator    |  36 +-
 Documentation/ABI/testing/sysfs-class-remoteproc   |  14 +-
 Documentation/ABI/testing/sysfs-class-rnbd-client  |  93 ++--
 .../sysfs-class-rtc-rtc0-device-rtc_calibration    |   1 +
 Documentation/ABI/testing/sysfs-class-rtrs-client  |  23 +-
 Documentation/ABI/testing/sysfs-class-scsi_host    |   7 +-
 Documentation/ABI/testing/sysfs-class-typec        |  12 +-
 Documentation/ABI/testing/sysfs-class-uwb_rc       |  13 +-
 Documentation/ABI/testing/sysfs-class-watchdog     |   7 +-
 Documentation/ABI/testing/sysfs-dev                |   7 +-
 Documentation/ABI/testing/sysfs-devices-mapping    |  41 +-
 Documentation/ABI/testing/sysfs-devices-memory     |  15 +-
 .../ABI/testing/sysfs-devices-platform-ACPI-TAD    |   4 +
 .../testing/sysfs-devices-platform-_UDC_-gadget    |  10 +-
 .../ABI/testing/sysfs-devices-platform-docg3       |  10 +-
 .../ABI/testing/sysfs-devices-platform-ipmi        |  52 +-
 .../sysfs-devices-platform-sh_mobile_lcdc_fb       |   8 +-
 .../testing/sysfs-devices-platform-stratix10-rsu   |  10 +
 Documentation/ABI/testing/sysfs-devices-system-cpu | 101 ++--
 .../ABI/testing/sysfs-devices-system-ibm-rtl       |   6 +-
 .../ABI/testing/sysfs-driver-bd9571mwv-regulator   |   4 +
 Documentation/ABI/testing/sysfs-driver-genwqe      |  11 +-
 Documentation/ABI/testing/sysfs-driver-hid-lenovo  |  10 +
 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  18 +-
 Documentation/ABI/testing/sysfs-driver-hid-ntrig   |  13 +-
 .../ABI/testing/sysfs-driver-hid-roccat-kone       |  19 +
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |  12 +-
 .../ABI/testing/sysfs-driver-input-exc3000         |   2 +
 .../ABI/testing/sysfs-driver-jz4780-efuse          |   6 +-
 Documentation/ABI/testing/sysfs-driver-pciback     |   6 +-
 .../ABI/testing/sysfs-driver-samsung-laptop        |  13 +-
 .../ABI/testing/sysfs-driver-toshiba_acpi          |  26 +
 .../ABI/testing/sysfs-driver-toshiba_haps          |   2 +
 Documentation/ABI/testing/sysfs-driver-ufs         | 228 +++++++--
 Documentation/ABI/testing/sysfs-driver-w1_ds28e17  |   3 +
 Documentation/ABI/testing/sysfs-driver-w1_therm    |  75 ++-
 Documentation/ABI/testing/sysfs-driver-wacom       |   4 +-
 Documentation/ABI/testing/sysfs-firmware-acpi      | 237 +++++-----
 .../ABI/testing/sysfs-firmware-dmi-entries         |  50 +-
 Documentation/ABI/testing/sysfs-firmware-efi-esrt  |  28 +-
 .../ABI/testing/sysfs-firmware-efi-runtime-map     |  14 +-
 Documentation/ABI/testing/sysfs-firmware-gsmi      |   2 +-
 Documentation/ABI/testing/sysfs-firmware-memmap    |  16 +-
 .../ABI/testing/sysfs-firmware-qemu_fw_cfg         |  20 +-
 Documentation/ABI/testing/sysfs-firmware-sfi       |   6 +-
 Documentation/ABI/testing/sysfs-firmware-sgi_uv    |   6 +-
 .../ABI/testing/sysfs-firmware-turris-mox-rwtm     |  10 +-
 Documentation/ABI/testing/sysfs-fs-ext4            |   4 +-
 Documentation/ABI/testing/sysfs-fs-f2fs            |  48 +-
 Documentation/ABI/testing/sysfs-hypervisor-xen     |  13 +-
 Documentation/ABI/testing/sysfs-kernel-boot_params |  23 +-
 .../ABI/testing/sysfs-kernel-mm-hugepages          |  12 +-
 Documentation/ABI/testing/sysfs-kernel-mm-ksm      |   5 +-
 Documentation/ABI/testing/sysfs-kernel-slab        |   3 +
 Documentation/ABI/testing/sysfs-module             |  17 +-
 .../ABI/testing/sysfs-platform-asus-laptop         |  21 +-
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |   1 +
 Documentation/ABI/testing/sysfs-platform-at91      |  10 +-
 .../ABI/testing/sysfs-platform-dell-laptop         |  10 +-
 .../ABI/testing/sysfs-platform-dell-smbios         |   4 +-
 Documentation/ABI/testing/sysfs-platform-dfl-fme   |  14 +-
 Documentation/ABI/testing/sysfs-platform-dptf      |  11 +-
 .../ABI/testing/sysfs-platform-eeepc-laptop        |  14 +-
 .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   |   4 +-
 .../ABI/testing/sysfs-platform-ideapad-laptop      |   9 +-
 .../testing/sysfs-platform-intel-wmi-sbl-fw-update |   1 +
 .../testing/sysfs-platform-intel-wmi-thunderbolt   |   1 +
 Documentation/ABI/testing/sysfs-platform-kim       |   1 +
 .../ABI/testing/sysfs-platform-mellanox-bootctl    |  50 +-
 .../ABI/testing/sysfs-platform-phy-rcar-gen3-usb2  |  10 +-
 .../ABI/testing/sysfs-platform-renesas_usb3        |  10 +-
 Documentation/ABI/testing/sysfs-platform-sst-atom  |  13 +-
 .../ABI/testing/sysfs-platform-usbip-vudc          |  11 +-
 Documentation/ABI/testing/sysfs-platform-wilco-ec  |   1 +
 Documentation/ABI/testing/sysfs-power              |  21 +-
 Documentation/ABI/testing/sysfs-profiling          |   2 +-
 Documentation/ABI/testing/sysfs-ptp                |   2 +-
 Documentation/ABI/testing/sysfs-uevent             |  28 +-
 Documentation/ABI/testing/sysfs-wusb_cbaf          |   3 +-
 Documentation/ABI/testing/usb-charger-uevent       |  84 ++--
 Documentation/ABI/testing/usb-uevent               |  32 +-
 Documentation/Kconfig                              |  10 +
 Documentation/Makefile                             |   5 +
 Documentation/admin-guide/abi-obsolete.rst         |  11 +
 Documentation/admin-guide/abi-removed.rst          |   5 +
 Documentation/admin-guide/abi-stable.rst           |  14 +
 Documentation/admin-guide/abi-testing.rst          |  20 +
 Documentation/admin-guide/abi.rst                  |  11 +
 Documentation/admin-guide/index.rst                |   2 +
 Documentation/conf.py                              |   3 +-
 Documentation/filesystems/debugfs.rst              |   2 +-
 Documentation/leds/index.rst                       |   1 +
 Documentation/leds/leds-el15203000.rst             | 140 ++++++
 Documentation/leds/leds-sc27xx.rst                 |  27 ++
 Documentation/sphinx/kernel_abi.py                 | 194 ++++++++
 Documentation/sphinx/kernellog.py                  |   6 +-
 fs/debugfs/file.c                                  |  15 +-
 include/linux/debugfs.h                            |  18 +-
 lib/Kconfig.debug                                  |   2 +
 scripts/get_abi.pl                                 | 365 +++++++++-----
 250 files changed, 4134 insertions(+), 2493 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
 create mode 100644 Documentation/admin-guide/abi-obsolete.rst
 create mode 100644 Documentation/admin-guide/abi-removed.rst
 create mode 100644 Documentation/admin-guide/abi-stable.rst
 create mode 100644 Documentation/admin-guide/abi-testing.rst
 create mode 100644 Documentation/admin-guide/abi.rst
 create mode 100644 Documentation/leds/leds-el15203000.rst
 create mode 100644 Documentation/leds/leds-sc27xx.rst
 create mode 100644 Documentation/sphinx/kernel_abi.py
