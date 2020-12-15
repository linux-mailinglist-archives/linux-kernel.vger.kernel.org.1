Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8A2DAAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgLOKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgLOKUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:20:32 -0500
Date:   Tue, 15 Dec 2020 11:20:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608027583;
        bh=Y/u9kvS+HIegUXKZIsOLoEQRWrUFkRDb+FhdwcpDfmY=;
        h=From:To:Cc:Subject:From;
        b=PaPOX4sEfTecGRGvtIdCfOfQjzNga2kT8exJpv5ZPbrntrf7J3do/dpw/d4BhsMi5
         w5jaXUHptW/hn6oqvQUM212FGAnk5GyZbQF+nUlh+Vam9nRK+JABXi1JD7ySIqzmn2
         eSOmXoJ0DzgcyfyNjl0OUIOus5pfQNcyjhc6WA3c=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 5.11-rc1
Message-ID: <X9iN/jha9nVkuvEH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc1

for you to fetch changes up to 93f998879cd95b3e4f2836e7b17d6d5ae035cf90:

  Merge tag 'extcon-next-for-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next (2020-12-11 09:47:53 +0100)

----------------------------------------------------------------
Char / Misc driver updates for 5.11-rc1

Here is the big char/misc driver update for 5.11-rc1.

Continuing the tradition of previous -rc1 pulls, there seems to be more
and more tiny driver subsystems flowing through this tree.

Lots of different things, all of which have been in linux-next for a
while with no reported issues:
	- extcon driver updates
	- habannalab driver updates
	- mei driver updates
	- uio driver updates
	- binder fixes and features added
	- soundwire driver updates
	- mhi bus driver updates
	- phy driver updates
	- coresight driver updates
	- fpga driver updates
	- speakup driver updates
	- slimbus driver updates
	- various small char and misc driver updates

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (3):
      mei: bus: do not start a read for disconnected clients
      mei: bus: deinitialize callback functions on init failure
      mei: bus: add vtag support

Alexandru Ardelean (13):
      uio: pruss: move simple allocations to dem_ equivalents
      uio/uio_pci_generic: use device-managed function equivalents
      uio: pruss: use devm_clk_get() for clk init
      uio/uio_pci_generic: remove unneeded pci_set_drvdata()
      uio: uio_dmem_genirq: convert simple allocations to device-managed
      uio: uio_dmem_genirq: finalize conversion of probe to devm_ handlers
      uio: uio_sercos3: use device-managed functions for simple allocs
      uio: uio_mf624: use devm_kzalloc() for uio_info object
      uio: uio_netx: use devm_kzalloc() for or uio_info object
      uio: uio_cif: use devm_kzalloc() for uio_info object
      uio: uio_aec: use devm_kzalloc() for uio_info object
      uio: uio_fsl_elbc_gpcm: use device-managed allocators
      uio: uio_hv_generic: use devm_kzalloc() for private data alloc

Alon Mizrahi (3):
      habanalabs: firmware returns 64bit argument
      habanalabs: fetch pll frequency from firmware
      habanalabs: add ull to PLL masks

Amelie Delaunay (3):
      phy: stm32: don't print an error on probe deferral
      phy: stm32: defer probe for reset controller
      dt-bindings: phy: phy-stm32-usbphyc: convert bindings to json-schema

Anant Thazhemadam (1):
      misc: vmw_vmci: fix kernel info-leak by initializing dbells in vmci_ctx_get_chkpt_doorbells()

Andrew Bridges (1):
      Android: binder: added a missing blank line after declaration

Arnd Bergmann (3):
      soundwire: intel: fix another unused-function warning
      phy: mediatek: allow compile-testing the hdmi phy
      coresight: remove broken __exit annotations

Bhaumik Bhatt (20):
      bus: mhi: core: Remove double locking from mhi_driver_remove()
      bus: mhi: core: Remove unnecessary counter from mhi_firmware_copy()
      bus: mhi: core: Add missing EXPORT_SYMBOL for mhi_get_mhi_state()
      bus: mhi: core: Expose mhi_get_exec_env() API for controllers
      bus: mhi: core: Remove unused mhi_fw_load_worker() declaration
      bus: mhi: core: Rename RDDM download function to use proper words
      bus: mhi: core: Skip RDDM download for unknown execution environment
      bus: mhi: core: Use appropriate names for firmware load functions
      bus: mhi: core: Move to using high priority workqueue
      bus: mhi: core: Skip device wake in error or shutdown states
      bus: mhi: core: Move to SYS_ERROR regardless of RDDM capability
      bus: mhi: core: Prevent sending multiple RDDM entry callbacks
      bus: mhi: core: Move to an error state on any firmware load failure
      bus: mhi: core: Use appropriate label in firmware load handler API
      bus: mhi: core: Move to an error state on mission mode failure
      bus: mhi: core: Check for IRQ availability during registration
      bus: mhi: core: Separate system error and power down handling
      bus: mhi: core: Mark and maintain device states early on after power down
      bus: mhi: core: Remove MHI event ring IRQ handlers when powering down
      net: qrtr: Unprepare MHI channels during remove

Bjorn Andersson (1):
      slimbus: qcom-ngd-ctrl: Avoid sending power requests without QMI

