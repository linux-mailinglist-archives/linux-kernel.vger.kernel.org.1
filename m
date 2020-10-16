Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA42904CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407233AbgJPMO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:14:27 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44256 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407038AbgJPMO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:14:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7537B612629A;
        Fri, 16 Oct 2020 14:14:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bQpUCCC_fYMN; Fri, 16 Oct 2020 14:14:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 72250612626A;
        Fri, 16 Oct 2020 14:14:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id phGf1ozZg_lv; Fri, 16 Oct 2020 14:14:19 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3E5AF612629A;
        Fri, 16 Oct 2020 14:14:19 +0200 (CEST)
Date:   Fri, 16 Oct 2020 14:14:19 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Message-ID: <1673234208.201792.1602850459001.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD updates for 5.10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: Wcgm6Jd4l/QG/7a3Rn2yOo/+IszppQ==
Thread-Topic: MTD updates for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.10

for you to fetch changes up to 6402f4ce95811db7df72244ca84860332e4c2518:

  mtd: hyperbus: Fix build failure when only RPCIF_HYPERBUS is enabled (2020-10-12 21:12:08 +0200)

----------------------------------------------------------------
NAND Core changes:
* Drop useless 'depends on' in Kconfig
* Add an extra level in the Kconfig hierarchy
* Trivial spellings
* Dynamic allocation of the interface configurations
* Dropping the default ONFI timing mode
* Various cleanup (types, structures, naming, comments)
* Hide the chip->data_interface indirection
* Add the generic rb-gpios property
* Add the ->choose_interface_config() hook
* Introduce nand_choose_best_sdr_timings()
* Use default values for tPROG_max and tBERS_max
* Avoid redefining tR_max and tCCS_min
* Add a helper to find the closest ONFI mode
* bcm63xx MTD parsers: simplify CFE detection

Raw NAND controller drivers changes:
* fsl-upm: Deprecation of specific DT properties
* fsl_upm: Driver rework and cleanup in favor of ->exec_op()
* Ingenic: Cleanup ARRAY_SIZE() vs sizeof() use
* brcmnand: ECC error handling on EDU transfers
* brcmnand: Don't default to EDU transfers
* qcom: Set BAM mode only if not set already
* qcom: Avoid write to unavailable register
* gpio: Driver rework in favor of ->exec_op()
* tango: ->exec_op() conversion
* mtk: ->exec_op() conversion

Raw NAND chip drivers changes:
* toshiba: Implement ->choose_interface_config() for TH58NVG2S3HBAI4
* toshiba: Implement ->choose_interface_config() for TC58NVG0S3E
* toshiba: Implement ->choose_interface_config() for TC58TEG5DCLTA00
* hynix: Implement ->choose_interface_config() for H27UCG8T2ATR-BC

HyperBus changes:
* DMA support for TI's AM654 HyperBus controller driver.
* HyperBus frontend driver for Renesas RPC-IF driver.

SPI NOR core changes:
* Support for Winbond w25q64jwm flash
* Enable 4K sector support for mx25l12805d

SPI NOR controller drivers changes:
* intel-spi Add Alder Lake-S PCI ID

MTD Core changes:
* mtdoops: Don't run panic write twice
* mtdconcat: Correctly handle panic write
* Use DEFINE_SHOW_ATTRIBUTE

----------------------------------------------------------------
Alex Dewar (1):
      mtd: rawnand: atmel: Check return values for nand_read_data_op

Arnd Bergmann (1):
      mtd: lpddr: fix excessive stack usage with clang

Bernard Zhao (1):
      mtd: maps: vmu-flash: fix typos for struct memcard

Boris Brezillon (6):
      mtd: rawnand: atmel: Enable the NFC controller at probe time
      mtd: rawnand: atmel: Drop redundant nand_read_page_op()
      mtd: rawnand: atmel: Use nand_{write,read}_data_op()
      mtd: rawnand: atmel: Use nand_prog_page_end_op()
      mtd: rawnand: atmel: Convert the driver to exec_op()
      mtd: rawnand: atmel: Get rid of the legacy interface implementation

Chris Packham (2):
      mtd: maps: physmap: Retain mtd-name property from dts
      mtd: rawnand: marvell: Support panic_write for mtdoops

Christophe Kerello (1):
      mtd: rawnand: stm32_fmc2: fix a buffer overflow

