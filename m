Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283712DC5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgLPSFE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 13:05:04 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56463 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgLPSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:05:04 -0500
X-Originating-IP: 90.1.135.213
Received: from xps13 (alille-651-1-136-213.w90-1.abo.wanadoo.fr [90.1.135.213])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7AC26FF80C;
        Wed, 16 Dec 2020 18:04:18 +0000 (UTC)
Date:   Wed, 16 Dec 2020 19:04:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for v5.11-rc1
Message-ID: <20201216190417.6b7dede2@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for v5.11-rc1

Thanks,
Miquèl


The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.11

for you to fetch changes up to 4c9e94dff65ca75b917ff0b5de2e44881062a8e8:

  Merge tags 'spi-nor/for-5.11' and 'nand/for-5.11' into mtd/next (2020-12-16 18:48:16 +0100)

----------------------------------------------------------------
MTD core:
* Fix refcounting for unpartitioned MTDs
* Fix misspelled function parameter 'section'
* Remove unneeded break
* cmdline parser: Fix parsing of part-names with colons
* mtdpart: Fix misdocumented function parameter 'mtd'

MTD devices:
* phram:
  - Allow the user to set the erase page size
  - File headers are not good candidates for kernel-doc
* physmap-bt1-rom: Fix __iomem addrspace removal warning
* plat-ram: correctly free memory on error path in platram_probe()
* powernv_flash: Add function names to headers and fix 'dev'
* docg3: Fix kernel-doc 'bad line' and 'excessive doc' issues

UBI cleanup fixes:
* gluebi: Fix misnamed function parameter documentation
* wl: Fix a couple of kernel-doc issues
* eba: Fix a couple of misdocumentation issues
* kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl' parameter
* Document 'ubi_num' in struct mtd_dev_param

Generic NAND core:
* ECC management:
  - Add an I/O request tweaking mechanism
  - Entire rework of the software BCH ECC driver, creation of a real
    ECC engine, getting rid of raw NAND structures, migration to more
    generic prototypes, misc fixes and style cleanup. Moved now to the
    Generic NAND layer.
  - Entire rework of the software Hamming ECC driver, creation of a
    real ECC engine, getting rid of raw NAND structures, misc renames,
    comment updates, cleanup, and style fixes. Moved now to the
    generic NAND layer.
  - Necessary plumbing at the NAND level to retrieve generic NAND ECC
    engines (softwares and on-die).
  - Update of the bindings.

Raw NAND core:
* Geting rid of the chip->ecc.priv entry.
* Fix miscellaneous typos in kernel-doc

Raw NAND controller drivers:
* Arasan: Document 'anfc_op's 'buf' member
* AU1550: Ensure the presence of the right includes
* Brcmnand: Demote non-conformant kernel-doc headers
* Cafe: Remove superfluous param doc and add another
* Davinci: Do not use extra dereferencing
* Diskonchip: Marking unused variables as __always_unused
* GPMI:
  - Fix the driver only sense CS0 R/B issue
  - Fix the random DMA timeout issue
  - Use a single line for of_device_id
  - Use of_device_get_match_data()
  - Fix reference count leak in gpmi ops
  - Cleanup makefile
  - Fix binding matching of clocks on different SoCs
* Ingenic: remove redundant get_device() in ingenic_ecc_get()
* Intel LGM: New NAND controller driver
* Marvell: Drop useless line
* Meson:
  - Fix a resource leak in init
  - Fix meson_nfc_dma_buffer_release() arguments
* mxc:
  - Use device_get_match_data()
  - Use a single line for of_device_id
  - Remove platform data support
* Omap:
  - Fix a bunch of kernel-doc misdemeanours
  - Finish ELM half populated function header, demote empty ones
* s3c2410: Add documentation for 2 missing struct members
* Sunxi: Document 'sunxi_nfc's 'caps' member
* Qcom:
  - Add support for SDX55
  - Support for IPQ6018 QPIC NAND controller
  - Fix DMA sync on FLASH_STATUS register read