Carl Yin (1):
      bus: mhi: core: Fix null pointer access when parsing MHI configuration

Chris Ruehl (4):
      phy: rockchip: set pulldown for strobe line in dts
      devicetree: phy: rockchip-emmc: pulldown property
      phy: rockchip-emmc: output tap delay dt property
      devicetree: phy: rockchip-emmc add output-tapdelay-select

Christophe JAILLET (2):
      misc: genwqe: Use dma_set_mask_and_coherent to simplify code
      vme: switch from 'pci_' to 'dma_' API

Chunfeng Yun (17):
      phy: allwinner: convert to devm_platform_ioremap_resource(_byname)
      phy: amlogic: convert to devm_platform_ioremap_resource
      phy: broadcom: convert to devm_platform_ioremap_resource(_byname)
      phy: cadence: convert to devm_platform_ioremap_resource
      phy: freescale: convert to devm_platform_ioremap_resource
      phy: lantiq: convert to devm_platform_ioremap_resource
      phy: marvell: convert to devm_platform_ioremap_resource
      phy: phy-xgene: convert to devm_platform_ioremap_resource
      phy: phy-mtk-ufs: convert to devm_platform_ioremap_resource
      phy: qualcomm: convert to devm_platform_ioremap_resource(_byname)
      phy: phy-ralink-usb: convert to devm_platform_ioremap_resource
      phy: renesas: convert to devm_platform_ioremap_resource
      phy: rockchip: convert to devm_platform_ioremap_resource
      phy: samsung: convert to devm_platform_ioremap_resource
      phy: phy-stm32-usbphyc: convert to devm_platform_ioremap_resource
      phy: tegra: convert to devm_platform_ioremap_resource(_byname)
      phy: ti: convert to devm_platform_ioremap_resource(_byname)

Colin Ian King (2):
      drm/mediatek: avoid dereferencing a null hdmi_phy on an error message
      firmware: fix a spelling mistake "managament" -> "management" in Kconfig

Dan Carpenter (1):
      bus: mhi: core: Fix error handling in mhi_register_controller()

Eddie James (1):
      fsi: Aspeed: Add mutex to protect HW access

Evan Green (3):
      nvmem: core: Add support for keepout regions
      dt-bindings: nvmem: Add soc qfprom compatible strings
      nvmem: qfprom: Don't touch certain fuses

Fabien Parent (1):
      dt-bindings: nvmem: mtk-efuse: add documentation for MT8516 SoC

Florian Fainelli (3):
      dt-bindings: phy: Allow defining the SATA AFE TX amplitude
      phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude
      dt-bindings: phy: Convert Broadcom SATA PHY to YAML

Frankie.Chang (2):
      binder: move structs from core file to header file
      binder: add trace at free transaction.

Furquan Shaikh (1):
      firmware: gsmi: Drop the use of dma_pool_* API functions

Georgi Djakov (1):
      interconnect: qcom: Simplify the vcd compare function

Greg Kroah-Hartman (10):
      Merge 5.10-rc2 into char-misc-next
      Merge 5.10-rc4 into char-misc-next
      Merge 5.10-rc6 into char-misc-next
      Merge tag 'misc-habanalabs-next-2020-11-30' of ssh://gitolite.kernel.org/.../ogabbay/linux into char-misc-next
      Merge tag 'icc-5.11-rc1' of git://git.kernel.org/.../djakov/icc into char-misc-next
      Merge tag 'mhi-for-v5.11' of git://git.kernel.org/.../mani/mhi into char-misc-next
      Merge 5.10-rc7 into char-misc-next
      Merge tag 'soundwire-5.11-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge tag 'phy-for-5.11' of git://git.kernel.org/.../phy/linux-phy into char-misc-next
      Merge tag 'extcon-next-for-5.11' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next

Gustavo A. R. Silva (1):
      slimbus: messaging: Fix fall-through warnings for Clang

Gustavo Pimentel (1):
      misc: pci_endpoint_test: Remove unnecessary verification

Guy Nisan (1):
      habanalabs: add boot errors prints

Harshal Chaudhari (2):
      misc: xilinx_sdfec: add compat_ptr_ioctl()
      misc: xilinx-sdfec: remove check for ioctl cmd and argument.

Hsin-Hsiung Wang (1):
      spmi: Add driver shutdown support

Igor Grinberg (1):
      habanalabs/gaudi: remove pcie_en strap toggle

Ioana Ciornei (1):
      bus: fsl-mc: simplify DPRC version check

Ivan Zaentsev (1):
      w1: w1_therm: Rename conflicting sysfs attribute 'eeprom' to 'eeprom_cmd'

JC Kuo (1):
      phy: tegra: xusb: Fix usb_phy device driver field

Jaehoon Chung (1):
      phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433 PCIe PHY

Jeffrey Hugo (1):
      bus: mhi: core: fix potential operator-precedence with BHI macros

Jon Hunter (1):
      phy: tegra: Don't warn on probe deferral

Jonathan Neuschäfer (1):
      eeprom: at25: Add example part numbers

Kai Ye (2):
      uacce: delete some redundant code.
      uacce: modify the module author information.

Kaixu Xia (2):
      coresight: tmc-etr: Assign boolean values to a bool variable
      altera-stapl: remove the unreached switch case