Colin Ian King (1):
      mtd: mtdconcat: map: remove redundant assignment to variable 'size'

Douglas Anderson (1):
      mtd: spi-nor: Prefer asynchronous probe

Evgeny Novikov (1):
      mtd: rawnand: vf610: disable clk on error handling path in probe

Florian Fainelli (1):
      mtd: parsers: bcm63xx: Do not make it modular

Gustavo A. R. Silva (3):
      mtd: lpddr: Fix bad logic in print_drs_error
      mtd: lpddr: Replace printk with pr_notice
      mtd: lpddr: Move function print_drs_error to lpddr_cmds.c

Hauke Mehrtens (3):
      mtd: spinand: gigadevice: Only one dummy byte in QUADIO
      mtd: spinand: gigadevice: Add QE Bit
      mtd: spinand: gigadevice: Add support for GD5F4GQ4xC

Ikjoon Jang (1):
      mtd: spi-nor: winbond: Add support for w25q64jwm

Janusz Krzysztofik (1):
      mtd: rawnand: ams-delta: Fix non-OF build warning

Joe Perches (1):
      mtd: Avoid comma separated statements

Krzysztof Kozlowski (6):
      mtd: onenand: Simplify with dev_err_probe()
      mtd: rawnand: atmel: Simplify with dev_err_probe()
      mtd: rawnand: gpmi: Simplify with dev_err_probe()
      mtd: rawnand: marvell: Simplify with dev_err_probe()
      mtd: rawnand: marvell: Fix and update kerneldoc
      mtd: rawnand: qcom: Simplify with dev_err_probe()

Liu Shixin (3):
      mtd: rawnand: cadence: remove a redundant dev_err call
      mtd: onenand: simplify the return expression of onenand_transfer_auto_oob
      mtd: maps: vmu-flash: simplify the return expression of probe_maple_vmu

Mark Tomlinson (1):
      mtd: mtdoops: Don't write panic data twice

Matt Weber (1):
      mtd: mtdconcat: map through panic write handler

Mika Westerberg (1):
      mtd: spi-nor: intel-spi: Add support for Intel Alder Lake-S SPI serial flash

Miquel Raynal (21):
      mtd: rawnand: Add a kernel doc to the ECC algorithm enumeration
      mtd: rawnand: Rename the ECC algorithm enumeration items
      mtd: rawnand: Move the nand_ecc_algo enum to the generic NAND layer
      mtd: nand: Add a NAND page I/O request type
      dt-bindings: mtd: Document nand-ecc-placement
      dt-bindings: mtd: Document nand-ecc-engine
      dt-bindings: mtd: Document boolean NAND ECC properties
      mtd: nand: Introduce the ECC engine framework
      mtd: rawnand: Separate the ECC engine type and the ECC byte placement
      mtd: rawnand: Use the new ECC engine type enumeration
      mtd: nand: Create a helper to extract the ECC configuration
      mtd: spinand: Use nanddev_get_ecc_conf() when relevant
      mtd: nand: Create helpers to set/extract the ECC requirements
      mtd: rawnand: Use nanddev_get/set_ecc_requirements() when relevant
      mtd: nand: Use the new generic ECC object
      mtd: rawnand: Make use of the ECC framework
      mtd: rawnand: Use the ECC framework OOB layouts
      mtd: rawnand: Use the ECC framework nand_ecc_is_strong_enough() helper
      mtd: rawnand: Use the ECC framework user input parsing bits
      mtd: rawnand: Use the NAND framework user_conf object for ECC flags
      mtd: spear_smi: Enable compile testing

Pavel Machek (1):
      mtd: rawnand: oxnas: cleanup/simplify code

Qinglang Miao (1):
      mtd: spear_smi: use for_each_child_of_node() macro

Richard Weinberger (3):
      Merge tag 'nand/for-5.10' of git://git.kernel.org/.../mtd/linux into mtd/next
      Merge tag 'spi-nor/for-5.10' of git://git.kernel.org/.../mtd/linux into mtd/next
      Merge tag 'cfi/for-5.10' of gitolite.kernel.org:pub/scm/linux/kernel/git/mtd/linux into mtd/next

Robert Marko (1):
      mtd: spi-nor: macronix: Add SECT_4K to mx25l12805d