* Rockchip: New NAND controller driver for RK3308, RK2928 and others
* Sunxi: Add MDMA support

ONENAND:
* bbt: Fix expected kernel-doc formatting
* Fix some kernel-doc misdemeanours
* Fix expected kernel-doc formatting
* Use mtd->oops_panic_write as condition

SPI-NAND core:
* Creation of a SPI-NAND on-die ECC engine
* Move ECC related definitions earlier in the driver
* Fix typo in comment
* Fill a default ECC provider/algorithm
* Remove outdated comment
* Fix OOB read
* Allow the case where there is no ECC engine
* Use the external ECC engine logic

SPI-NAND chip drivers:
* Micron:
  - Add support for MT29F2G01AAAED
  - Use more specific names
* Macronix:
  - Add support for MX35LFxG24AD
  - Add support for MX35LFxGE4AD
* Toshiba: Demote non-conformant kernel-doc header

SPI-NOR core:
* Initial support for stateful Octal DTR mode using volatile settings
* Preliminary support for JEDEC 251 (xSPI) and JEDEC 216D standards
* Support for Cypress Semper flash
* Support to specify ECC block size of SPI NOR flashes
* Fixes to avoid clearing of non-volatile Block Protection bits at
  probe
* hisi-sfc: Demote non-conformant kernel-doc

----------------------------------------------------------------
Baskov Evgeiny (1):
      mtd: plat-ram: correctly free memory on error path in platram_probe()

Dan Carpenter (1):
      mtd: rawnand: meson: Fix a resource leak in init

Fabio Estevam (5):
      mtd: rawnand: mxc: Remove platform data support
      mtd: rawnand: gpmi: Use of_device_get_match_data()
      mtd: rawnand: mxc: Use device_get_match_data()
      mtd: rawnand: mxc: Use a single line for of_device_id
      mtd: rawnand: gpmi: Use a single line for of_device_id

Han Xu (2):
      mtd: rawnand: gpmi: Fix the driver only sense CS0 R/B issue
      mtd: rawnand: gpmi: Fix the random DMA timeout issue

Jonathan Neuschäfer (1):
      mtd: spi-nor: Fix multiple typos

Kathiravan T (2):
      dt-bindings: qcom_nandc: IPQ6018 QPIC NAND documentation
      mtd: rawnand: qcom: Support for IPQ6018 QPIC NAND controller

Krzysztof Kozlowski (1):
      dt-bindings: mtd: gpmi-nand: Fix matching of clocks on different SoCs

Lee Jones (23):
      mtd: mtdpart: Fix misdocumented function parameter 'mtd'
      mtd: devices: phram: File headers are not good candidates for kernel-doc
      mtd: onenand: onenand_base: Fix expected kernel-doc formatting
      mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc' issues
      mtd: Fix misspelled function parameter 'section'
      mtd: onenand: onenand_bbt: Fix expected kernel-doc formatting
      mtd: spi-nor: hisi-sfc: Demote non-conformant kernel-doc
      mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
      mtd: spinand: toshiba: Demote non-conformant kernel-doc header
      mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl' parameter
      mtd: ubi: eba: Fix a couple of misdocumentation issues
      mtd: ubi: wl: Fix a couple of kernel-doc issues
      mtd: rawnand: brcmnand: Demote non-conformant kernel-doc headers
      mtd: ubi: gluebi: Fix misnamed function parameter documentation
      mtd: rawnand: diskonchip: Marking unused variables as __always_unused
      mtd: rawnand: cafe_nand: Remove superfluous param doc and add another
      mtd: rawnand: s3c2410: Add documentation for 2 missing struct members
      mtd: rawnand: omap_elm: Finish half populated function header, demote empty ones
      mtd: rawnand: omap2: Fix a bunch of kernel-doc misdemeanours
      mtd: rawnand: sunxi: Document 'sunxi_nfc's 'caps' member
      mtd: rawnand: arasan: Document 'anfc_op's 'buf' member
      mtd: onenand: Fix some kernel-doc misdemeanours
      mtd: devices: powernv_flash: Add function names to headers and fix 'dev'

