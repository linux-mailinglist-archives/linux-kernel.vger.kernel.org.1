Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E032D9A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgLNOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408256AbgLNOtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:49:18 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.11
Date:   Mon, 14 Dec 2020 14:47:51 +0000
Message-Id: <20201214144810.9BF8022C97@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ba546ebe0ce2af47833d8912ced9b4a579f13cb:

  regulator: ti-abb: Fix array out of bound read access on the first transition (2020-11-18 17:59:24 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.11

for you to fetch changes up to 5e999f10a16b90fc1d5ded8aa365e9804e894aa9:

  Merge remote-tracking branch 'regulator/for-5.11' into regulator-next (2020-12-11 17:48:32 +0000)

----------------------------------------------------------------
regulator: Updates for v5.11

This has been a quiet release for the regulator API, a few new drivers
and the usual fixes and cleanup traffic but not much else going on:

 - Optimisations for the handling of voltage enumeration, especially
   with sparse selector sets, from Claudiu Beznea.
 - Support for several ARM SCMI regulators, Dialog DA9121, NXP PF8x00,
   Qualcomm PMX55, PM8350 and PM8350c

The addition of the SCMI regulator driver (which controls regulators via
system firmware) means that we've pulled in the support for the underlying
firmware operations from the firmware tree.

----------------------------------------------------------------
Adam Ward (13):
      regulator: Update DA9121 dt-bindings
      regulator: da9121: Add header file
      regulator: da9121: Add device variants
      regulator: da9121: Add device variant regmaps
      regulator: da9121: Add device variant descriptors
      regulator: da9121: Add support for device variants via devicetree
      regulator: da9121: Update registration to support multiple buck variants
      regulator: da9121: add current support
      regulator: da9121: add mode support
      regulator: da9121: add interrupt support
      regulator: da9121: Request IRQ directly and free in release function to avoid masking race
      regulator: da9121: Remove uninitialised string variable
      regulator: da9121: Fix index used for DT property

Arnd Bergmann (1):
      regulator: da9121: include linux/gpio/consumer.h

Claudiu Beznea (7):
      regulator: mcp16502: add linear_min_sel
      regulator: mcp16502: adapt for get/set on other registers
      regulator: mcp16502: add support for ramp delay
      regulator: mcp16502: remove void documentation of struct mcp16502
      regulator: core: validate selector against linear_min_sel
      regulator: core: do not continue if selector match
      regulator: core: return zero for selectors lower than linear_min_sel

Colin Ian King (1):
      regulator: lp872x: make a const array static, makes object smaller

Cristian Marussi (6):
      dt-bindings: arm: Add support for SCMI Regulators
      firmware: arm_scmi: Add voltage domain management protocol support
      firmware: arm_scmi: Add support to enumerated SCMI voltage domain device
      regulator: core: add of_match_full_name boolean flag
      dt-bindings: arm: remove optional properties for SCMI Regulators
      regulator: add SCMI driver

Dan Carpenter (1):
      regulator: da9121: Potential Oops in da9121_assign_chip_model()

DingHua Ma (1):
      regulator: axp20x: Fix DLDO2 voltage control register mask for AXP22x

Dmitry Baryshkov (2):
      regulator: fixed: support using power domain for enable/disable
      regulator: fixed: provide bindings using power domain

Fabio Estevam (1):
      regulator: pfuze100: Convert the driver to DT-only

Gustavo A. R. Silva (1):
      regulator: as3722: Fix fall-through warnings for Clang

Jagan Teki (2):
      regulator: Add pf8x00 regulator bindings
      regulator: Add NXP PF8X00 regulator driver

John Stultz (1):
      regulator: Kconfig: Fix REGULATOR_QCOM_RPMH dependencies to avoid build error

Marek Szyprowski (1):
      regulator: max14577: Add proper module aliases strings

Mark Brown (9):
      Merge existing fixes from regulator/for-5.10
      Merge series " [PATCH v2 0/5]" from Dmitry Baryshkov <dmitry.baryshkov@linaro.org>:
      Merge series "regulator: bd718x7: support voltage scaling" from Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>:
      Merge branch 'for-5.10' of https://git.kernel.org/.../broonie/regulator into regulator-5.11
      Merge series "regulator: mcp16502: add support for ramp delay" from Claudiu Beznea <claudiu.beznea@microchip.com>:
      Merge tag 'scmi-voltage-5.11' of git://git.kernel.org/.../sudeep.holla/linux into regulator-5.11
      Merge series "Add support for SCMIv3.0 Voltage Domain Protocol and SCMI-Regulator" from Cristian Marussi <cristian.marussi@arm.com>:
      Merge series "regulator: da9121: bug fixes" from Adam Ward <Adam.Ward.opensource@diasemi.com>:
      Merge remote-tracking branch 'regulator/for-5.11' into regulator-next

Matti Vaittinen (3):
      regulator: BD71837 support commonly used feedback connection
      regulator: BD71847 support commonly used feedback connection
      regulator: bd718x7: Support external connection to scale voltages

Mauro Carvalho Chehab (1):
      regulator: fix a kernel-doc markup

Michael Klein (1):
      regulator: mcp16502-regulator: fix spelling mistake

Michał Mirosław (1):
      regulator: debug early supply resolving

Vincent Whitchurch (3):
      regulator: Add support for DA9121 regulator
      regulator: Add DA9121
      regulator: da9121: Use additionalProperties

Vinod Koul (4):
      regulator: dt-bindings: Add PMX55 compatibles
      regulator: qcom-rpmh: Add support for SDX55
      regulator: dt-bindings: Add PM8350x compatibles
      regulator: qcom-rpmh: Add support for PM8350/PM8350c

Zheng Yongjun (1):
      regulator: mc13892-regulator: convert comma to semicolon

Zou Wei (1):
      regulator: da9121: Mark some symbols with static keyword

 CREDITS                                            |    9 +
 Documentation/ABI/README                           |   10 +-
 Documentation/ABI/obsolete/sysfs-class-dax         |    8 +-
 .../ABI/obsolete/sysfs-driver-hid-roccat-pyra      |    3 +
 Documentation/ABI/obsolete/sysfs-gpio              |    2 +
 Documentation/ABI/removed/devfs                    |    1 +
 Documentation/ABI/removed/raw1394                  |    1 +
 Documentation/ABI/removed/sysfs-class-rfkill       |    2 +-
 Documentation/ABI/removed/video1394                |    1 +
 Documentation/ABI/stable/firewire-cdev             |   69 +-
 Documentation/ABI/stable/sysfs-acpi-pmprofile      |   26 +-
 Documentation/ABI/stable/sysfs-bus-firewire        |    3 +
 Documentation/ABI/stable/sysfs-bus-nvmem           |   19 +-
 Documentation/ABI/stable/sysfs-bus-usb             |    6 +-
 Documentation/ABI/stable/sysfs-bus-vmbus           |    7 -
 Documentation/ABI/stable/sysfs-bus-w1              |    1 +
 Documentation/ABI/stable/sysfs-class-backlight     |    1 +
 Documentation/ABI/stable/sysfs-class-infiniband    |   93 +-
 Documentation/ABI/stable/sysfs-class-rfkill        |   13 +-
 Documentation/ABI/stable/sysfs-class-tpm           |  100 +-
 Documentation/ABI/stable/sysfs-devices             |    5 +-
 .../ABI/stable/sysfs-driver-firmware-zynqmp        |   62 +-
 Documentation/ABI/stable/sysfs-driver-ib_srp       |    1 +
 Documentation/ABI/stable/sysfs-driver-speakup      |    4 +
 Documentation/ABI/stable/sysfs-firmware-efi-vars   |    4 +
 Documentation/ABI/stable/sysfs-firmware-opal-dump  |    5 +
 Documentation/ABI/stable/sysfs-firmware-opal-elog  |    2 +
 Documentation/ABI/stable/sysfs-hypervisor-xen      |    3 +
 Documentation/ABI/stable/vdso                      |   11 +-
 Documentation/ABI/testing/configfs-acpi            |   34 +-
 Documentation/ABI/testing/configfs-most            |  135 +-
 .../ABI/testing/configfs-spear-pcie-gadget         |   36 +-
 Documentation/ABI/testing/configfs-usb-gadget      |   87 +-
 Documentation/ABI/testing/configfs-usb-gadget-ecm  |   12 +-
 Documentation/ABI/testing/configfs-usb-gadget-eem  |   10 +-
 Documentation/ABI/testing/configfs-usb-gadget-hid  |   10 +-
 .../ABI/testing/configfs-usb-gadget-loopback       |    6 +-
 .../ABI/testing/configfs-usb-gadget-mass-storage   |   18 +-
 Documentation/ABI/testing/configfs-usb-gadget-midi |   14 +-
 .../ABI/testing/configfs-usb-gadget-printer        |    6 +-
 .../ABI/testing/configfs-usb-gadget-rndis          |   16 +-
 .../ABI/testing/configfs-usb-gadget-sourcesink     |   18 +-
 .../ABI/testing/configfs-usb-gadget-subset         |   10 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac1 |   18 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |   14 +-
 Documentation/ABI/testing/configfs-usb-gadget-uvc  |  220 ++-
 Documentation/ABI/testing/debugfs-cec-error-inj    |    2 +-
 .../ABI/testing/debugfs-driver-habanalabs          |   12 +-
 Documentation/ABI/testing/debugfs-ec               |   11 +-
 Documentation/ABI/testing/debugfs-moxtet           |   30 +-
 Documentation/ABI/testing/debugfs-pfo-nx-crypto    |   28 +-
 Documentation/ABI/testing/debugfs-pktcdvd          |   13 +-
 Documentation/ABI/testing/debugfs-turris-mox-rwtm  |   15 +-
 Documentation/ABI/testing/debugfs-wilco-ec         |   21 +-
 Documentation/ABI/testing/dell-smbios-wmi          |   32 +-
 Documentation/ABI/testing/dev-kmsg                 |   27 +-
 Documentation/ABI/testing/evm                      |   17 +-
 Documentation/ABI/testing/gpio-cdev                |   13 +-
 Documentation/ABI/testing/ima_policy               |   30 +-
 Documentation/ABI/testing/procfs-diskstats         |   46 +-
 Documentation/ABI/testing/procfs-smaps_rollup      |   48 +-
 Documentation/ABI/testing/pstore                   |   19 +-
 Documentation/ABI/testing/sysfs-block              |   38 +-
 Documentation/ABI/testing/sysfs-block-device       |    2 +
 Documentation/ABI/testing/sysfs-block-rnbd         |    4 +-
 Documentation/ABI/testing/sysfs-bus-acpi           |   19 +-
 .../ABI/testing/sysfs-bus-coresight-devices-cti    |   60 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etb10  |   21 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |   10 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |   76 +-
 .../ABI/testing/sysfs-bus-coresight-devices-stm    |    2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |   20 +-
 Documentation/ABI/testing/sysfs-bus-css            |    3 +
 Documentation/ABI/testing/sysfs-bus-dfl            |    2 +
 .../testing/sysfs-bus-event_source-devices-dfl_fme |   14 +-
 .../testing/sysfs-bus-event_source-devices-format  |    3 +-
 .../testing/sysfs-bus-event_source-devices-hv_24x7 |    6 +-
 .../testing/sysfs-bus-event_source-devices-hv_gpci |    7 +-
 Documentation/ABI/testing/sysfs-bus-fcoe           |   68 +-
 Documentation/ABI/testing/sysfs-bus-fsl-mc         |   12 +-
 .../ABI/testing/sysfs-bus-i2c-devices-fsa9480      |   26 +-
 .../ABI/testing/sysfs-bus-i2c-devices-pca954x      |   27 +-
 Documentation/ABI/testing/sysfs-bus-i3c            |    2 +
 Documentation/ABI/testing/sysfs-bus-iio            |   30 +-
 .../testing/sysfs-bus-iio-adc-envelope-detector    |    5 +-
 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435 |    5 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-stm32  |    3 +
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |    2 +-
 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |    8 +-
 .../ABI/testing/sysfs-bus-iio-distance-srf08       |    7 +-
 .../ABI/testing/sysfs-bus-iio-frequency-ad9523     |    2 +
 .../ABI/testing/sysfs-bus-iio-frequency-adf4371    |   10 +-
 .../ABI/testing/sysfs-bus-iio-health-afe440x       |   12 +-
 .../ABI/testing/sysfs-bus-iio-light-isl29018       |    6 +-
 .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |   29 +-
 .../ABI/testing/sysfs-bus-iio-magnetometer-hmc5843 |   19 +-
 .../ABI/testing/sysfs-bus-iio-temperature-max31856 |   19 +-
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  143 +-
 .../ABI/testing/sysfs-bus-intel_th-devices-gth     |   11 +-
 .../ABI/testing/sysfs-bus-intel_th-devices-msc     |    4 +
 Documentation/ABI/testing/sysfs-bus-most           |    6 +-
 Documentation/ABI/testing/sysfs-bus-moxtet-devices |    6 +-
 Documentation/ABI/testing/sysfs-bus-nfit           |    2 +-
 Documentation/ABI/testing/sysfs-bus-nvdimm         |    6 +
 Documentation/ABI/testing/sysfs-bus-papr-pmem      |   23 +-
 Documentation/ABI/testing/sysfs-bus-pci            |   22 +-
 .../ABI/testing/sysfs-bus-pci-devices-aer_stats    |  119 +-
 .../ABI/testing/sysfs-bus-pci-devices-catpt        |    1 +
 .../ABI/testing/sysfs-bus-pci-drivers-ehci_hcd     |    4 +-
 Documentation/ABI/testing/sysfs-bus-rapidio        |   23 +-
 Documentation/ABI/testing/sysfs-bus-rbd            |   37 +-
 Documentation/ABI/testing/sysfs-bus-siox           |    3 +
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   58 +-
 Documentation/ABI/testing/sysfs-bus-usb            |   32 +-
 .../ABI/testing/sysfs-bus-usb-devices-usbsevseg    |    7 +-
 Documentation/ABI/testing/sysfs-bus-vfio-mdev      |   10 +-
 Documentation/ABI/testing/sysfs-c2port             |    7 -
 Documentation/ABI/testing/sysfs-class-backlight    |   60 +
 .../ABI/testing/sysfs-class-backlight-adp8860      |   21 +-
 .../testing/sysfs-class-backlight-driver-adp8870   |   30 +-
 .../testing/sysfs-class-backlight-driver-lm3533    |   26 +-
 Documentation/ABI/testing/sysfs-class-bdi          |    1 -
 Documentation/ABI/testing/sysfs-class-chromeos     |   15 +-
 Documentation/ABI/testing/sysfs-class-cxl          |   23 +-
 Documentation/ABI/testing/sysfs-class-devfreq      |    6 +-
 Documentation/ABI/testing/sysfs-class-devlink      |   30 +-
 Documentation/ABI/testing/sysfs-class-extcon       |   34 +-
 Documentation/ABI/testing/sysfs-class-fpga-manager |    5 +-
 Documentation/ABI/testing/sysfs-class-gnss         |    2 +
 Documentation/ABI/testing/sysfs-class-led          |   28 +-
 .../ABI/testing/sysfs-class-led-driver-el15203000  |  130 --
 .../ABI/testing/sysfs-class-led-driver-lm3533      |   44 +-
 .../ABI/testing/sysfs-class-led-driver-sc27xx      |   22 -
 Documentation/ABI/testing/sysfs-class-led-flash    |   27 +-
 .../ABI/testing/sysfs-class-led-multicolor         |   23 +-
 .../ABI/testing/sysfs-class-led-trigger-netdev     |    7 +
 .../ABI/testing/sysfs-class-led-trigger-pattern    |    4 +-
 .../ABI/testing/sysfs-class-led-trigger-usbport    |    1 +
 Documentation/ABI/testing/sysfs-class-leds-gt683r  |    8 +-
 Documentation/ABI/testing/sysfs-class-mic          |   52 +-
 Documentation/ABI/testing/sysfs-class-net          |   61 +-
 Documentation/ABI/testing/sysfs-class-net-cdc_ncm  |    6 +-
 Documentation/ABI/testing/sysfs-class-net-phydev   |    2 +
 Documentation/ABI/testing/sysfs-class-ocxl         |   17 +-
 Documentation/ABI/testing/sysfs-class-pktcdvd      |   38 +-
 Documentation/ABI/testing/sysfs-class-power        |  525 +++---
 Documentation/ABI/testing/sysfs-class-power-mp2629 |    1 +
 .../ABI/testing/sysfs-class-power-twl4030          |   33 +-
 Documentation/ABI/testing/sysfs-class-power-wilco  |   18 +-
 Documentation/ABI/testing/sysfs-class-rapidio      |   48 +-
 Documentation/ABI/testing/sysfs-class-rc           |   30 +-
 Documentation/ABI/testing/sysfs-class-regulator    |   36 +-
 Documentation/ABI/testing/sysfs-class-remoteproc   |   14 +-
 Documentation/ABI/testing/sysfs-class-rnbd-client  |   93 +-
 .../sysfs-class-rtc-rtc0-device-rtc_calibration    |    1 +
 Documentation/ABI/testing/sysfs-class-rtrs-client  |   23 +-
 Documentation/ABI/testing/sysfs-class-scsi_host    |    7 +-
 Documentation/ABI/testing/sysfs-class-typec        |   12 +-
 Documentation/ABI/testing/sysfs-class-uwb_rc       |   13 +-
 Documentation/ABI/testing/sysfs-class-watchdog     |    7 +-
 Documentation/ABI/testing/sysfs-dev                |    7 +-
 Documentation/ABI/testing/sysfs-devices-mapping    |   41 +-
 Documentation/ABI/testing/sysfs-devices-memory     |   15 +-
 .../ABI/testing/sysfs-devices-platform-ACPI-TAD    |    4 +
 .../testing/sysfs-devices-platform-_UDC_-gadget    |   10 +-
 .../ABI/testing/sysfs-devices-platform-docg3       |   10 +-
 .../ABI/testing/sysfs-devices-platform-ipmi        |   52 +-
 .../sysfs-devices-platform-sh_mobile_lcdc_fb       |    8 +-
 .../testing/sysfs-devices-platform-stratix10-rsu   |   10 +
 Documentation/ABI/testing/sysfs-devices-system-cpu |  101 +-
 .../ABI/testing/sysfs-devices-system-ibm-rtl       |    6 +-
 .../ABI/testing/sysfs-driver-bd9571mwv-regulator   |    4 +
 Documentation/ABI/testing/sysfs-driver-genwqe      |   11 +-
 Documentation/ABI/testing/sysfs-driver-hid-lenovo  |   10 +
 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |   18 +-
 Documentation/ABI/testing/sysfs-driver-hid-ntrig   |   13 +-
 .../ABI/testing/sysfs-driver-hid-roccat-kone       |   19 +
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   12 +-
 .../ABI/testing/sysfs-driver-input-exc3000         |    2 +
 .../ABI/testing/sysfs-driver-jz4780-efuse          |    6 +-
 Documentation/ABI/testing/sysfs-driver-pciback     |    6 +-
 .../ABI/testing/sysfs-driver-samsung-laptop        |   13 +-
 .../ABI/testing/sysfs-driver-toshiba_acpi          |   26 +
 .../ABI/testing/sysfs-driver-toshiba_haps          |    2 +
 Documentation/ABI/testing/sysfs-driver-ufs         |  228 ++-
 Documentation/ABI/testing/sysfs-driver-w1_ds28e17  |    3 +
 Documentation/ABI/testing/sysfs-driver-w1_therm    |   75 +-
 Documentation/ABI/testing/sysfs-driver-wacom       |    4 +-
 Documentation/ABI/testing/sysfs-firmware-acpi      |  237 +--
 .../ABI/testing/sysfs-firmware-dmi-entries         |   50 +-
 Documentation/ABI/testing/sysfs-firmware-efi-esrt  |   28 +-
 .../ABI/testing/sysfs-firmware-efi-runtime-map     |   14 +-
 Documentation/ABI/testing/sysfs-firmware-gsmi      |    2 +-
 Documentation/ABI/testing/sysfs-firmware-memmap    |   16 +-
 .../ABI/testing/sysfs-firmware-qemu_fw_cfg         |   20 +-
 Documentation/ABI/testing/sysfs-firmware-sfi       |    6 +-
 Documentation/ABI/testing/sysfs-firmware-sgi_uv    |    6 +-
 .../ABI/testing/sysfs-firmware-turris-mox-rwtm     |   10 +-
 Documentation/ABI/testing/sysfs-fs-ext4            |    4 +-
 Documentation/ABI/testing/sysfs-fs-f2fs            |   48 +-
 Documentation/ABI/testing/sysfs-hypervisor-xen     |   13 +-
 Documentation/ABI/testing/sysfs-kernel-boot_params |   23 +-
 .../ABI/testing/sysfs-kernel-mm-hugepages          |   12 +-
 Documentation/ABI/testing/sysfs-kernel-mm-ksm      |    5 +-
 Documentation/ABI/testing/sysfs-kernel-slab        |    3 +
 Documentation/ABI/testing/sysfs-module             |   17 +-
 .../ABI/testing/sysfs-platform-asus-laptop         |   21 +-
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |    1 +
 Documentation/ABI/testing/sysfs-platform-at91      |   10 +-
 .../ABI/testing/sysfs-platform-dell-laptop         |   10 +-
 .../ABI/testing/sysfs-platform-dell-smbios         |    4 +-
 Documentation/ABI/testing/sysfs-platform-dfl-fme   |   14 +-
 Documentation/ABI/testing/sysfs-platform-dptf      |   11 +-
 .../ABI/testing/sysfs-platform-eeepc-laptop        |   14 +-
 .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   |    4 +-
 .../ABI/testing/sysfs-platform-ideapad-laptop      |    9 +-
 .../testing/sysfs-platform-intel-wmi-sbl-fw-update |    1 +
 .../testing/sysfs-platform-intel-wmi-thunderbolt   |    1 +
 Documentation/ABI/testing/sysfs-platform-kim       |    1 +
 .../ABI/testing/sysfs-platform-mellanox-bootctl    |   50 +-
 .../ABI/testing/sysfs-platform-phy-rcar-gen3-usb2  |   10 +-
 .../ABI/testing/sysfs-platform-renesas_usb3        |   10 +-
 Documentation/ABI/testing/sysfs-platform-sst-atom  |   13 +-
 .../ABI/testing/sysfs-platform-usbip-vudc          |   11 +-
 Documentation/ABI/testing/sysfs-platform-wilco-ec  |    1 +
 Documentation/ABI/testing/sysfs-power              |   21 +-
 Documentation/ABI/testing/sysfs-profiling          |    2 +-
 Documentation/ABI/testing/sysfs-ptp                |    2 +-
 Documentation/ABI/testing/sysfs-uevent             |   28 +-
 Documentation/ABI/testing/sysfs-wusb_cbaf          |    3 +-
 Documentation/ABI/testing/usb-charger-uevent       |   84 +-
 Documentation/ABI/testing/usb-uevent               |   32 +-
 Documentation/Kconfig                              |   10 +
 Documentation/Makefile                             |    5 +
 Documentation/admin-guide/abi-obsolete.rst         |   11 +
 Documentation/admin-guide/abi-removed.rst          |    5 +
 Documentation/admin-guide/abi-stable.rst           |   14 +
 Documentation/admin-guide/abi-testing.rst          |   20 +
 Documentation/admin-guide/abi.rst                  |   11 +
 Documentation/admin-guide/index.rst                |    2 +
 Documentation/arm64/memory-tagging-extension.rst   |    4 +-
 Documentation/arm64/silicon-errata.rst             |    2 +
 Documentation/conf.py                              |    3 +-
 Documentation/devicetree/bindings/arm/actions.yaml |    2 +
 Documentation/devicetree/bindings/arm/altera.yaml  |    3 +
 .../devicetree/bindings/arm/amazon,al.yaml         |    2 +
 Documentation/devicetree/bindings/arm/amlogic.yaml |    3 +
 .../devicetree/bindings/arm/arm,integrator.yaml    |    2 +
 .../devicetree/bindings/arm/arm,realview.yaml      |    2 +
 Documentation/devicetree/bindings/arm/arm,scmi.txt |   34 +
 .../devicetree/bindings/arm/arm,versatile.yaml     |    2 +
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |    2 +
 .../devicetree/bindings/arm/atmel-at91.yaml        |    2 +
 Documentation/devicetree/bindings/arm/axxia.yaml   |    2 +
 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |    2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm11351.yaml |    2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm21664.yaml |    2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.yaml |    2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |    3 +
 .../devicetree/bindings/arm/bcm/brcm,cygnus.yaml   |    2 +
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml      |    2 +
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml      |    2 +
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml      |    2 +
 .../devicetree/bindings/arm/bcm/brcm,stingray.yaml |    2 +
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml          |    2 +
 Documentation/devicetree/bindings/arm/bitmain.yaml |    3 +
 Documentation/devicetree/bindings/arm/calxeda.yaml |    2 +
 .../devicetree/bindings/arm/digicolor.yaml         |    2 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |    2 +
 .../bindings/arm/hisilicon/hisilicon.yaml          |    3 +
 .../devicetree/bindings/arm/intel,keembay.yaml     |    3 +
 .../devicetree/bindings/arm/intel-ixp4xx.yaml      |    2 +
 .../bindings/arm/keystone/ti,k3-sci-common.yaml    |    2 +
 .../bindings/arm/marvell/armada-7k-8k.yaml         |    2 +
 .../devicetree/bindings/arm/mediatek.yaml          |    3 +
 .../devicetree/bindings/arm/microchip,sparx5.yaml  |    2 +
 Documentation/devicetree/bindings/arm/moxart.yaml  |    1 +
 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |    3 +
 .../devicetree/bindings/arm/mstar/mstar.yaml       |    2 +
 .../devicetree/bindings/arm/nxp/lpc32xx.yaml       |    2 +
 Documentation/devicetree/bindings/arm/qcom.yaml    |    2 +
 Documentation/devicetree/bindings/arm/rda.yaml     |    2 +
 Documentation/devicetree/bindings/arm/realtek.yaml |    3 +
 Documentation/devicetree/bindings/arm/renesas.yaml |    2 +
 .../devicetree/bindings/arm/rockchip.yaml          |    3 +
 .../bindings/arm/samsung/samsung-boards.yaml       |    2 +
 Documentation/devicetree/bindings/arm/sirf.yaml    |    3 +
 .../bindings/arm/socionext/milbeaut.yaml           |    3 +
 .../bindings/arm/socionext/uniphier.yaml           |    2 +
 Documentation/devicetree/bindings/arm/spear.yaml   |    3 +
 .../devicetree/bindings/arm/sprd/sprd.yaml         |    2 +
 Documentation/devicetree/bindings/arm/sti.yaml     |    3 +
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   11 +-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |    2 +
 Documentation/devicetree/bindings/arm/tegra.yaml   |    2 +
 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    3 +
 .../devicetree/bindings/arm/ti/nspire.yaml         |    3 +
 .../devicetree/bindings/arm/ti/ti,davinci.yaml     |    3 +
 Documentation/devicetree/bindings/arm/toshiba.yaml |    3 +
 Documentation/devicetree/bindings/arm/ux500.yaml   |    2 +
 Documentation/devicetree/bindings/arm/vt8500.yaml  |    3 +
 Documentation/devicetree/bindings/arm/xilinx.yaml  |    2 +
 Documentation/devicetree/bindings/arm/zte.yaml     |    2 +
 .../bindings/display/bridge/toshiba,tc358775.yaml  |   38 +-
 .../bindings/display/panel/ilitek,ili9881c.yaml    |    5 +-
 .../display/panel/mantix,mlaf057we51-x.yaml        |    4 +
 .../bindings/edac/amazon,al-mc-edac.yaml           |    1 +
 Documentation/devicetree/bindings/eeprom/at25.yaml |    6 +-
 .../bindings/gpio/kontron,sl28cpld-gpio.yaml       |    4 +-
 .../bindings/i2c/google,cros-ec-i2c-tunnel.yaml    |   66 +
 .../devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt |   39 -
 .../devicetree/bindings/i2c/ingenic,i2c.yaml       |    8 +-
 .../devicetree/bindings/iio/adc/adi,ad7291.yaml    |    3 +-
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |    3 +-
 .../bindings/iio/adc/cosmic,10001-adc.yaml         |    4 +-
 .../devicetree/bindings/iio/adc/holt,hi8435.yaml   |    2 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |    2 +
 .../bindings/iio/humidity/ti,hdc2010.yaml          |    2 +
 .../devicetree/bindings/input/cros-ec-keyb.txt     |   72 -
 .../bindings/input/google,cros-ec-keyb.yaml        |   92 +
 .../interrupt-controller/ti,pruss-intc.yaml        |   12 +-
 .../bindings/interrupt-controller/ti,sci-inta.yaml |    2 +
 .../bindings/interrupt-controller/ti,sci-intr.yaml |    2 +
 .../devicetree/bindings/leds/backlight/common.yaml |    2 +
 Documentation/devicetree/bindings/leds/common.yaml |    2 +-
 .../bindings/leds/leds-class-multicolor.yaml       |    9 +-
 .../devicetree/bindings/leds/leds-lp50xx.yaml      |    8 +
 .../devicetree/bindings/mailbox/mtk-gce.txt        |    2 +-
 .../devicetree/bindings/mfd/ene-kb3930.yaml        |    2 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   56 +
 .../devicetree/bindings/mips/ingenic/devices.yaml  |    3 +
 .../devicetree/bindings/mips/loongson/devices.yaml |    3 +
 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |    8 +-
 .../bindings/mmc/microchip,dw-sparx5-sdhci.yaml    |    2 +
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   17 +-
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |    2 +
 .../devicetree/bindings/net/ti,dp83822.yaml        |    2 +
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |   18 +-
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |    6 +-
 .../devicetree/bindings/phy/ti,omap-usb2.yaml      |   22 +-
 .../bindings/pinctrl/actions,s500-pinctrl.yaml     |  102 +-
 .../bindings/pinctrl/pinctrl-mt8192.yaml           |    2 +-
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |    6 +-
 .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml |   24 +-
 .../bindings/power/reset/reboot-mode.yaml          |    8 +-
 .../bindings/power/supply/ingenic,battery.yaml     |    8 +-
 .../power/supply/summit,smb347-charger.yaml        |   16 +-
 .../devicetree/bindings/regulator/dlg,da9121.yaml  |  189 ++
 .../bindings/regulator/fixed-regulator.yaml        |   47 +
 .../bindings/regulator/mcp16502-regulator.txt      |    2 +-
 .../devicetree/bindings/regulator/mps,mp886x.yaml  |    2 +
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   |  211 +++
 .../devicetree/bindings/regulator/pfuze100.yaml    |    2 +
 .../bindings/regulator/qcom,rpmh-regulator.txt     |    6 +
 .../bindings/regulator/rohm,bd71837-regulator.yaml |   48 +
 .../bindings/regulator/rohm,bd71847-regulator.yaml |   49 +
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml |    4 +-
 .../devicetree/bindings/riscv/sifive.yaml          |    3 +
 Documentation/devicetree/bindings/rng/imx-rng.yaml |    6 +-
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |   34 +-
 .../bindings/sound/google,cros-ec-codec.yaml       |   26 +-
 .../devicetree/bindings/sound/mchp,spdifrx.yaml    |    4 +-
 .../devicetree/bindings/sound/mchp,spdiftx.yaml    |    4 +-
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |   40 +-
 .../devicetree/bindings/sound/realtek,rt1015p.yaml |    2 +
 .../sram/allwinner,sun4i-a10-system-control.yaml   |    3 +
 .../devicetree/bindings/timer/arm,sp804.yaml       |   12 +-
 .../devicetree/bindings/usb/cdns,usb3.yaml         |    4 +-
 .../devicetree/bindings/usb/ti,hd3ss3220.yaml      |    2 +-
 .../devicetree/bindings/w1/fsl-imx-owire.yaml      |    8 +-
 Documentation/filesystems/debugfs.rst              |    2 +-
 Documentation/leds/index.rst                       |    1 +
 Documentation/leds/leds-el15203000.rst             |  140 ++
 Documentation/leds/leds-sc27xx.rst                 |   27 +
 Documentation/misc-devices/mic/index.rst           |   16 -
 Documentation/misc-devices/mic/mic_overview.rst    |   85 -
 Documentation/misc-devices/mic/scif_overview.rst   |  108 --
 Documentation/sphinx/kernel_abi.py                 |  194 ++
 Documentation/sphinx/kernellog.py                  |    6 +-
 Documentation/virt/kvm/cpuid.rst                   |    4 +
 MAINTAINERS                                        |   35 +-
 Makefile                                           |    2 +-
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts            |    4 +-
 arch/arm/boot/dts/mmp3.dtsi                        |    2 +
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   15 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   17 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   |    2 +-
 arch/arm/configs/imx_v4_v5_defconfig               |    1 +
 arch/arm/configs/imx_v6_v7_defconfig               |    1 +
 arch/arm/configs/multi_v5_defconfig                |    1 +
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/kernel/vmlinux.lds.S                      |    4 +
 arch/arm/mach-mvebu/coherency_ll.S                 |    7 +-
 arch/arm64/Kconfig                                 |   20 +
 arch/arm64/Kconfig.platforms                       |    1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |    6 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |   52 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |    6 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |    3 +
 .../marvell/armada-3720-espressobin-v7-emmc.dts    |   10 +-
 .../dts/marvell/armada-3720-espressobin-v7.dts     |   10 +-
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |   12 +-
 arch/arm64/configs/defconfig                       |    1 +
 arch/arm64/include/asm/cache.h                     |    1 +
 arch/arm64/include/asm/cpucaps.h                   |    3 +-
 arch/arm64/include/asm/cpufeature.h                |   40 +-
 arch/arm64/include/asm/cputype.h                   |    2 +
 arch/arm64/include/asm/kvm_host.h                  |    1 +
 arch/arm64/include/asm/sysreg.h                    |    9 +
 arch/arm64/include/asm/virt.h                      |    9 +-
 arch/arm64/kernel/cpu_errata.c                     |   10 +
 arch/arm64/kernel/cpuinfo.c                        |    7 +-
 arch/arm64/kernel/efi-header.S                     |    2 +-
 arch/arm64/kernel/entry.S                          |    3 +
 arch/arm64/kernel/image-vars.h                     |    1 -
 arch/arm64/kernel/proton-pack.c                    |    2 -
 arch/arm64/kernel/smp.c                            |    1 +
 arch/arm64/kernel/vdso32/Makefile                  |   23 +-
 arch/arm64/kernel/vmlinux.lds.S                    |    2 +-
 arch/arm64/kvm/arm.c                               |   22 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   21 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |    2 +-
 arch/arm64/kvm/hyp/nvhe/host.S                     |    2 -
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |   23 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |    2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                      |    1 -
 arch/arm64/kvm/hyp/pgtable.c                       |    4 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |    2 +-
 arch/arm64/kvm/hypercalls.c                        |    2 +-
 arch/arm64/kvm/mmu.c                               |   27 +-
 arch/arm64/kvm/sys_regs.c                          |    8 +-
 arch/arm64/lib/memcpy.S                            |    3 +-
 arch/arm64/lib/memmove.S                           |    3 +-
 arch/arm64/lib/memset.S                            |    3 +-
 arch/arm64/mm/fault.c                              |    2 +-
 arch/s390/include/asm/sections.h                   |    4 +-
 arch/um/kernel/skas/clone.c                        |    2 +-
 arch/x86/crypto/poly1305_glue.c                    |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   10 +-
 arch/x86/include/uapi/asm/kvm_para.h               |    1 +
 arch/x86/kernel/alternative.c                      |    9 +
 arch/x86/kernel/kexec-bzimage64.c                  |    3 +-
 arch/x86/kernel/traps.c                            |   43 +-
 arch/x86/kernel/unwind_orc.c                       |    9 +-
 arch/x86/kvm/mmu/mmu.c                             |   10 +-
 arch/x86/kvm/mmu/spte.c                            |   16 +-
 arch/x86/kvm/mmu/spte.h                            |   16 +-
 arch/x86/kvm/vmx/evmcs.c                           |    3 +-
 arch/x86/kvm/vmx/evmcs.h                           |    3 +-
 arch/x86/kvm/vmx/vmx.c                             |    6 +-
 arch/x86/kvm/x86.c                                 |    8 +-
 arch/x86/um/stub_segv.c                            |    2 +-
 block/bio.c                                        |   11 +-
 block/blk-cgroup.c                                 |   15 +-
 block/blk-flush.c                                  |    1 +
 drivers/acpi/button.c                              |   13 -
 drivers/acpi/dock.c                                |    3 +-
 drivers/acpi/nfit/core.c                           |    2 +-
 drivers/ata/sata_nv.c                              |    2 +-
 drivers/base/core.c                                |    4 +-
 drivers/block/nbd.c                                |    9 +-
 drivers/block/null_blk.h                           |    2 +
 drivers/block/null_blk_zoned.c                     |  123 +-
 drivers/block/xsysace.c                            |   49 +-
 drivers/bluetooth/btintel.h                        |    2 +-
 drivers/cpufreq/Kconfig                            |    2 +
 drivers/cpufreq/cpufreq.c                          |   15 +-
 drivers/cpufreq/e_powersaver.c                     |    1 -
 drivers/cpufreq/intel_pstate.c                     |   13 +-
 drivers/cpufreq/longhaul.c                         |    1 -
 drivers/cpufreq/speedstep-lib.c                    |    2 +-
 drivers/dma/Kconfig                                |   18 -
 drivers/dma/Makefile                               |    1 -
 drivers/dma/mic_x100_dma.c                         |  770 --------
 drivers/dma/mic_x100_dma.h                         |  275 ---
 drivers/firmware/arm_scmi/Makefile                 |    2 +-
 drivers/firmware/arm_scmi/base.c                   |    2 +
 drivers/firmware/arm_scmi/clock.c                  |    2 +
 drivers/firmware/arm_scmi/common.h                 |    3 +
 drivers/firmware/arm_scmi/driver.c                 |   11 +
 drivers/firmware/arm_scmi/notify.c                 |   22 +-
 drivers/firmware/arm_scmi/perf.c                   |    2 +
 drivers/firmware/arm_scmi/reset.c                  |    4 +-
 drivers/firmware/arm_scmi/sensors.c                |    2 +
 drivers/firmware/arm_scmi/smc.c                    |    2 +-
 drivers/firmware/arm_scmi/voltage.c                |  380 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   14 +-
 drivers/gpu/drm/amd/display/Kconfig                |    1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   12 +-
 .../amd/display/dc/gpio/dcn30/hw_factory_dcn30.c   |   12 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |   33 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   36 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   11 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   12 +-
 drivers/gpu/drm/drm_edid.c                         |    2 +-
 drivers/gpu/drm/drm_gem.c                          |    4 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    7 +-
 drivers/gpu/drm/drm_prime.c                        |    1 +
 drivers/gpu/drm/i915/display/intel_display.c       |    4 +
 drivers/gpu/drm/i915/i915_pci.c                    |    1 +
 drivers/gpu/drm/i915/intel_memory_region.c         |    2 +-
 .../gpu/drm/i915/selftests/intel_memory_region.c   |   77 +
 drivers/gpu/drm/i915/selftests/mock_region.c       |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/core.h            |    2 +
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        |   41 +-
 drivers/gpu/drm/nouveau/dispnv50/core907d.c        |   36 +-
 drivers/gpu/drm/nouveau/dispnv50/core917d.c        |    2 +-
 .../gpu/drm/nouveau/include/nvhw/class/cl507d.h    |    5 +-
 .../gpu/drm/nouveau/include/nvhw/class/cl907d.h    |    4 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   36 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c               |   31 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |    3 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |   14 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   39 +-
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c   |   25 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c             |   36 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.h             |    6 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |    1 -
 drivers/gpu/drm/vc4/vc4_drv.c                      |    1 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |   12 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    6 +-
 drivers/hwtracing/coresight/coresight-core.c       |    1 +
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  |    7 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    2 +-
 drivers/idle/intel_idle.c                          |    2 +-
 drivers/infiniband/core/cma.c                      |   48 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |    3 -
 drivers/infiniband/hw/mlx5/main.c                  |    6 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |    1 +
 drivers/infiniband/sw/rxe/rxe_av.c                 |   35 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |    2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |    4 +-
 drivers/interconnect/core.c                        |    3 +
 drivers/interconnect/qcom/icc-rpmh.c               |    7 +
 drivers/interconnect/qcom/sc7180.c                 |    6 +-
 drivers/interconnect/qcom/sdm845.c                 |    8 +-
 drivers/interconnect/qcom/sm8150.c                 |    7 +-
 drivers/interconnect/qcom/sm8250.c                 |    7 +-
 drivers/message/fusion/mptscsih.c                  |   13 +-
 drivers/misc/Kconfig                               |    1 -
 drivers/misc/Makefile                              |    1 -
 drivers/misc/mei/hw.h                              |    6 +-
 drivers/misc/mic/Kconfig                           |  141 --
 drivers/misc/mic/Makefile                          |   12 -
 drivers/misc/mic/bus/Makefile                      |    9 -
 drivers/misc/mic/bus/cosm_bus.c                    |  130 --
 drivers/misc/mic/bus/cosm_bus.h                    |  125 --
 drivers/misc/mic/bus/mic_bus.c                     |  194 --
 drivers/misc/mic/bus/scif_bus.c                    |  201 --
 drivers/misc/mic/bus/scif_bus.h                    |  125 --
 drivers/misc/mic/bus/vop_bus.c                     |  194 --
 drivers/misc/mic/bus/vop_bus.h                     |  129 --
 drivers/misc/mic/card/Makefile                     |   11 -
 drivers/misc/mic/card/mic_debugfs.c                |   85 -
 drivers/misc/mic/card/mic_device.c                 |  417 -----
 drivers/misc/mic/card/mic_device.h                 |  137 --
 drivers/misc/mic/card/mic_x100.c                   |  347 ----
 drivers/misc/mic/card/mic_x100.h                   |   37 -
 drivers/misc/mic/common/mic_dev.h                  |   55 -
 drivers/misc/mic/cosm/Makefile                     |   11 -
 drivers/misc/mic/cosm/cosm_debugfs.c               |  116 --
 drivers/misc/mic/cosm/cosm_main.c                  |  382 ----
 drivers/misc/mic/cosm/cosm_main.h                  |   61 -
 drivers/misc/mic/cosm/cosm_scif_server.c           |  399 ----
 drivers/misc/mic/cosm/cosm_sysfs.c                 |  449 -----
 drivers/misc/mic/cosm_client/Makefile              |    8 -
 drivers/misc/mic/cosm_client/cosm_scif_client.c    |  269 ---
 drivers/misc/mic/host/Makefile                     |   12 -
 drivers/misc/mic/host/mic_boot.c                   |  588 ------
 drivers/misc/mic/host/mic_debugfs.c                |  149 --
 drivers/misc/mic/host/mic_device.h                 |  157 --
 drivers/misc/mic/host/mic_intr.c                   |  635 -------
 drivers/misc/mic/host/mic_intr.h                   |  137 --
 drivers/misc/mic/host/mic_main.c                   |  335 ----
 drivers/misc/mic/host/mic_smpt.c                   |  427 -----
 drivers/misc/mic/host/mic_smpt.h                   |   87 -
 drivers/misc/mic/host/mic_x100.c                   |  585 ------
 drivers/misc/mic/host/mic_x100.h                   |   77 -
 drivers/misc/mic/scif/Makefile                     |   21 -
 drivers/misc/mic/scif/scif_api.c                   | 1485 ---------------
 drivers/misc/mic/scif/scif_debugfs.c               |  116 --
 drivers/misc/mic/scif/scif_dma.c                   | 1940 --------------------
 drivers/misc/mic/scif/scif_epd.c                   |  357 ----
 drivers/misc/mic/scif/scif_epd.h                   |  200 --
 drivers/misc/mic/scif/scif_fd.c                    |  462 -----
 drivers/misc/mic/scif/scif_fence.c                 |  783 --------
 drivers/misc/mic/scif/scif_main.c                  |  351 ----
 drivers/misc/mic/scif/scif_main.h                  |  274 ---
 drivers/misc/mic/scif/scif_map.h                   |  127 --
 drivers/misc/mic/scif/scif_mmap.c                  |  690 -------
 drivers/misc/mic/scif/scif_nm.c                    |  229 ---
 drivers/misc/mic/scif/scif_nodeqp.c                | 1349 --------------
 drivers/misc/mic/scif/scif_nodeqp.h                |  221 ---
 drivers/misc/mic/scif/scif_peer_bus.c              |  175 --
 drivers/misc/mic/scif/scif_peer_bus.h              |   23 -
 drivers/misc/mic/scif/scif_ports.c                 |  116 --
 drivers/misc/mic/scif/scif_rb.c                    |  240 ---
 drivers/misc/mic/scif/scif_rb.h                    |  100 -
 drivers/misc/mic/scif/scif_rma.c                   | 1760 ------------------
 drivers/misc/mic/scif/scif_rma.h                   |  477 -----
 drivers/misc/mic/scif/scif_rma_list.c              |  282 ---
 drivers/misc/mic/scif/scif_rma_list.h              |   48 -
 drivers/misc/mic/vop/Makefile                      |   10 -
 drivers/misc/mic/vop/vop_debugfs.c                 |  184 --
 drivers/misc/mic/vop/vop_main.c                    |  784 --------
 drivers/misc/mic/vop/vop_main.h                    |  158 --
 drivers/misc/mic/vop/vop_vringh.c                  | 1166 ------------
 drivers/mmc/host/sdhci-esdhc.h                     |    2 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |   28 +
 drivers/mmc/host/sdhci.c                           |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   49 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    1 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |   56 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h        |    4 +
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |   29 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c         |    7 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |    2 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |    2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |    5 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |    2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |    6 -
 drivers/net/ethernet/ibm/ibmvnic.c                 |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |    5 -
 drivers/net/ethernet/mellanox/mlxsw/core.c         |    5 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    9 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |    1 +
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   30 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |    2 +
 drivers/net/ethernet/pensando/ionic/ionic_fw.c     |    6 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   29 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic_stats.h  |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   47 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.h   |    1 -
 drivers/net/ethernet/realtek/r8169_main.c          |    4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   10 +-
 drivers/net/gtp.c                                  |   16 +-
 drivers/net/ipa/gsi_trans.c                        |   21 +-
 drivers/nvme/host/core.c                           |    2 +-
 drivers/nvme/host/fc.c                             |  270 ++-
 drivers/nvme/host/rdma.c                           |   12 +-
 drivers/nvme/target/core.c                         |    4 +-
 drivers/nvme/target/trace.h                        |   21 +-
 drivers/of/device.c                                |    6 +-
 drivers/of/of_reserved_mem.c                       |   13 +-
 drivers/pnp/core.c                                 |    4 +-
 drivers/regulator/Kconfig                          |   41 +-
 drivers/regulator/Makefile                         |    3 +
 drivers/regulator/as3722-regulator.c               |    3 +-
 drivers/regulator/axp20x-regulator.c               |    2 +-
 drivers/regulator/bd718x7-regulator.c              |  164 +-
 drivers/regulator/core.c                           |   14 +-
 drivers/regulator/da9121-regulator.c               | 1075 +++++++++++
 drivers/regulator/da9121-regulator.h               |  291 +++
 drivers/regulator/fixed.c                          |   63 +-
 drivers/regulator/helpers.c                        |    2 +
 drivers/regulator/lp872x.c                         |    2 +-
 drivers/regulator/max14577-regulator.c             |    2 +
 drivers/regulator/mc13892-regulator.c              |    4 +-
 drivers/regulator/mcp16502.c                       |  135 +-
 drivers/regulator/of_regulator.c                   |    8 +-
 drivers/regulator/pf8x00-regulator.c               |  496 +++++
 drivers/regulator/pfuze100-regulator.c             |   34 +-
 drivers/regulator/qcom-rpmh-regulator.c            |   93 +
 drivers/regulator/scmi-regulator.c                 |  417 +++++
 drivers/s390/net/ism_drv.c                         |    2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |    2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |   36 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |    6 +-
 drivers/scsi/qla2xxx/qla_tmpl.c                    |    4 -
 drivers/scsi/scsi_scan.c                           |    7 +-
 drivers/soc/ti/ti_sci_pm_domains.c                 |    2 +-
 drivers/staging/comedi/drivers/cb_pcidas.c         |    1 +
 drivers/staging/fieldbus/anybuss/arcx-anybus.c     |    2 +-
 drivers/staging/octeon/ethernet-mdio.c             |    6 -
 drivers/staging/octeon/ethernet-rx.c               |   34 +-
 drivers/staging/octeon/ethernet.c                  |    9 +
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   19 +-
 drivers/staging/wfx/bh.c                           |    2 +-
 drivers/staging/wfx/data_tx.c                      |    6 +-
 drivers/target/target_core_user.c                  |    2 +-
 drivers/tee/tee_core.c                             |    3 +-
 drivers/tty/serial/21285.c                         |   12 +-
 drivers/tty/serial/fsl_lpuart.c                    |   13 +-
 drivers/tty/vt/keyboard.c                          |   39 +-
 drivers/tty/vt/vt_ioctl.c                          |   11 +-
 drivers/usb/cdns3/ep0.c                            |   65 +-
 drivers/usb/cdns3/gadget.c                         |  115 +-
 drivers/usb/cdns3/gadget.h                         |    5 +-
 drivers/usb/class/cdc-acm.c                        |   12 +-
 drivers/usb/class/cdc-acm.h                        |    3 +-
 drivers/usb/core/driver.c                          |   30 +-
 drivers/usb/core/generic.c                         |    4 +-
 drivers/usb/core/usb.h                             |    2 +
 drivers/usb/dwc3/core.c                            |    2 +-
 drivers/usb/dwc3/core.h                            |    2 +-
 drivers/usb/gadget/composite.c                     |    2 +-
 drivers/usb/host/ehci-tegra.c                      |    4 +-
 drivers/usb/host/fsl-mph-dr-of.c                   |    9 +-
 drivers/usb/host/xhci-mem.c                        |    4 +-
 drivers/usb/host/xhci-pci.c                        |   17 +
 drivers/usb/host/xhci.c                            |    5 +-
 drivers/usb/host/xhci.h                            |    1 +
 drivers/usb/misc/apple-mfi-fastcharge.c            |   17 +-
 drivers/usb/typec/mux.c                            |    2 +-
 drivers/usb/typec/stusb160x.c                      |   24 +-
 drivers/usb/typec/tcpm/tcpm.c                      |    6 +-
 drivers/vdpa/mlx5/core/mr.c                        |    5 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   33 +-
 drivers/vhost/vdpa.c                               |  173 +-
 drivers/video/fbdev/hyperv_fb.c                    |    9 +-
 fs/afs/cell.c                                      |    3 +-
 fs/afs/dir.c                                       |   12 +-
 fs/afs/dir_edit.c                                  |    6 +-
 fs/afs/file.c                                      |   78 +-
 fs/afs/internal.h                                  |   57 +
 fs/afs/write.c                                     |  105 +-
 fs/afs/xattr.c                                     |    2 +-
 fs/binfmt_elf.c                                    |    2 +-
 fs/btrfs/backref.c                                 |   13 +-
 fs/btrfs/block-group.c                             |    1 +
 fs/btrfs/ctree.h                                   |    2 +
 fs/btrfs/dev-replace.c                             |    5 +
 fs/btrfs/disk-io.c                                 |  139 +-
 fs/btrfs/disk-io.h                                 |    3 +
 fs/btrfs/extent-tree.c                             |    2 +-
 fs/btrfs/file.c                                    |    3 +-
 fs/btrfs/inode.c                                   |    8 +-
 fs/btrfs/qgroup.c                                  |   18 +
 fs/btrfs/reada.c                                   |   47 +
 fs/btrfs/tree-checker.c                            |   18 +
 fs/btrfs/volumes.c                                 |    5 +-
 fs/btrfs/volumes.h                                 |   12 +-
 fs/cachefiles/rdwr.c                               |    3 +-
 fs/debugfs/file.c                                  |   15 +-
 fs/ext4/dir.c                                      |   64 +-
 fs/ext4/ext4.h                                     |   20 +-
 fs/ext4/extents.c                                  |   30 +-
 fs/ext4/fast_commit.c                              |   37 +-
 fs/ext4/hash.c                                     |    2 +-
 fs/ext4/inode.c                                    |   15 +-
 fs/ext4/namei.c                                    |   20 +-
 fs/ext4/super.c                                    |   16 +-
 fs/ext4/sysfs.c                                    |    2 +
 fs/hfs/btree.h                                     |    2 +-
 fs/hfsplus/hfsplus_fs.h                            |    2 +-
 fs/io_uring.c                                      |  108 +-
 fs/isofs/rock.h                                    |    8 +-
 fs/select.c                                        |    4 +-
 include/asm-generic/uaccess.h                      |    6 +-
 include/asm-generic/vmlinux.lds.h                  |    1 +
 include/drm/drm_dp_helper.h                        |    2 +-
 include/drm/drm_edid.h                             |    7 -
 include/drm/drm_print.h                            |   20 +-
 .../dt-bindings/regulator/dlg,da9121-regulator.h   |   22 +
 include/linux/arm-smccc.h                          |    2 +
 include/linux/cpufreq.h                            |   11 +-
 include/linux/debugfs.h                            |   18 +-
 include/linux/dma/ti-cppi5.h                       |    4 +-
 include/linux/fs.h                                 |    2 +-
 include/linux/jbd2.h                               |    7 +-
 include/linux/jhash.h                              |    2 +
 include/linux/mailbox/zynqmp-ipi-message.h         |    2 +-
 include/linux/mic_bus.h                            |  100 -
 include/linux/mlx5/driver.h                        |   18 +
 include/linux/mlx5/mlx5_ifc.h                      |    4 +-
 include/linux/module.h                             |    2 +-
 include/linux/platform_data/cros_ec_commands.h     |   14 +-
 include/linux/platform_data/cros_ec_proto.h        |    2 +-
 include/linux/regulator/da9121.h                   |   36 +
 include/linux/regulator/driver.h                   |    3 +
 include/linux/regulator/pfuze100.h                 |    6 -
 include/linux/scif.h                               | 1339 --------------
 include/linux/scmi_protocol.h                      |   64 +
 include/linux/signal.h                             |    2 +
 include/linux/time64.h                             |    4 +
 include/linux/usb/composite.h                      |    2 +-
 include/linux/vdpa.h                               |   15 +
 include/rdma/rdma_cm.h                             |   14 +-
 include/trace/events/afs.h                         |   20 +-
 include/uapi/linux/mic_common.h                    |  235 ---
 include/uapi/linux/mic_ioctl.h                     |   77 -
 include/uapi/linux/vhost.h                         |    4 +
 include/uapi/linux/vhost_types.h                   |    9 +
 kernel/futex.c                                     |    4 +-
 kernel/locking/lockdep.c                           |   20 +-
 kernel/params.c                                    |    2 +-
 kernel/power/process.c                             |    2 +-
 kernel/printk/printk_ringbuffer.c                  |    2 +-
 kernel/rcu/tree.c                                  |    2 +-
 kernel/sched/cpufreq_schedutil.c                   |    6 +-
 kernel/stop_machine.c                              |    2 +-
 kernel/time/hrtimer.c                              |    5 -
 kernel/time/itimer.c                               |    4 -
 kernel/time/sched_clock.c                          |    4 +-
 kernel/time/timer.c                                |    5 -
 kernel/trace/trace_events_synth.c                  |   36 +-
 kernel/tracepoint.c                                |    2 +-
 lib/Kconfig.debug                                  |    2 +
 lib/scatterlist.c                                  |    2 +-
 mm/process_vm_access.c                             |    4 +-
 net/bluetooth/msft.c                               |    3 +-
 net/core/devlink.c                                 |   30 +-
 net/ipv4/tcp.c                                     |    2 +
 net/ipv4/tcp_input.c                               |    3 +-
 net/mptcp/protocol.c                               |   10 +
 net/rds/ib_cm.c                                    |    5 +-
 net/sched/act_mpls.c                               |    1 +
 net/sched/cls_api.c                                |    4 +-
 net/sched/sch_netem.c                              |    9 +-
 net/smc/af_smc.c                                   |    7 +-
 net/smc/smc_clc.h                                  |    4 +-
 net/smc/smc_core.c                                 |    7 +-
 net/tipc/msg.c                                     |    5 +-
 net/vmw_vsock/af_vsock.c                           |    2 +-
 samples/mic/mpssd/.gitignore                       |    2 -
 samples/mic/mpssd/Makefile                         |   28 -
 samples/mic/mpssd/micctrl                          |  162 --
 samples/mic/mpssd/mpss                             |  189 --
 samples/mic/mpssd/mpssd.c                          | 1815 ------------------
 samples/mic/mpssd/mpssd.h                          |   89 -
 samples/mic/mpssd/sysfs.c                          |   91 -
 scripts/get_abi.pl                                 |  365 ++--
 security/integrity/ima/ima.h                       |    2 +-
 .../selftests/arm64/mte/check_buffer_fill.c        |    3 +
 .../selftests/arm64/mte/check_child_memory.c       |    3 +
 .../selftests/arm64/mte/check_ksm_options.c        |    4 +
 .../selftests/arm64/mte/check_mmap_options.c       |    4 +
 .../selftests/arm64/mte/check_tags_inclusion.c     |    3 +
 tools/testing/selftests/arm64/mte/check_user_mem.c |    4 +
 tools/testing/selftests/kvm/.gitignore             |    1 +
 tools/testing/selftests/kvm/Makefile               |    1 +
 tools/testing/selftests/kvm/include/x86_64/vmx.h   |    6 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |   23 +-
 tools/testing/selftests/kvm/lib/x86_64/vmx.c       |    9 +
 .../selftests/kvm/x86_64/vmx_apic_access_test.c    |  142 ++
 847 files changed, 11590 insertions(+), 31373 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
 create mode 100644 Documentation/admin-guide/abi-obsolete.rst
 create mode 100644 Documentation/admin-guide/abi-removed.rst
 create mode 100644 Documentation/admin-guide/abi-stable.rst
 create mode 100644 Documentation/admin-guide/abi-testing.rst
 create mode 100644 Documentation/admin-guide/abi.rst
 create mode 100644 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
 delete mode 100644 Documentation/devicetree/bindings/input/cros-ec-keyb.txt
 create mode 100644 Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
 create mode 100644 Documentation/leds/leds-el15203000.rst
 create mode 100644 Documentation/leds/leds-sc27xx.rst
 delete mode 100644 Documentation/misc-devices/mic/index.rst
 delete mode 100644 Documentation/misc-devices/mic/mic_overview.rst
 delete mode 100644 Documentation/misc-devices/mic/scif_overview.rst
 create mode 100644 Documentation/sphinx/kernel_abi.py
 delete mode 100644 drivers/dma/mic_x100_dma.c
 delete mode 100644 drivers/dma/mic_x100_dma.h
 create mode 100644 drivers/firmware/arm_scmi/voltage.c
 delete mode 100644 drivers/misc/mic/Kconfig
 delete mode 100644 drivers/misc/mic/Makefile
 delete mode 100644 drivers/misc/mic/bus/Makefile
 delete mode 100644 drivers/misc/mic/bus/cosm_bus.c
 delete mode 100644 drivers/misc/mic/bus/cosm_bus.h
 delete mode 100644 drivers/misc/mic/bus/mic_bus.c
 delete mode 100644 drivers/misc/mic/bus/scif_bus.c
 delete mode 100644 drivers/misc/mic/bus/scif_bus.h
 delete mode 100644 drivers/misc/mic/bus/vop_bus.c
 delete mode 100644 drivers/misc/mic/bus/vop_bus.h
 delete mode 100644 drivers/misc/mic/card/Makefile
 delete mode 100644 drivers/misc/mic/card/mic_debugfs.c
 delete mode 100644 drivers/misc/mic/card/mic_device.c
 delete mode 100644 drivers/misc/mic/card/mic_device.h
 delete mode 100644 drivers/misc/mic/card/mic_x100.c
 delete mode 100644 drivers/misc/mic/card/mic_x100.h
 delete mode 100644 drivers/misc/mic/common/mic_dev.h
 delete mode 100644 drivers/misc/mic/cosm/Makefile
 delete mode 100644 drivers/misc/mic/cosm/cosm_debugfs.c
 delete mode 100644 drivers/misc/mic/cosm/cosm_main.c
 delete mode 100644 drivers/misc/mic/cosm/cosm_main.h
 delete mode 100644 drivers/misc/mic/cosm/cosm_scif_server.c
 delete mode 100644 drivers/misc/mic/cosm/cosm_sysfs.c
 delete mode 100644 drivers/misc/mic/cosm_client/Makefile
 delete mode 100644 drivers/misc/mic/cosm_client/cosm_scif_client.c
 delete mode 100644 drivers/misc/mic/host/Makefile
 delete mode 100644 drivers/misc/mic/host/mic_boot.c
 delete mode 100644 drivers/misc/mic/host/mic_debugfs.c
 delete mode 100644 drivers/misc/mic/host/mic_device.h
 delete mode 100644 drivers/misc/mic/host/mic_intr.c
 delete mode 100644 drivers/misc/mic/host/mic_intr.h
 delete mode 100644 drivers/misc/mic/host/mic_main.c
 delete mode 100644 drivers/misc/mic/host/mic_smpt.c
 delete mode 100644 drivers/misc/mic/host/mic_smpt.h
 delete mode 100644 drivers/misc/mic/host/mic_x100.c
 delete mode 100644 drivers/misc/mic/host/mic_x100.h
 delete mode 100644 drivers/misc/mic/scif/Makefile
 delete mode 100644 drivers/misc/mic/scif/scif_api.c
 delete mode 100644 drivers/misc/mic/scif/scif_debugfs.c
 delete mode 100644 drivers/misc/mic/scif/scif_dma.c
 delete mode 100644 drivers/misc/mic/scif/scif_epd.c
 delete mode 100644 drivers/misc/mic/scif/scif_epd.h
 delete mode 100644 drivers/misc/mic/scif/scif_fd.c
 delete mode 100644 drivers/misc/mic/scif/scif_fence.c
 delete mode 100644 drivers/misc/mic/scif/scif_main.c
 delete mode 100644 drivers/misc/mic/scif/scif_main.h
 delete mode 100644 drivers/misc/mic/scif/scif_map.h
 delete mode 100644 drivers/misc/mic/scif/scif_mmap.c
 delete mode 100644 drivers/misc/mic/scif/scif_nm.c
 delete mode 100644 drivers/misc/mic/scif/scif_nodeqp.c
 delete mode 100644 drivers/misc/mic/scif/scif_nodeqp.h
 delete mode 100644 drivers/misc/mic/scif/scif_peer_bus.c
 delete mode 100644 drivers/misc/mic/scif/scif_peer_bus.h
 delete mode 100644 drivers/misc/mic/scif/scif_ports.c
 delete mode 100644 drivers/misc/mic/scif/scif_rb.c
 delete mode 100644 drivers/misc/mic/scif/scif_rb.h
 delete mode 100644 drivers/misc/mic/scif/scif_rma.c
 delete mode 100644 drivers/misc/mic/scif/scif_rma.h
 delete mode 100644 drivers/misc/mic/scif/scif_rma_list.c
 delete mode 100644 drivers/misc/mic/scif/scif_rma_list.h
 delete mode 100644 drivers/misc/mic/vop/Makefile
 delete mode 100644 drivers/misc/mic/vop/vop_debugfs.c
 delete mode 100644 drivers/misc/mic/vop/vop_main.c
 delete mode 100644 drivers/misc/mic/vop/vop_main.h
 delete mode 100644 drivers/misc/mic/vop/vop_vringh.c
 create mode 100644 drivers/regulator/da9121-regulator.c
 create mode 100644 drivers/regulator/da9121-regulator.h
 create mode 100644 drivers/regulator/pf8x00-regulator.c
 create mode 100644 drivers/regulator/scmi-regulator.c
 create mode 100644 include/dt-bindings/regulator/dlg,da9121-regulator.h
 delete mode 100644 include/linux/mic_bus.h
 create mode 100644 include/linux/regulator/da9121.h
 delete mode 100644 include/linux/scif.h
 delete mode 100644 include/uapi/linux/mic_common.h
 delete mode 100644 include/uapi/linux/mic_ioctl.h
 delete mode 100644 samples/mic/mpssd/.gitignore
 delete mode 100644 samples/mic/mpssd/Makefile
 delete mode 100755 samples/mic/mpssd/micctrl
 delete mode 100755 samples/mic/mpssd/mpss
 delete mode 100644 samples/mic/mpssd/mpssd.c
 delete mode 100644 samples/mic/mpssd/mpssd.h
 delete mode 100644 samples/mic/mpssd/sysfs.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