Serge Semin (1):
      mtd: physmap: Add Baikal-T1 physically mapped ROM support

Sergei Shtylyov (1):
      mtd: hyperbus: add Renesas RPC-IF driver

Tudor Ambarus (2):
      mtd: rawnand: Introduce nand_set_ecc_on_host_ops()
      mtd: rawnand: Don't overwrite the error code from nand_set_ecc_soft_ops()

Vignesh Raghavendra (6):
      mtd: hyperbus: Provide per device private pointer
      mtd: hyperbus: hbmc-am654: Fix direct mapping setup flash access
      mtd: hyperbus: hbmc-am654: Drop pm_runtime* calls from probe
      mtd: hyperbus: hbmc-am654: Add DMA support for reads
      Revert "mtd: spi-nor: Prefer asynchronous probe"
      mtd: hyperbus: Fix build failure when only RPCIF_HYPERBUS is enabled

Wei Yongjun (1):
      mtd: rawnand: pasemi: Make pasemi_device_ready() static

Yongqiang Liu (1):
      mtd: mtdcore: Convert to DEFINE_SHOW_ATTRIBUTE

YouChing Lin (2):
      mtd: spinand: macronix: Add support for MX31LF1GE4BC
      mtd: spinand: macronix: Add support for MX31UF1GE4BC