Manivannan Sadhasivam (2):
      dt-bindings: qcom_nandc: Add SDX55 QPIC NAND documentation
      mtd: rawnand: qcom: Add NAND controller support for SDX55

Manuel Dipolt (1):
      mtd: rawnand: sunxi: Add MDMA support

Marco Felsch (1):
      mtd: rawnand: gpmi: cleanup makefile

Mauro Carvalho Chehab (1):
      mtd: rawnand: fix a kernel-doc markup

Michael Walle (7):
      mtd: spi-nor: sst: fix BPn bits for the SST25VF064C
      mtd: spi-nor: ignore errors in spi_nor_unlock_all()
      mtd: spi-nor: atmel: remove global protection flag
      mtd: spi-nor: sst: remove global protection flag
      mtd: spi-nor: intel: remove global protection flag
      mtd: spi-nor: atmel: fix unlock_all() for AT25FS010/040
      mtd: spi-nor: keep lock bits if they are non-volatile

Miquel Raynal (38):
      mtd: nand: ecc: Add an I/O request tweaking mechanism
      mtd: nand: ecc-bch: Move BCH code to the generic NAND layer
      mtd: nand: ecc-bch: Cleanup and style fixes
      mtd: nand: ecc-bch: Stop exporting the private structure
      mtd: nand: ecc-bch: Return only valid error codes
      mtd: nand: ecc-bch: Drop mtd_nand_has_bch()
      mtd: nand: ecc-bch: Update the prototypes to be more generic
      mtd: nand: ecc-bch: Stop using raw NAND structures
      mtd: nand: ecc-bch: Create the software BCH engine
      mtd: rawnand: Get rid of chip->ecc.priv
      mtd: nand: ecc-hamming: Move Hamming code to the generic NAND layer
      mtd: nand: ecc-hamming: Clarify the driver descriptions
      mtd: nand: ecc-hamming: Drop/fix the kernel doc
      mtd: nand: ecc-hamming: Cleanup and style fixes
      mtd: nand: ecc-hamming: Rename the exported functions
      mtd: nand: ecc-hamming: Stop using raw NAND structures
      mtd: nand: ecc-hamming: Remove useless includes
      mtd: nand: ecc-hamming: Let the software Hamming ECC engine be unselected
      mtd: nand: ecc-hamming: Create the software Hamming engine
      mtd: nand: Let software ECC engines be retrieved from the NAND core
      mtd: spinand: Fix typo in comment
      mtd: spinand: Move ECC related definitions earlier in the driver
      mtd: spinand: Instantiate a SPI-NAND on-die ECC engine
      mtd: nand: Let on-die ECC engines be retrieved from the NAND core
      mtd: spinand: Fill a default ECC provider/algorithm
      mtd: nand: Add helpers to manage ECC engines and configurations
      dt-bindings: mtd: Deprecate nand-ecc-mode
      mtd: spinand: Use the external ECC engine logic
      mtd: spinand: Allow the case where there is no ECC engine
      mtd: spinand: Fix OOB read
      mtd: spinand: Remove outdated comment
      mtd: nand: ecc-hamming: Clarify the logic around rp17
      docs: mtd: Avoid htmldocs warnings
      mtd: nand: Change dependency between the NAND and ECC cores
      mtd: rawnand: au1550: Ensure the presence of the right includes
      mtd: rawnand: davinci: Do not use extra dereferencing
      mtd: rawnand: marvell: Drop useless line
      Merge tags 'spi-nor/for-5.11' and 'nand/for-5.11' into mtd/next