Laurentiu Tudor (3):
      bus: fsl-mc: add back accidentally dropped error check
      bus: fsl-mc: make sure MC firmware is up and running
      bus: fsl-mc: added missing fields to dprc_rsp_get_obj_region structure

Lee Jones (2):
      misc: c2port: core: Make copying name from userspace more secure
      misc: ocxl: config: Rename function attribute description

Linus Walleij (2):
      extcon: fsa9480: Rewrite bindings in YAML and extend
      extcon: fsa9480: Support TI TSU6111 variant

Loic Poulain (7):
      bus: mhi: Remove auto-start option
      net: qrtr: Start MHI channels during init
      bus: mhi: Add MHI PCI support for WWAN modems
      bus: mhi: Fix channel close issue on driver remove
      bus: mhi: core: Indexed MHI controller name
      bus: mhi: core: Fix device hierarchy
      mhi: pci_generic: Fix implicit conversion warning

Lubomir Rintel (3):
      dt-bindings: phy: Drop reset-gpios from marvell,mmp3-hsic-phy
      dt-bindings: phy: Allow BSD licensing of marvell,mmp3-hsic-phy.yaml
      phy: Add USB HSIC PHY driver for Marvell MMP3 SoC

Manivannan Sadhasivam (3):
      dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY bindings
      phy: qcom-qmp: Add SM8250 PCIe QMP PHYs
      Merge branch 'mhi-ath11k-immutable' into mhi-next

Mao Jinlong (1):
      coresight: tmc-etr: Check if page is valid before dma_map_page()

Marek Szyprowski (3):
      phy: samsung: Add support for the Exynos5420 variant of the USB2 PHY
      phy: samsung: Merge Kconfig for Exynos5420 and Exynos5250
      extcon: max77693: Fix modalias string

Mark Rutland (1):
      lkdtm: don't move ctors to .rodata

Mathieu Poirier (3):
      coresight: Fix W=1 warnings in core framework
      coresight-tpiu: Fix W=1 warning in TPIU driver
      coresight-stm: Fix W=1 warning in STM driver

Mauro Carvalho Chehab (6):
      mei: bus: fix a kernel-doc markup
      uio: fix some kernel-doc markups
      vme: fix two kernel-doc markups
      slimbus: fix a kernel-doc markup
      spmi: get rid of a warning when built with W=1
      spmi: fix some coding style issues at the spmi core

Michael Auchter (2):
      extcon: Add driver for TI TUSB320
      dt-bindings: extcon: add binding for TUSB320

Moritz Fischer (10):
      fpga: fpga-mgr: Add devm_fpga_mgr_register() API
      fpga: fpga-mgr: altera-ps-spi: Simplify registration
      fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
      fpga: fpga-mgr: ice40-spi: Simplify registration
      fpga: fpga-mgr: machxo2-spi: Simplify registration
      fpga: fpga-mgr: socfpga: Simplify registration
      fpga: fpga-mgr: ts73xx: Simplify registration
      fpga: fpga-mgr: xilinx-spi: Simplify registration
      fpga: fpga-mgr: zynqmp: Simplify registration
      fpga: fpga-mgr: altera-pr-ip: Simplify registration

Moti Haimovski (4):
      habanalabs: fix MMU print message
      habanalabs: refactor MMU to support dual residency MMU
      habanalabs: share a single ctx-mutex between all MMUs
      habanalabs: fix MMU debugfs operations

Neil Armstrong (7):
      dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
      dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg attribute
      phy: amlogic: Add AXG MIPI D-PHY driver
      dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell parameter
      phy: amlogic: phy-meson-axg-mipi-pcie-analog: add support for MIPI DSI analog
      phy: amlogic: meson-axg-mipi-pcie-analog: replace DSI_LANE definitions with BIT() macro
      phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode

Oded Gabbay (25):
      MAINTAINERS: update email, git repo of habanalabs driver
      habanalabs: change aggregate cs counters to atomic
      habanalabs: we need CPU queues for hwmon
      habanalabs: support multiple types of firmwares
      habanalabs: minimize prints when everything is fine
      habanalabs: don't init vm module if no MMU
      habanalabs: remove duplicate check
      habanalabs/gaudi: add NIC QMAN H/W and registers definitions
      habanalabs/gaudi: add NIC firmware-related definitions
      habanalabs/gaudi: add NIC security configuration
      habanalabs/gaudi: add support for NIC QMANs
      habanalabs/gaudi: monitor device memory usage
      habanalabs: make sure cs type is valid in cs_ioctl_signal_wait
      habanalabs: initialize variable before use
      habanalabs/gaudi: increase MAX CS to 16K
      habanalabs: remove duplicate print
      habanalabs: restore vm_pgoff after mmap
      habanalabs: move asic property to correct structure
      habanalabs: print message with correct device
      habanalabs: print CS type when it is stuck
      habanalabs: update firmware files
      habanalabs/gaudi: print ECC type field
      habanalabs: add missing counter update
      habanalabs/gaudi: handle reset when f/w is in preboot
      habanalabs: change messages to debug level