YueHaibing (1):
      mtd: rawnand: vf610: Remove unused function vf610_nfc_transfer_size()

 .../devicetree/bindings/mtd/nand-controller.yaml   |  31 ++
 arch/arm/mach-davinci/board-da830-evm.c            |   2 +-
 arch/arm/mach-davinci/board-da850-evm.c            |   2 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c        |   3 +-
 arch/arm/mach-davinci/board-dm365-evm.c            |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |   2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c           |   2 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |   2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c          |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |   2 +-
 arch/arm/mach-s3c24xx/common-smdk.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |   2 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |   2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |   2 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |   2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |   2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |   2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |   2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |   2 +-
 drivers/mtd/devices/Kconfig                        |   2 +-
 drivers/mtd/devices/lart.c                         |  10 +-
 drivers/mtd/devices/spear_smi.c                    |   4 +-
 drivers/mtd/hyperbus/Kconfig                       |   7 +
 drivers/mtd/hyperbus/Makefile                      |   1 +
 drivers/mtd/hyperbus/hbmc-am654.c                  | 144 +++++-
 drivers/mtd/hyperbus/rpc-if.c                      | 170 +++++++
 drivers/mtd/lpddr/lpddr2_nvm.c                     |  35 +-
 drivers/mtd/lpddr/lpddr_cmds.c                     |  28 ++
 drivers/mtd/maps/Kconfig                           |  11 +
 drivers/mtd/maps/Makefile                          |   1 +
 drivers/mtd/maps/physmap-bt1-rom.c                 | 126 +++++
 drivers/mtd/maps/physmap-bt1-rom.h                 |  17 +
 drivers/mtd/maps/physmap-core.c                    |   8 +-
 drivers/mtd/maps/vmu-flash.c                       |  11 +-
 drivers/mtd/mtdconcat.c                            |  43 ++
 drivers/mtd/mtdcore.c                              |  28 +-
 drivers/mtd/mtdoops.c                              |  11 +-
 drivers/mtd/nand/Kconfig                           |   8 +
 drivers/mtd/nand/Makefile                          |   2 +
 drivers/mtd/nand/ecc.c                             | 484 ++++++++++++++++++
 drivers/mtd/nand/onenand/onenand_base.c            |   9 +-
 drivers/mtd/nand/onenand/onenand_omap2.c           |   5 +-
 drivers/mtd/nand/raw/Kconfig                       |   1 +
 drivers/mtd/nand/raw/ams-delta.c                   |   6 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c      |  16 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c       | 457 +++++++++--------
 drivers/mtd/nand/raw/au1550nd.c                    |   4 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c   |   3 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  28 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c     |  12 +-
 drivers/mtd/nand/raw/cafe_nand.c                   |   3 +-
 drivers/mtd/nand/raw/cs553x_nand.c                 |   2 +-
 drivers/mtd/nand/raw/davinci_nand.c                |  38 +-
 drivers/mtd/nand/raw/denali.c                      |   3 +-
 drivers/mtd/nand/raw/denali_pci.c                  |   2 +-
 drivers/mtd/nand/raw/diskonchip.c                  |   3 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c               |  20 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                |  12 +-
 drivers/mtd/nand/raw/fsl_upm.c                     |   4 +-
 drivers/mtd/nand/raw/fsmc_nand.c                   |  14 +-
 drivers/mtd/nand/raw/gpio.c                        |   4 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |  21 +-
 drivers/mtd/nand/raw/hisi504_nand.c                |   6 +-
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c    |  20 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                 |   2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c                 |   3 +-
 drivers/mtd/nand/raw/marvell_nand.c                | 101 ++--
 drivers/mtd/nand/raw/meson_nand.c                  |   2 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c                 |   4 +-
 drivers/mtd/nand/raw/mtk_nand.c                    |  12 +-
 drivers/mtd/nand/raw/mxc_nand.c                    |  25 +-
 drivers/mtd/nand/raw/nand_base.c                   | 554 ++++++++-------------
 drivers/mtd/nand/raw/nand_bch.c                    |   1 +
 drivers/mtd/nand/raw/nand_esmt.c                   |  15 +-
 drivers/mtd/nand/raw/nand_hynix.c                  |  44 +-
 drivers/mtd/nand/raw/nand_jedec.c                  |   9 +-
 drivers/mtd/nand/raw/nand_micron.c                 |  23 +-
 drivers/mtd/nand/raw/nand_onfi.c                   |  17 +-
 drivers/mtd/nand/raw/nand_samsung.c                |  22 +-
 drivers/mtd/nand/raw/nand_toshiba.c                |  19 +-
 drivers/mtd/nand/raw/nandsim.c                     |   8 +-
 drivers/mtd/nand/raw/ndfc.c                        |   2 +-
 drivers/mtd/nand/raw/omap2.c                       |  22 +-
 drivers/mtd/nand/raw/orion_nand.c                  |   4 +-
 drivers/mtd/nand/raw/oxnas_nand.c                  |   3 +-
 drivers/mtd/nand/raw/pasemi_nand.c                 |   6 +-
 drivers/mtd/nand/raw/plat_nand.c                   |   4 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |  26 +-
 drivers/mtd/nand/raw/r852.c                        |   3 +-
 drivers/mtd/nand/raw/s3c2410.c                     |  20 +-
 drivers/mtd/nand/raw/sh_flctl.c                    |   6 +-
 drivers/mtd/nand/raw/sharpsl.c                     |   2 +-
 drivers/mtd/nand/raw/socrates_nand.c               |   5 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c             |  11 +-
 drivers/mtd/nand/raw/sunxi_nand.c                  |  27 +-
 drivers/mtd/nand/raw/tango_nand.c                  |   4 +-
 drivers/mtd/nand/raw/tegra_nand.c                  |  37 +-
 drivers/mtd/nand/raw/tmio_nand.c                   |   2 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                   |   2 +-
 drivers/mtd/nand/raw/vf610_nfc.c                   |  17 +-
 drivers/mtd/nand/raw/xway_nand.c                   |   4 +-
 drivers/mtd/nand/spi/core.c                        |  12 +-
 drivers/mtd/nand/spi/gigadevice.c                  |  63 ++-
 drivers/mtd/nand/spi/macronix.c                    |  27 +-
 drivers/mtd/nand/spi/toshiba.c                     |   6 +-
 drivers/mtd/parsers/Kconfig                        |   2 +-
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c    |   1 +
 drivers/mtd/spi-nor/macronix.c                     |   2 +-
 drivers/mtd/spi-nor/winbond.c                      |   9 +
 include/linux/mtd/hyperbus.h                       |  13 +
 include/linux/mtd/nand.h                           | 188 ++++++-
 include/linux/mtd/pfow.h                           |  33 --
 include/linux/mtd/rawnand.h                        |  34 +-
 include/linux/platform_data/mtd-davinci.h          |   9 +-
 include/linux/platform_data/mtd-nand-s3c2410.h     |   2 +-
 122 files changed, 2317 insertions(+), 1078 deletions(-)
 create mode 100644 drivers/mtd/hyperbus/rpc-if.c
 create mode 100644 drivers/mtd/maps/physmap-bt1-rom.c
 create mode 100644 drivers/mtd/maps/physmap-bt1-rom.h
 create mode 100644 drivers/mtd/nand/ecc.c