Patrick O'Grady (1):
      mtd: phram: Allow the user to set the erase page size.

Pratyush Yadav (15):
      mtd: spi-nor: core: use EOPNOTSUPP instead of ENOTSUPP
      mtd: spi-nor: add spi_nor_controller_ops_{read_reg, write_reg, erase}()
      mtd: spi-nor: add support for DTR protocol
      mtd: spi-nor: sfdp: get command opcode extension type from BFPT
      mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
      mtd: spi-nor: core: use dummy cycle and address width info from SFDP
      mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
      mtd: spi-nor: core: enable octal DTR mode when possible
      mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
      mtd: spi-nor: core: perform a Soft Reset on shutdown
      mtd: spi-nor: core: disable Octal DTR mode on suspend.
      mtd: spi-nor: spansion: add support for Cypress Semper flash
      mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode
      mtd: spi-nor: core: Allow flashes to specify MTD writesize
      mtd: spi-nor: spansion: Set ECC block size

Praveenkumar I (1):
      mtd: rawnand: qcom: Fix DMA sync on FLASH_STATUS register read

Ramuthevar Vadivel Murugan (2):
      dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC
      mtd: rawnand: Add NAND controller support on Intel LGM SoC

Richard Weinberger (1):
      mtd: core: Fix refcounting for unpartitioned MTDs

Serge Semin (1):
      mtd: physmap: physmap-bt1-rom: Fix __iomem addrspace removal warning

Sergei Antonov (1):
      mtd: rawnand: meson: fix meson_nfc_dma_buffer_release() arguments

Sven Eckelmann (1):
      mtd: parser: cmdline: Fix parsing of part-names with colons

Thirumalesha Narasimhappa (2):
      mtd: spinand: micron: Use more specific names
      mtd: spinand: micron: Add support for MT29F2G01AAAED

Thomas Gleixner (1):
      mtd: onenand: Use mtd->oops_panic_write as condition

Tom Rix (1):
      mtd: remove unneeded break

Tudor Ambarus (2):
      mtd: spi-nor: Introduce SNOR_F_IO_MODE_EN_VOLATILE
      mtd: spi-nor: Parse SFDP SCCR Map

Yifeng Zhao (2):
      dt-bindings: mtd: Describe Rockchip RK3xxx NAND flash controller
      mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others

YouChing Lin (2):
      mtd: spinand: macronix: Add support for MX35LFxGE4AD
      mtd: spinand: macronix: Add support for MX35LFxG24AD

Yu Kuai (1):
      mtd: rawnand: ingenic: remove redundant get_device() in ingenic_ecc_get()