Ofir Bitton (26):
      habanalabs/gaudi: move mmu_prepare to context init
      habanalabs: sync stream structures refactor
      habanalabs: add support for multiple SOBs per monitor
      habanalabs: sync stream refactor functions
      habanalabs: sync stream collective infrastructure
      habanalabs/gaudi: Set DMA5 QMAN internal
      habanalabs: sync stream collective support
      habanalabs/gaudi: remove unreachable code
      habanalabs: advanced FW loading
      habanalabs: fetch security indication from FW
      habanalabs/gaudi: add support for FW security
      habanalabs/gaudi: fetch PLL info from FW
      habanalabs: release signal if collective wait was dropped
      habanalabs: add 'needs reset' state in driver
      habanalabs: move HW dirty check to a proper location
      habanalabs: refactor mmu va_range db structure
      habanalabs: improve hard reset procedure
      habanalabs: use host va range for internal pools
      habanalabs: fetch hard reset capability from FW
      habanalabs/gaudi: fetch HBM ecc info from FW
      habanalabs: support reserving aligned va block
      habanalabs/gaudi: align to new FW reset scheme
      habanalabs: mmu map wrapper for sizes larger than a page
      habanalabs: indicate to user that a cs is gone
      habanalabs: add support for cs with timestamp
      habanalabs: free host huge va_range if not used

Omer Shpigelman (1):
      habanalabs: fix hard reset print and comment

Peng Fan (1):
      nvmem: imx-ocotp: add support for the unaliged word count

Pierre-Louis Bossart (7):
      soundwire: SDCA: detect sdca_cascade interrupt
      soundwire: bus: add comments to explain interrupt loop filter
      soundwire: bus: reset slave_notify status at each loop
      soundwire: registers: add definitions for clearable interrupt fields
      soundwire: bus: only clear valid DP0 interrupts
      soundwire: bus: only clear valid DPN interrupts
      soundwire: master: use pm_runtime_set_active() on add

Qi Liu (2):
      coresight: Remove unnecessary THIS_MODULE of funnel and replicator driver
      coresight: etm4x: Modify core-commit to avoid HiSilicon ETM overflow

Rafał Miłecki (1):
      phy: phy-bcm-ns-usb3: drop support for deprecated DT binding

Ricky Wu (3):
      misc: rtsx: modify en/disable aspm function
      misc: rtsx: modify and fix init_hw function
      misc: rtsx: rts5249 support runtime PM

Rikard Falkeborn (3):
      phy: fsl-imx8mq-usb: Constify imx8mp_usb_phy_ops
      phy: tegra: Constify static device_type structs
      slimbus: qcom-ngd-ctrl: Constify static structs

Robert Marko (1):
      MAINTAINERS: Add entry for Qualcomm IPQ4019 USB PHY

Sai Prakash Ranjan (3):
      coresight: etm4x: Skip setting LPOVERRIDE bit for qcom, skip-power-up
      coresight: tmc-etf: Fix NULL ptr dereference in tmc_enable_etf_sink_perf()
      coresight: etb10: Fix possible NULL ptr dereference in etb_enable_perf()

Samuel Thibault (3):
      speakup_dummy: log about characters received by the dummy driver
      speakup: document the usage of enum values
      speakup: Document read_all_doc shortcut

Sangmoon Kim (1):
      char: misc: increase DYNAMIC_MINORS value

Sergio Paracuellos (6):
      dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
      phy: ralink: Add PHY driver for MT7621 PCIe PHY
      MAINTAINERS: add MT7621 PHY PCI maintainer
      staging: mt7621-pci-phy: remove driver from staging
      phy: ralink: phy-mt7621-pci: drop 'COMPILE_TEST' from Kconfig
      phy: ralink: phy-mt7621-pci: set correct name in MODULE_DEVICE_TABLE macro

Srinivas Kandagatla (5):
      soundwire: Fix DEBUG_LOCKS_WARN_ON for uninitialized attribute
      slimbus: qcom-ngd-ctrl: add Sub System Restart support
      slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support
      slimbus: qcom-ngd-ctrl: remove redundant out of memory messages
      slimbus: qcom-ngd-ctrl: fix SSR dependencies

Stephen Boyd (1):
      MAINTAINERS: Mark SPMI as maintained

Sudip Mukherjee (1):
      misc: hisi_hikey_usb: use PTR_ERR_OR_ZERO

Suzuki K Poulose (6):
      coresight: etm4x: Fix accesses to TRCVMIDCTLR1
      coresight: etm4x: Fix accesses to TRCCIDCTLR1
      coresight: etm4x: Update TRCIDR3.NUMPROCS handling to match v4.2
      coresight: etm4x: Fix accesses to TRCPROCSELR
      coresight: etm4x: Handle TRCVIPCSSCTLR accesses
      coresight: tmc-etr: Fix barrier packet insertion for perf buffer

Swapnil Jakhade (1):
      dt-bindings: phy: Add Cadence Sierra PHY bindings in YAML format

Sylwester Nawrocki (2):
      interconnect: Add generic interconnect driver for Exynos SoCs
      MAINTAINERS: Add entry for Samsung interconnect drivers

Tal Cohen (1):
      habanalabs: use enum for CB allocation options

Thomas Gleixner (1):
      misc/sgi-xp: Replace in_interrupt() usage

Tiezhu Yang (2):
      phy: mediatek: Make PHY_MTK_{XSPHY, TPHY} depend on HAS_IOMEM and OF_ADDRESS to fix build errors
      phy/rockchip: Make PHY_ROCKCHIP_INNO_HDMI depend on HAS_IOMEM to fix build error

Todd Kjos (1):
      binder: add flag to clear buffer on txn complete

Tom Rix (6):
      misc: mei: remove unneeded break
      misc: ti-st: st_core: remove unneeded semicolon
      char: lp: remove unneeded break
      char: mwave: remove unneeded break
      vme: remove unneeded break
      ipack: iopctal: remove unneeded break

Tomas Winkler (1):
      mei: bus: enable pavp device.

Tomer Tayar (9):
      habanalabs: Small refactoring of CS IOCTL handling
      habanalabs: Small refactoring of cs_do_release()
      habanalabs: Skip updating CI of internal queues if not in use
      habanalabs: Move repeatedly included headers to habanalabs.h
      habanalabs: Separate CS job completion from its deallocation
      habanalabs: Rename hw_queues_mirror to cs_mirror
      habanalabs: Add mask for CS type bits in CS flags
      habanalabs: Modify the cs_cnt of a CB to be atomic
      habanalabs: Add CB IOCTL opcode to retrieve CB information

Uwe Kleine-König (2):
      siox: Use bus_type functions for probe, remove and shutdown
      siox: Make remove callback return void

Vinod Koul (5):
      phy: amlogic: Revert "phy: amlogic: Replace devm_reset_control_array_get()"
      phy: samsung: phy-exynos-pcie: fix typo 'tunning'
      soundwire: qcom: Fix build failure when slimbus is module
      phy: mediatek: statify mtk_hdmi_phy_driver
      phy: ingenic: depend on HAS_IOMEM

Wan Ahmad Zainie (2):
      dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
      phy: intel: Add Keem Bay USB PHY support

Wang Li (1):
      phy: renesas: rcar-gen3-usb2: disable runtime pm in case of failure

Wang Qing (1):
      firmware: fix spelling typo of 'wtih'

Xiongfeng Wang (1):
      misc: pci_endpoint_test: fix return value of error branch

Yang Yingliang (1):
      speakup: fix uninitialized flush_lock

Yangtao Li (1):
      phy: sun4i-usb: remove enable_pmu_unk1 from sun50i_h6_cfg

Yejune Deng (2):
      phy: amlogic: Replace devm_reset_control_array_get()
      phy: amlogic: replace devm_reset_control_array_get()

Zhang Changzhong (2):
      bus: fsl-mc: fix error return code in fsl_mc_object_allocate()
      slimbus: qcom: fix potential NULL dereference in qcom_slim_prg_slew()

Zhang Qilong (1):
      binder: change error code from postive to negative in binder_transaction

Zhou Xingxing (1):
      misc: isl29003: Fix typo for get/set mode

Zou Wei (1):
      coresight: core: Remove unneeded semicolon

farah kassabri (3):
      habanalabs: fix cs counters structure
      habanalabs/gaudi: scrub all memory upon closing FD
      habanalabs: reset device upon fw read failure

kernel test robot (2):
      habanalabs: goya_reset_sob_group() can be static
      habanalabs: gaudi_ctx_fini() can be static