Zhang Qilong (1):
      mtd: rawnand: gpmi: fix reference count leak in gpmi ops

 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml               |   76 +-
 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml          |   99 ++
 Documentation/devicetree/bindings/mtd/nand-controller.yaml         |   11 +-
 Documentation/devicetree/bindings/mtd/qcom_nandc.txt               |    4 +
 .../devicetree/bindings/mtd/rockchip,nand-controller.yaml          |  161 ++++
 Documentation/driver-api/mtd/nand_ecc.rst                          |    2 +-
 Documentation/driver-api/mtdnand.rst                               |    3 -
 arch/arm/mach-s3c/common-smdk-s3c24xx.c                            |    2 +-
 arch/arm/mach-s3c/mach-anubis.c                                    |    2 +-
 arch/arm/mach-s3c/mach-at2440evb.c                                 |    2 +-
 arch/arm/mach-s3c/mach-bast.c                                      |    2 +-
 arch/arm/mach-s3c/mach-gta02.c                                     |    2 +-
 arch/arm/mach-s3c/mach-jive.c                                      |    2 +-
 arch/arm/mach-s3c/mach-mini2440.c                                  |    2 +-
 arch/arm/mach-s3c/mach-osiris.c                                    |    2 +-
 arch/arm/mach-s3c/mach-qt2410.c                                    |    2 +-
 arch/arm/mach-s3c/mach-rx3715.c                                    |    2 +-
 arch/arm/mach-s3c/mach-vstms.c                                     |    2 +-
 drivers/mtd/Kconfig                                                |    1 +
 drivers/mtd/devices/docg3.c                                        |    5 +-
 drivers/mtd/devices/phram.c                                        |   54 +-
 drivers/mtd/devices/powernv_flash.c                                |    5 +-
 drivers/mtd/maps/physmap-bt1-rom.c                                 |    8 +-
 drivers/mtd/maps/plat-ram.c                                        |   11 +-
 drivers/mtd/mtdchar.c                                              |    2 -
 drivers/mtd/mtdcore.c                                              |    6 +-
 drivers/mtd/mtdpart.c                                              |    2 +-
 drivers/mtd/nand/Kconfig                                           |   33 +-
 drivers/mtd/nand/Makefile                                          |    2 +
 drivers/mtd/nand/core.c                                            |  124 +++
 drivers/mtd/nand/ecc-sw-bch.c                                      |  406 ++++++++
 drivers/mtd/nand/{raw/nand_ecc.c => ecc-sw-hamming.c}              |  315 ++++--
 drivers/mtd/nand/ecc.c                                             |  140 ++-
 drivers/mtd/nand/onenand/onenand_base.c                            |  444 +++++----
 drivers/mtd/nand/onenand/onenand_bbt.c                             |   32 +-
 drivers/mtd/nand/onenand/onenand_omap2.c                           |   16 +-
 drivers/mtd/nand/raw/Kconfig                                       |   45 +-
 drivers/mtd/nand/raw/Makefile                                      |    4 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c                      |    1 +
 drivers/mtd/nand/raw/au1550nd.c                                    |    1 +
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                           |    6 +-
 drivers/mtd/nand/raw/cafe_nand.c                                   |    2 +-
 drivers/mtd/nand/raw/cs553x_nand.c                                 |    3 +-
 drivers/mtd/nand/raw/davinci_nand.c                                |   38 +-
 drivers/mtd/nand/raw/diskonchip.c                                  |    4 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c                               |    1 -
 drivers/mtd/nand/raw/fsl_ifc_nand.c                                |    1 -
 drivers/mtd/nand/raw/fsl_upm.c                                     |    1 -
 drivers/mtd/nand/raw/fsmc_nand.c                                   |    5 +-
 drivers/mtd/nand/raw/gpmi-nand/Makefile                            |    3 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                         |   76 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-regs.h                         |    1 +
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c                         |    2 -
 drivers/mtd/nand/raw/intel-nand-controller.c                       |  721 ++++++++++++++
 drivers/mtd/nand/raw/lpc32xx_mlc.c                                 |    1 -
 drivers/mtd/nand/raw/lpc32xx_slc.c                                 |    3 +-
 drivers/mtd/nand/raw/marvell_nand.c                                |    6 -
 drivers/mtd/nand/raw/meson_nand.c                                  |    7 +-
 drivers/mtd/nand/raw/mxc_nand.c                                    |   94 +-
 drivers/mtd/nand/raw/mxic_nand.c                                   |    2 +-
 drivers/mtd/nand/raw/nand_base.c                                   |  204 ++--
 drivers/mtd/nand/raw/nand_bbt.c                                    |    2 +-
 drivers/mtd/nand/raw/nand_bch.c                                    |  219 -----
 drivers/mtd/nand/raw/nand_legacy.c                                 |    9 +-
 drivers/mtd/nand/raw/nandsim.c                                     |    3 +-
 drivers/mtd/nand/raw/ndfc.c                                        |    3 +-
 drivers/mtd/nand/raw/omap2.c                                       |   49 +-
 drivers/mtd/nand/raw/omap_elm.c                                    |    7 +-
 drivers/mtd/nand/raw/pasemi_nand.c                                 |    1 -
 drivers/mtd/nand/raw/qcom_nandc.c                                  |   74 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c                    | 1495 +++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/s3c2410.c                                     |    5 +-
 drivers/mtd/nand/raw/sharpsl.c                                     |    3 +-
 drivers/mtd/nand/raw/sunxi_nand.c                                  |  149 +--
 drivers/mtd/nand/raw/tmio_nand.c                                   |    7 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                                   |    5 +-
 drivers/mtd/nand/spi/Kconfig                                       |    1 +
 drivers/mtd/nand/spi/core.c                                        |  286 ++++--
 drivers/mtd/nand/spi/macronix.c                                    |   47 +
 drivers/mtd/nand/spi/micron.c                                      |  124 ++-
 drivers/mtd/nand/spi/toshiba.c                                     |    2 +-
 drivers/mtd/parsers/cmdlinepart.c                                  |   14 +-
 drivers/mtd/sm_ftl.c                                               |   30 +-
 drivers/mtd/spi-nor/Kconfig                                        |   44 +
 drivers/mtd/spi-nor/atmel.c                                        |  191 +++-
 drivers/mtd/spi-nor/controllers/hisi-sfc.c                         |    2 +-
 drivers/mtd/spi-nor/core.c                                         |  597 +++++++++---
 drivers/mtd/spi-nor/core.h                                         |   38 +
 drivers/mtd/spi-nor/esmt.c                                         |    2 +-
 drivers/mtd/spi-nor/intel.c                                        |   19 +-
 drivers/mtd/spi-nor/micron-st.c                                    |  115 ++-
 drivers/mtd/spi-nor/sfdp.c                                         |  172 +++-
 drivers/mtd/spi-nor/sfdp.h                                         |    8 +
 drivers/mtd/spi-nor/spansion.c                                     |  172 ++++
 drivers/mtd/spi-nor/sst.c                                          |   32 +-
 drivers/mtd/tests/mtd_nandecctest.c                                |   31 +-
 drivers/mtd/ubi/build.c                                            |    1 +
 drivers/mtd/ubi/eba.c                                              |    3 +-
 drivers/mtd/ubi/gluebi.c                                           |    2 +-
 drivers/mtd/ubi/kapi.c                                             |    2 +-
 drivers/mtd/ubi/wl.c                                               |    3 +-
 include/linux/mtd/nand-ecc-sw-bch.h                                |   73 ++
 include/linux/mtd/nand-ecc-sw-hamming.h                            |   91 ++
 include/linux/mtd/nand.h                                           |   56 ++
 include/linux/mtd/nand_bch.h                                       |   66 --
 include/linux/mtd/nand_ecc.h                                       |   39 -
 include/linux/mtd/rawnand.h                                        |   19 +-
 include/linux/mtd/sharpsl.h                                        |    1 -
 include/linux/mtd/spi-nor.h                                        |   55 +-
 include/linux/mtd/spinand.h                                        |    9 +
 include/linux/platform_data/mtd-mxc_nand.h                         |   19 -
 111 files changed, 6110 insertions(+), 1503 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
 create mode 100644 drivers/mtd/nand/ecc-sw-bch.c
 rename drivers/mtd/nand/{raw/nand_ecc.c => ecc-sw-hamming.c} (61%)
 create mode 100644 drivers/mtd/nand/raw/intel-nand-controller.c
 delete mode 100644 drivers/mtd/nand/raw/nand_bch.c
 create mode 100644 drivers/mtd/nand/raw/rockchip-nand-controller.c
 create mode 100644 include/linux/mtd/nand-ecc-sw-bch.h
 create mode 100644 include/linux/mtd/nand-ecc-sw-hamming.h
 delete mode 100644 include/linux/mtd/nand_bch.h
 delete mode 100644 include/linux/mtd/nand_ecc.h
 delete mode 100644 include/linux/platform_data/mtd-mxc_nand.h