周琰杰 (Zhou Yanjie) (3):
      USB: PHY: JZ4770: Remove unnecessary function calls.
      dt-bindings: USB: Add bindings for Ingenic JZ4775 and X2000.
      PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 Documentation/ABI/testing/sysfs-driver-w1_therm    |    2 +-
 Documentation/admin-guide/spkguide.txt             |    1 +
 .../devicetree/bindings/clock/ingenic,cgu.yaml     |    2 +-
 .../devicetree/bindings/extcon/extcon-fsa9480.txt  |   21 -
 .../bindings/extcon/extcon-usbc-tusb320.yaml       |   41 +
 .../devicetree/bindings/extcon/fcs,fsa880.yaml     |   52 +
 .../devicetree/bindings/nvmem/mtk-efuse.txt        |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   17 +-
 .../bindings/phy/amlogic,axg-mipi-dphy.yaml        |   70 +
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |   21 +-
 .../devicetree/bindings/phy/brcm,sata-phy.yaml     |  148 +
 .../devicetree/bindings/phy/brcm-sata-phy.txt      |   58 -
 .../ingenic,phy-usb.yaml}                          |    4 +-
 .../bindings/phy/intel,phy-keembay-usb.yaml        |   44 +
 .../bindings/phy/marvell,mmp3-hsic-phy.yaml        |    9 +-
 .../bindings/phy}/mediatek,mt7621-pci-phy.yaml     |    2 +-
 .../devicetree/bindings/phy/phy-cadence-sierra.txt |   70 -
 .../bindings/phy/phy-cadence-sierra.yaml           |  152 +
 .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  |   73 -
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |  138 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    6 +
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |    5 +
 .../devicetree/bindings/phy/samsung-phy.txt        |    1 +
 Documentation/w1/slaves/w1_therm.rst               |    2 +-
 MAINTAINERS                                        |   32 +-
 drivers/accessibility/speakup/i18n.h               |    6 +
 drivers/accessibility/speakup/main.c               |   64 +-
 drivers/accessibility/speakup/speakup_dectlk.c     |    2 +-
 drivers/accessibility/speakup/speakup_dummy.c      |    7 +-
 drivers/android/binder.c                           |  428 +--
 drivers/android/binder_alloc.c                     |   48 +
 drivers/android/binder_alloc.h                     |    4 +-
 drivers/android/binder_internal.h                  |  406 ++
 drivers/android/binder_trace.h                     |   29 +
 drivers/bus/fsl-mc/dprc-driver.c                   |    4 +-
 drivers/bus/fsl-mc/dprc.c                          |    2 +
 drivers/bus/fsl-mc/fsl-mc-allocator.c              |    4 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   47 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |    5 +-
 drivers/bus/mhi/Kconfig                            |    9 +
 drivers/bus/mhi/Makefile                           |    4 +
 drivers/bus/mhi/core/boot.c                        |   75 +-
 drivers/bus/mhi/core/debugfs.c                     |    4 +-
 drivers/bus/mhi/core/init.c                        |   73 +-
 drivers/bus/mhi/core/internal.h                    |    7 +-
 drivers/bus/mhi/core/main.c                        |   16 +-
 drivers/bus/mhi/core/pm.c                          |  238 +-
 drivers/bus/mhi/pci_generic.c                      |  345 ++
 drivers/char/lp.c                                  |    1 -
 drivers/char/misc.c                                |    2 +-
 drivers/char/mwave/mwavedd.c                       |    1 -
 drivers/extcon/Kconfig                             |    8 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-fsa9480.c                    |    1 +
 drivers/extcon/extcon-max77693.c                   |    2 +-
 drivers/extcon/extcon-usbc-tusb320.c               |  184 +
 drivers/firmware/Kconfig                           |    2 +-
 drivers/firmware/google/gsmi.c                     |   31 +-
 drivers/firmware/raspberrypi.c                     |    2 +-
 drivers/fpga/altera-pr-ip-core-plat.c              |   10 -
 drivers/fpga/altera-pr-ip-core.c                   |    4 +-
 drivers/fpga/altera-ps-spi.c                       |   14 +-
 drivers/fpga/dfl-fme-mgr.c                         |   13 +-
 drivers/fpga/fpga-mgr.c                            |   81 +-
 drivers/fpga/ice40-spi.c                           |   14 +-
 drivers/fpga/machxo2-spi.c                         |   14 +-
 drivers/fpga/socfpga.c                             |   14 +-
 drivers/fpga/ts73xx-fpga.c                         |   14 +-
 drivers/fpga/xilinx-spi.c                          |   14 +-
 drivers/fpga/zynqmp-fpga.c                         |   21 +-
 drivers/fsi/fsi-master-aspeed.c                    |   45 +-
 drivers/hwtracing/coresight/Kconfig                |    8 +
 drivers/hwtracing/coresight/coresight-catu.c       |    2 +-
 drivers/hwtracing/coresight/coresight-core.c       |   10 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |    2 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |    6 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |    4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  152 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    8 +
 drivers/hwtracing/coresight/coresight-funnel.c     |    8 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    2 +
 drivers/hwtracing/coresight/coresight-replicator.c |    8 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |    2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |    8 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    4 +-
 drivers/interconnect/Kconfig                       |    1 +
 drivers/interconnect/Makefile                      |    1 +
 drivers/interconnect/qcom/bcm-voter.c              |   15 +-
 drivers/interconnect/samsung/Kconfig               |   13 +
 drivers/interconnect/samsung/Makefile              |    4 +
 drivers/interconnect/samsung/exynos.c              |  199 +
 drivers/ipack/devices/ipoctal.c                    |    1 -
 drivers/misc/altera-stapl/altera.c                 |    5 -
 drivers/misc/c2port/core.c                         |    2 +-
 drivers/misc/cardreader/rts5249.c                  |   26 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |  126 +-
 drivers/misc/cardreader/rtsx_pcr.h                 |    1 +
 drivers/misc/eeprom/at25.c                         |    3 +
 drivers/misc/genwqe/card_base.c                    |   19 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   55 +-
 .../misc/habanalabs/common/command_submission.c    | 1016 +++--
 drivers/misc/habanalabs/common/context.c           |    4 +
 drivers/misc/habanalabs/common/debugfs.c           |  310 +-
 drivers/misc/habanalabs/common/device.c            |  182 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  167 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  458 ++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   34 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   77 +-
 drivers/misc/habanalabs/common/hw_queue.c          |  273 +-
 drivers/misc/habanalabs/common/hwmon.c             |   31 +-
 drivers/misc/habanalabs/common/memory.c            |  334 +-
 drivers/misc/habanalabs/common/mmu.c               |  273 +-
 drivers/misc/habanalabs/common/mmu_v1.c            |  139 +-
 drivers/misc/habanalabs/common/pci.c               |   16 +-
 drivers/misc/habanalabs/common/sysfs.c             |   18 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 2384 ++++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   87 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    2 -
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        |    8 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 4056 +++++++++++++++++++-
 drivers/misc/habanalabs/goya/goya.c                |  166 +-
 drivers/misc/habanalabs/goya/goyaP.h               |    3 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    2 -
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |   28 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  136 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |  103 +
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |   26 +-
 .../include/gaudi/asic_reg/nic0_qm0_masks.h        |  800 ++++
 .../include/gaudi/asic_reg/nic0_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic0_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic1_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic1_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm0_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm1_regs.h         |  834 ++++
 .../include/gaudi/asic_reg/psoc_hbm_pll_regs.h     |  114 -
 .../include/gaudi/asic_reg/psoc_pci_pll_regs.h     |  114 -
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   27 +-
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   15 +
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |    2 +
 drivers/misc/habanalabs/include/goya/goya_fw_if.h  |    3 +-
 .../misc/habanalabs/include/goya/goya_reg_map.h    |    2 +
 drivers/misc/hisi_hikey_usb.c                      |    5 +-
 drivers/misc/isl29003.c                            |    4 +-
 drivers/misc/lkdtm/Makefile                        |    2 +-
 drivers/misc/lkdtm/rodata.c                        |    2 +-
 drivers/misc/mei/bus-fixup.c                       |   17 +-
 drivers/misc/mei/bus.c                             |  121 +-
 drivers/misc/mei/client.c                          |    6 +-
 drivers/misc/mei/hbm.c                             |    1 -
 drivers/misc/mei/mei_dev.h                         |    4 +-
 drivers/misc/ocxl/config.c                         |    2 +-
 drivers/misc/pci_endpoint_test.c                   |   10 +-
 drivers/misc/sgi-xp/xpc.h                          |    1 +
 drivers/misc/sgi-xp/xpc_main.c                     |    2 +-
 drivers/misc/sgi-xp/xpc_partition.c                |   20 +-
 drivers/misc/ti-st/st_core.c                       |    2 +-
 drivers/misc/uacce/uacce.c                         |   13 +-
 drivers/misc/vmw_vmci/vmci_context.c               |    2 +-
 drivers/misc/xilinx_sdfec.c                        |   28 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   16 +
 drivers/net/wireless/ath/ath11k/mhi.c              |    4 -
 drivers/nvmem/core.c                               |  153 +-
 drivers/nvmem/imx-ocotp.c                          |   30 +-
 drivers/nvmem/qfprom.c                             |   30 +
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |    9 +-
 drivers/phy/allwinner/phy-sun50i-usb3.c            |    4 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c        |    4 +-
 drivers/phy/allwinner/phy-sun9i-usb.c              |    4 +-
 drivers/phy/amlogic/Kconfig                        |   13 +
 drivers/phy/amlogic/Makefile                       |    1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c      |  413 ++
 .../phy/amlogic/phy-meson-axg-mipi-pcie-analog.c   |  203 +-
 drivers/phy/amlogic/phy-meson-axg-pcie.c           |    6 +-
 drivers/phy/amlogic/phy-meson-g12a-usb2.c          |    4 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |    6 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |    7 +-
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c         |    4 +-
 drivers/phy/broadcom/phy-bcm-kona-usb2.c           |    4 +-
 drivers/phy/broadcom/phy-bcm-ns-usb2.c             |    4 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             |  159 +-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          |   13 +-
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             |    5 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c              |    4 +-
 drivers/phy/broadcom/phy-brcm-sata.c               |   40 +-
 drivers/phy/cadence/cdns-dphy.c                    |    4 +-
 drivers/phy/cadence/phy-cadence-salvo.c            |    4 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |    4 +-
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     |    4 +-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         |    6 +-
 drivers/phy/ingenic/Kconfig                        |   13 +
 drivers/phy/ingenic/Makefile                       |    2 +
 drivers/phy/ingenic/phy-ingenic-usb.c              |  412 ++
 drivers/phy/intel/Kconfig                          |   12 +
 drivers/phy/intel/Makefile                         |    1 +
 drivers/phy/intel/phy-intel-keembay-usb.c          |  301 ++
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |    4 +-
 drivers/phy/marvell/Kconfig                        |   12 +
 drivers/phy/marvell/Makefile                       |    1 +
 drivers/phy/marvell/phy-armada375-usb2.c           |    4 +-
 drivers/phy/marvell/phy-berlin-usb.c               |    4 +-
 drivers/phy/marvell/phy-mmp3-hsic.c                |   82 +
 drivers/phy/marvell/phy-mmp3-usb.c                 |    4 +-
 drivers/phy/marvell/phy-mvebu-sata.c               |    4 +-
 drivers/phy/marvell/phy-pxa-28nm-hsic.c            |    4 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c            |    4 +-
 drivers/phy/marvell/phy-pxa-usb.c                  |    4 +-
 drivers/phy/mediatek/Kconfig                       |   10 +-
 drivers/phy/mediatek/phy-mtk-hdmi.c                |    7 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                 |    4 +-
 drivers/phy/phy-xgene.c                            |    4 +-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |    4 +-
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c        |    4 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c       |    4 +-
 drivers/phy/qualcomm/phy-qcom-pcie2.c              |    5 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  281 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   18 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |    4 +-
 drivers/phy/ralink/Kconfig                         |    8 +
 drivers/phy/ralink/Makefile                        |    1 +
 .../ralink/phy-mt7621-pci.c}                       |  117 +-
 drivers/phy/ralink/phy-ralink-usb.c                |    4 +-
 drivers/phy/renesas/phy-rcar-gen2.c                |    4 +-
 drivers/phy/renesas/phy-rcar-gen3-pcie.c           |    4 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   10 +-
 drivers/phy/renesas/phy-rcar-gen3-usb3.c           |    4 +-
 drivers/phy/rockchip/Kconfig                       |    1 +
 drivers/phy/rockchip/phy-rockchip-emmc.c           |   29 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |    4 +-
 drivers/phy/samsung/phy-exynos-pcie.c              |  304 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |    4 +-
 drivers/phy/samsung/phy-exynos5250-sata.c          |    5 +-
 drivers/phy/samsung/phy-exynos5250-usb2.c          |   48 +-
 drivers/phy/samsung/phy-samsung-usb2.c             |    8 +-
 drivers/phy/samsung/phy-samsung-usb2.h             |    1 +
 drivers/phy/st/phy-stm32-usbphyc.c                 |   15 +-
 drivers/phy/tegra/phy-tegra194-p2u.c               |    4 +-
 drivers/phy/tegra/xusb.c                           |   12 +-
 drivers/phy/ti/phy-omap-control.c                  |   17 +-
 drivers/phy/ti/phy-omap-usb2.c                     |    4 +-
 drivers/phy/ti/phy-ti-pipe3.c                      |   15 +-
 drivers/siox/siox-core.c                           |   50 +-
 drivers/slimbus/Kconfig                            |    3 +-
 drivers/slimbus/messaging.c                        |    1 +
 drivers/slimbus/qcom-ctrl.c                        |    9 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |  133 +-
 drivers/slimbus/slimbus.h                          |    2 +-
 drivers/soundwire/bus.c                            |   55 +-
 drivers/soundwire/intel.c                          |    8 +-
 drivers/soundwire/master.c                         |   14 +
 drivers/soundwire/qcom.c                           |    2 +-
 drivers/soundwire/sysfs_slave_dpn.c                |    1 +
 drivers/spmi/spmi.c                                |   19 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/mt7621-pci-phy/Kconfig             |    8 -
 drivers/staging/mt7621-pci-phy/Makefile            |    2 -
 drivers/staging/mt7621-pci-phy/TODO                |    4 -
 drivers/uio/uio.c                                  |    4 +-
 drivers/uio/uio_aec.c                              |    8 +-
 drivers/uio/uio_cif.c                              |    8 +-
 drivers/uio/uio_dmem_genirq.c                      |   62 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |   32 +-
 drivers/uio/uio_hv_generic.c                       |    8 +-
 drivers/uio/uio_mf624.c                            |    8 +-
 drivers/uio/uio_netx.c                             |    8 +-
 drivers/uio/uio_pci_generic.c                      |   39 +-
 drivers/uio/uio_pruss.c                            |   34 +-
 drivers/uio/uio_sercos3.c                          |   14 +-
 drivers/usb/phy/phy-jz4770.c                       |    2 +-
 drivers/vme/bridges/vme_ca91cx42.c                 |   13 +-
 drivers/vme/bridges/vme_tsi148.c                   |   20 +-
 drivers/vme/vme.c                                  |   13 +-
 drivers/w1/slaves/w1_therm.c                       |   12 +-
 include/linux/fpga/fpga-mgr.h                      |    2 +
 include/linux/mei_cl_bus.h                         |    6 +
 include/linux/mhi.h                                |   18 +-
 include/linux/nvmem-provider.h                     |   17 +
 include/linux/rtsx_pci.h                           |    2 +
 include/linux/siox.h                               |    2 +-
 include/linux/soundwire/sdw.h                      |    4 +
 include/linux/soundwire/sdw_registers.h            |   11 +
 include/linux/spmi.h                               |    1 +
 include/linux/uio_driver.h                         |   16 +
 include/uapi/linux/android/binder.h                |    1 +
 include/uapi/misc/habanalabs.h                     |  126 +-
 net/qrtr/mhi.c                                     |    6 +
 294 files changed, 23682 insertions(+), 4116 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
 create mode 100644 Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
 rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml} (89%)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
 rename {drivers/staging/mt7621-pci-phy => Documentation/devicetree/bindings/phy}/mediatek,mt7621-pci-phy.yaml (92%)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
 create mode 100644 drivers/bus/mhi/pci_generic.c
 create mode 100644 drivers/extcon/extcon-usbc-tusb320.c
 create mode 100644 drivers/interconnect/samsung/Kconfig
 create mode 100644 drivers/interconnect/samsung/Makefile
 create mode 100644 drivers/interconnect/samsung/exynos.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h
 delete mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h
 delete mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c
 create mode 100644 drivers/phy/intel/phy-intel-keembay-usb.c
 create mode 100644 drivers/phy/marvell/phy-mmp3-hsic.c
 rename drivers/{staging/mt7621-pci-phy/pci-mt7621-phy.c => phy/ralink/phy-mt7621-pci.c} (75%)
 delete mode 100644 drivers/staging/mt7621-pci-phy/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci-phy/Makefile
 delete mode 100644 drivers/staging/mt7621-pci-phy/TODO
