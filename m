Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294628F20F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgJOM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgJOM22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:28:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832A522257;
        Thu, 15 Oct 2020 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602764906;
        bh=GU7WvKP759QvjvCiaKFHaVSJFDbGUg2lb/eZZ8rYscg=;
        h=Date:From:To:Cc:Subject:From;
        b=fjGFdATSgJmjxi/qFfRqFt+qPQNpYCnzjV5sJkdS8Uc/nf7iVbefkkhYs8NZ5T2OB
         x+3ZEEdDJ9mlmydbDmw2AqIjYjeJ5gXG7Gh3tJ25K5LG+v18EUYYWkbM1Wu54d53zx
         G4jgpZqAGd638Ld2BiCSFCw7JzvNWELT9s9U5cig=
Date:   Thu, 15 Oct 2020 14:28:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.10-rc1
Message-ID: <20201015122858.GA4021771@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc1

for you to fetch changes up to f3277cbfba763cd2826396521b9296de67cf1bbc:

  binder: fix UAF when releasing todo list (2020-10-10 12:40:52 +0200)

----------------------------------------------------------------
Char/Misc driver patches for 5.10-rc1

Here is the big set of char, misc, and other assorted driver subsystem
patches for 5.10-rc1.

There's a lot of different things in here, all over the drivers/
directory.  Some summaries:
	- soundwire driver updates
	- habanalabs driver updates
	- extcon driver updates
	- nitro_enclaves new driver
	- fsl-mc driver and core updates
	- mhi core and bus updates
	- nvmem driver updates
	- eeprom driver updates
	- binder driver updates and fixes
	- vbox minor bugfixes
	- fsi driver updates
	- w1 driver updates
	- coresight driver updates
	- interconnect driver updates
	- misc driver updates
	- other minor driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alex Dewar (1):
      VMCI: check return value of get_user_pages_fast() for errors

Alexander A. Klimov (1):
      extcon: Replace HTTP links with HTTPS ones

Alexander Shishkin (2):
      intel_th: pci: Add Alder Lake-S support
      intel_th: pci: Add Alder Lake CPU support

Alexander Usyskin (10):
      mei: hbm: add capabilities message
      mei: restrict vtag support to hbm version 2.2
      mei: add vtag support bit in client properties
      mei: bump hbm version to 2.2
      mei: add a spin lock to protect rd_completed queue
      mei: add a vtag map for each client
      mei: handle tx queue flushing for vtag connections
      mei: bus: use zero vtag for bus clients.
      mei: bus: unconditionally enable clients with vtag support
      mei: add connect with vtag ioctl

Andra Paraschiv (18):
      nitro_enclaves: Add ioctl interface definition
      nitro_enclaves: Define the PCI device interface
      nitro_enclaves: Define enclave info for internal bookkeeping
      nitro_enclaves: Init PCI device driver
      nitro_enclaves: Handle PCI device command requests
      nitro_enclaves: Handle out-of-band PCI device events
      nitro_enclaves: Init misc device providing the ioctl interface
      nitro_enclaves: Add logic for creating an enclave VM
      nitro_enclaves: Add logic for setting an enclave vCPU
      nitro_enclaves: Add logic for getting the enclave image load info
      nitro_enclaves: Add logic for setting an enclave memory region
      nitro_enclaves: Add logic for starting an enclave
      nitro_enclaves: Add logic for terminating an enclave
      nitro_enclaves: Add Kconfig for the Nitro Enclaves driver
      nitro_enclaves: Add Makefile for the Nitro Enclaves driver
      nitro_enclaves: Add sample for ioctl interface usage
      nitro_enclaves: Add overview documentation
      MAINTAINERS: Add entry for the Nitro Enclaves driver

Andy Shevchenko (1):
      extcon: ptn5150: Deduplicate parts of dev_err_probe()

Bard Liao (4):
      soundwire: master: enable pm runtime
      soundwire: intel: reinitialize IP+DSP in .prepare(), but only when resuming
      soundwire: intel: fix intel_suspend/resume defined but not used warning
      soundwire: Add generic bandwidth allocation algorithm

Bartosz Golaszewski (1):
      nvmem: switch to simpler IDA interface

Bharat Bhushan (3):
      bus/fsl-mc: add support for 'driver_override' in the mc-bus
      bus/fsl-mc: Add dprc-reset-container support
      bus/fsl-mc: Extend ICID size from 16bit to 32bit

Bhaumik Bhatt (12):
      bus: mhi: core: Remove double occurrence for mhi_ctrl_ev_task() declaration
      bus: mhi: core: Abort suspends due to outgoing pending packets
      bus: mhi: core: Use helper API to trigger a non-blocking host resume
      bus: mhi: core: Trigger host resume if suspended during mhi_device_get()
      bus: mhi: core: Use generic name field for an MHI device
      bus: mhi: core: Introduce helper function to check device state
      bus: mhi: core: Introduce counters to track MHI device state transitions
      bus: mhi: core: Read and save device hardware information from BHI
      bus: mhi: core: Introduce APIs to allocate and free the MHI controller
      bus: mhi: Fix entries based on Kconfig coding style
      bus: mhi: core: Introduce debugfs entries for MHI
      bus: mhi: core: Introduce sysfs entries for MHI

Chih-En Hsu (1):
      nvmem: mtk-efuse: Remove EFUSE register write support

Christian Eggers (2):
      eeprom: at25: allow page sizes greater than 16 bit
      eeprom: at25: set minimum read/write access stride to 1

Christoph Hellwig (2):
      /dev/zero: also implement ->read
      /dev/zero: fixups for ->read

Clark Williams (1):
      bus: mhi: Remove include of rwlock_types.h

Colin Ian King (3):
      fsi: master-ast-cf: fix spelling mistake "firwmare" -> "firmware"
      misc: hisi_hikey_usb: fix return of uninitialized ret status variable
      binder: remove redundant assignment to pointer n

Dan Carpenter (2):
      misc: hisi_hikey_usb: delete a stray tab
      soundwire: remove an unnecessary NULL check

Denis Efremov (2):
      char: mspec: Use kvzalloc() in mspec_mmap()
      virt: vbox: Use current_uid() in vbg_misc_device_requestor()

Diana Craciun (10):
      bus/fsl-mc: Do no longer export the total number of irqs outside dprc_scan_objects
      bus/fsl-mc: Add a new parameter to dprc_scan_objects function
      bus/fsl-mc: Set the QMAN/BMAN region flags
      bus/fsl-mc: Cache the DPRC API version
      bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by multiple entities
      bus/fsl-mc: Export a cleanup function for DPRC
      bus/fsl-mc: Add a container setup function
      bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
      bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
      bus/fsl-mc: Add a new version for dprc_get_obj_region command

Dotan Barak (1):
      habanalabs: print the queue id in case of an error

Eddie James (5):
      fsi: aspeed: Enable 23-bit addressing
      fsi: master: Add boolean parameter to link_enable function
      fsi: core: Disable link when slave init fails
      fsi: core: Set slave local bus ownership during init
      fsi: master: Remove link enable read-back

Georgi Djakov (9):
      interconnect: Add bulk API helpers
      interconnect: Introduce xlate_extended() callback
      dt-bindings: interconnect: Document the support of optional path tag
      interconnect: qcom: Implement xlate_extended() to parse tags
      interconnect: qcom: sdm845: Replace xlate with xlate_extended
      interconnect: Add get_bw() callback
      interconnect: Add sync state support
      interconnect: qcom: Use icc_sync_state
      Merge branch 'icc-syncstate' into icc-next

Greg Kroah-Hartman (11):
      Merge 5.9-rc3 into char-misc-next
      Merge tag 'fsi-for-5.10' of git://git.kernel.org/.../joel/fsi into char-misc-next
      Merge 5.9-rc5 into char-misc-next
      Merge tag 'fpga-for-5.10' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-next
      Merge tag 'misc-habanalabs-next-2020-09-22' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge tag 'icc-5.10-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next
      Merge tag 'misc-habanalabs-next-2020-09-25' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      MAINTAINERS: exclude char maintainers from things they do not maintain
      Merge tag 'soundwire-5.10-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge tag 'extcon-next-for-5.10-v2' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      w1: w1_therm: make w1_poll_completion static

Hemant Kumar (1):
      bus: mhi: core: Add const qualifier to MHI config information

Hillf Danton (1):
      habanalabs: make use of dma_mmap_coherent

Ivan Zaentsev (3):
      w1: w1_therm: Add sysfs entries to control conversion time and driver features
      w1: w1_therm: Add support for GXCAS GX20MH01 device.
      docs: w1: w1_therm: Fix broken xref, mistakes, clarify text

Jann Horn (1):
      binder: Remove bogus warning on failed same-process transaction

Joe Perches (1):
      lp: Avoid comma separated statements

Joel Stanley (5):
      dt-bindings: fsi: Document gpios
      fsi: aspeed: Support cabled FSI
      fsi: aspeed: Run the bus at maximum speed
      fsi: aspeed: Add module param for bus divisor
      fsi: aspeed: Support CFAM reset GPIO

Jonathan Marek (13):
      soundwire: qcom: fix abh/ahb typo
      soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
      soundwire: qcom: add support for mmio soundwire master devices
      soundwire: qcom: add v1.5.1 compatible
      dt-bindings: interconnect: single yaml file for RPMh interconnect drivers
      dt-bindings: interconnect: Add Qualcomm SM8150 DT bindings
      dt-bindings: interconnect: Add Qualcomm SM8250 DT bindings
      interconnect: qcom: Add SM8150 interconnect provider driver
      interconnect: qcom: Add SM8250 interconnect provider driver
      soundwire: qcom: fix SLIBMUS/SLIMBUS typo
      misc: fastrpc: fix indentation error in uapi header
      misc: fastrpc: define names for protection domain ids
      misc: fastrpc: add ioctl for attaching to sensors pd

Jonathan Zhou (3):
      coresight: etm4x: Fix issues within reset interface of sysfs
      coresight: etm4x: Fix issues on trcseqevr access
      coresight: etm4x: Fix mis-usage of nr_resource in sysfs interface

Julia Lawall (1):
      misc: mic: drop double zeroing

Kees Cook (13):
      selftests/lkdtm: Use "comm" instead of "diff" for dmesg
      fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
      fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
      fs/kernel_read_file: Split into separate source file
      fs/kernel_read_file: Remove redundant size argument
      fs/kernel_read_file: Switch buffer size arg to size_t
      fs/kernel_read_file: Add file_size output argument
      LSM: Introduce kernel_post_load_data() hook
      firmware_loader: Use security_post_load_data()
      module: Call security_kernel_post_load_data()
      LSM: Add "contents" flag to kernel_read_file hook
      fs/kernel_file_read: Add "offset" arg for partial reads
      firmware: Store opt_flags in fw_priv

Keita Suzuki (1):
      misc: rtsx: Fix memory leak in rtsx_pci_probe

Kim Phillips (8):
      coresight: Use IS_ENABLED for CONFIGs that may be modules
      coresight: etm3x: Allow etm3x to be built as a module
      coresight: etm4x: Allow etm4x to be built as a module
      coresight: etb: Allow etb to be built as a module
      coresight: tpiu: Allow tpiu to be built as a module
      coresight: tmc: Allow tmc to be built as a module
      coresight: funnel: Allow funnel driver to be built as module
      coresight: replicator: Allow replicator driver to be built as module

Krzysztof Kozlowski (22):
      interconnect: core: Simplify with dev_err_probe()
      interconnect: imx: Simplify with dev_err_probe()
      dt-bindings: extcon: ptn5150: Convert binding to DT schema
      dt-bindings: extcon: ptn5150: Use generic "interrupts" property
      dt-bindings: extcon: ptn5150: Make 'vbus-gpios' optional
      extcon: ptn5150: Fix usage of atomic GPIO with sleeping GPIO chips
      extcon: ptn5150: Use generic "interrupts" property
      extcon: ptn5150: Simplify getting vbus-gpios with flags
      extcon: ptn5150: Lower the noisiness of probe
      extcon: ptn5150: Check current USB mode when probing
      extcon: ptn5150: Make 'vbus-gpios' optional
      extcon: ptn5150: Reduce the amount of logs on deferred probe
      extcon: ptn5150: Convert to module_i2c_driver
      extcon: ptn5150: Convert to .probe_new
      MAINTAINERS: Add entry for NXP PTN5150A CC driver
      extcon: max14577: Return error code of extcon_dev_allocate()
      extcon: max77693: Return error code of extcon_dev_allocate()
      extcon: max77843: Return error code of extcon_dev_allocate()
      extcon: max8997: Return error code of extcon_dev_allocate()
      extcon: palmas: Simplify with dev_err_probe()
      extcon: ptn5150: Use defines for registers
      extcon: ptn5150: Do not print error during probe if nothing is attached

Lang Dai (1):
      uio: free uio id after uio file node is freed

Laurentiu Tudor (2):
      bus: fsl-mc: don't assume an iommu is always present
      bus: fsl-mc: MC control registers are not always available

Linu Cherian (2):
      coresight: etm: perf: Sink selection using sysfs is deprecated
      coresight: Make sysfs functional on topologies with per core sink

Liu Shixin (4):
      interconnect: imx: simplify the return expression of imx_icc_unregister
      extcon: axp288: Use module_platform_driver to simplify the code
      eeprom: ee1004: use module_i2c_driver to simplify the code
      binder: simplify the return expression of binder_mmap

Loic Poulain (3):
      bus: mhi: core: Allow shared IRQ for event rings
      bus: mhi: Remove unused nr_irqs_req variable
      bus: mhi: debugfs: Print channel context read-pointer

Luca Ceresoli (5):
      fpga manager: xilinx-spi: remove stray comment
      fpga manager: xilinx-spi: remove final dot from dev_err() strings
      fpga manager: xilinx-spi: fix write_complete timeout handling
      fpga manager: xilinx-spi: add error checking after gpiod_get_value()
      fpga manager: xilinx-spi: provide better diagnostics on programming failure

Manivannan Sadhasivam (1):
      bus: mhi: core: Fix the building of MHI module

Marek Szyprowski (1):
      misc: fastrpc: fix common struct sg_table related issues

Martijn Coenen (1):
      binder: print warnings when detecting oneway spamming.

Martin Fuzzey (1):
      w1: mxc_w1: Fix timeout resolution problem leading to bus error

Mathieu Poirier (1):
      MAINTAINERS: Add CoreSight mailing list

Mauro Carvalho Chehab (4):
      misc: hisi_hikey_usb: add support for Hikey 970
      firmware_loader: fix a kernel-doc markup
      misc: Kconfig: add a new dependency for HISI_HIKEY_USB
      misc: Kconfig: fix a HISI_HIKEY_USB dependency

Mian Yousaf Kaukab (3):
      coresight: fix offset by one error in counting ports
      coresight: Export global symbols
      coresight: tmc-etr: Add function to register catu ops

Michal Suchanek (1):
      char: virtio: Select VIRTIO from VIRTIO_CONSOLE.

Mike Leach (4):
      coresight: etm4x: Ensure default perf settings filter user/kernel
      coresight: etm4x: Fix number of resources check for ETM 4.3 and above
      coresight: cti: Fix remove sysfs link error
      coresight: cti: Fix bug clearing sysfs links on callback

Mike Tipton (5):
      dt-bindings: interconnect: Add generic qcom bindings
      dt-bindings: interconnect: Add property to set BCM TCS wait behavior
      interconnect: qcom: Support bcm-voter-specific TCS wait behavior
      interconnect: qcom: Only wait for completion in AMC/WAKE by default
      interconnect: qcom: Add support for per-BCM scaling factors

Moritz Fischer (1):
      fpga: fpga-region: Cleanup an outdated comment

Moti Haimovski (4):
      habanalabs: rename mmu.c to mmu_v1.c
      habanalabs: refactor MMU as device-oriented
      habanalabs: add num_hops to hl_mmu_properties
      habanalabs: add debugfs support for MMU with 6 HOPs

Nathan Chancellor (1):
      LSM: Fix type of id parameter in kernel_post_load_data prototype

Necip Fazil Yildiran (1):
      ocxl: fix kconfig dependency warning for OCXL

Oded Gabbay (33):
      habanalabs: increase length of ASIC name
      habanalabs: change CB's ID to be 64 bits
      habanalabs: cast int to u32 before printing it with %u
      habanalabs: eliminate redundant else condition
      habanalabs: use standard BIT() and GENMASK()
      habanalabs: use FIELD_PREP() instead of <<
      habanalabs: remove redundant assignment to variable
      habanalabs: check TPC vector pipe is empty
      habanalabs: use 1U when shifting bits
      habanalabs: update GAUDI hardware specs
      habanalabs: replace armcp with the generic cpucp
      habanalabs: cast to u64 before shift > 31 bits
      habanalabs: restructure hl_mmap
      habanalabs: clear vm_pgoff before doing the mmap
      habanalabs: count dropped CS because max CS in-flight
      habanalabs: rename ArmCP to CPU-CP
      habanalabs: remove unused ASIC function pointer
      habanalabs: remove unused define
      habanalabs: increase PQ COMP_OFFSET by one nibble
      habanalabs: check flag before reset because of f/w event
      habanalabs/gaudi: increase timeout for boot fit load
      habanalabs: allow to wait on CS without sleep
      habanalabs: no need for DMA_SHARED_BUFFER
      habanalabs: update firmware interface file
      habanalabs/gaudi: remove axi drain support
      habanalabs/gaudi: fix DMA completions max outstanding to 15
      habanalabs: add indication of security-enabled F/W
      habanalabs: update scratchpad register map
      habanalabs: correct an error message
      habanalabs: release kernel context after hw_fini
      habanalabs: add debug messages for opening/closing context
      habanalabs: add notice of device not idle
      habanalabs/gaudi: use correct define for qman init

Ofir Bitton (6):
      habanalabs: Replace dma-fence mechanism with completions
      habanalabs: add information about PCIe controller
      habanalabs: expose sync manager resources allocation in INFO IOCTL
      habanalabs: PCIe Advanced Error Reporting support
      habanalabs: Fix alignment issue in cpucp_info structure
      habanalabs/gaudi: configure QMAN LDMA registers properly

Omer Shpigelman (1):
      habanalabs: use smallest possible alignment for virtual addresses

Pierre-Louis Bossart (39):
      soundwire: intel: Add basic power management support
      soundwire: intel: add pm_runtime support
      soundwire: intel: reset pm_runtime status during system resume
      soundwire: intel: fix race condition on system resume
      soundwire: intel: call helper to reset Slave states on resume
      soundwire: intel: pm_runtime idle scheduling
      soundwire: intel: add CLK_STOP_TEARDOWN for pm_runtime suspend
      soundwire: intel: add CLK_STOP_NOT_ALLOWED support
      soundwire: intel_init: handle power rail dependencies for clock stop mode
      soundwire: intel: support clock_stop mode without quirks
      ASoC: codecs: soundwire: remove port_ready[] usage from codecs.
      soundwire: add definition for maximum number of ports
      soundwire: fix port_ready[] dynamic allocation in mipi_disco
      soundwire: intel: disable shim wake on suspend
      soundwire: intel: ignore software command retries
      soundwire: intel: add multi-link support
      soundwire: intel: add missing support for all clock stop modes
      soundwire: bus: update multi-link definition with hw sync details
      soundwire: intel: add multi-link hw_synchronization information
      soundwire: stream: enable hw_sync as needed by hardware
      soundwire: intel: add error log for clock-stop invalid configs
      soundwire: intel: pass link_mask information to each master
      soundwire: intel: don't manage link power individually
      soundwire: stream: fix NULL/IS_ERR confusion
      soundwire: intel: fix NULL/ERR_PTR confusion
      soundwire: intel: remove .trigger operation
      soundwire: intel: remove stream handling from .prepare and .hw_free
      soundwire: cadence: fix race condition between suspend and Slave device alerts
      ASoC/soundwire: bus: use property to set interrupt masks
      soundwire: bus: filter-out unwanted interrupt reports
      soundwire: slave: add first_interrupt_done status
      soundwire: bus: use quirk to filter out invalid parity errors
      ASoC: codecs: realtek-soundwire: ignore initial PARITY errors
      soundwire: bus: export broadcast read/write capability for tests
      soundwire: cadence: add parity error injection through debugfs
      soundwire: enable Data Port test modes
      soundwire: intel: enable test modes
      soundwire: cadence: add data port test fail interrupt
      soundwire: sysfs: add slave status and device number before probe

Qi Liu (1):
      coresight: etm4x: Add Support for HiSilicon ETM device

Qinglang Miao (2):
      ocxl: simplify the return expression of free_function_dev()
      virt: vbox: simplify the return expression of vbg_input_open()

Ramuthevar Vadivel Murugan (2):
      extcon: ptn5150: Switch to GENMASK() and BIT() macros
      extcon: ptn5150: Set the VBUS and POLARITY property capability

Rander Wang (2):
      soundwire: intel: add CLK_STOP_BUS_RESET support
      soundwire: intel: refine runtime pm for SDW_INTEL_CLK_STOP_BUS_RESET

Randy Dunlap (1):
      bus: mhi: fix doubled words and struct image_info kernel-doc

Richard Gong (1):
      fpga: stratix10-soc: make FPGA task un-interruptible

Ricky Wu (3):
      misc: rtsx: do not setting OC_POWER_DOWN reg in rtsx_pci_init_ocp()
      misc: rtsx: Fix power down flow
      misc: rtsx: Add power saving functions and fix driving parameter

Rikard Falkeborn (6):
      fsi: master: Constify hub_master_ids
      fsi: sbefifo: Constify sbefifo_ids
      fsi: scom: Constify scom_ids
      w1: Constify struct w1_family_ops
      w1: Constify static w1_family_ops structs
      power: supply: Constify static w1_family_ops structs

Sai Prakash Ranjan (2):
      coresight: etm4x: Fix etm4_count race by moving cpuhp callbacks to init
      coresight: etm4x: Fix save and restore of TRCVMIDCCTLR1 register

Scott Branden (4):
      fs/kernel_read_file: Split into separate include file
      IMA: Add support for file reads without contents
      firmware: Add request_partial_firmware_into_buf()
      test_firmware: Test partial read support

Sebastian Fricke (1):
      include/linux/miscdevice.h - Fix typo/grammar

Sherry Sun (5):
      samples: mpssd: fix the build errors when enable DEBUG in mpssd.c
      misc: vop: set VIRTIO_F_ACCESS_PLATFORM for vop driver
      misc: vop: build VOP based on CONFIG_VOP
      misc: vop: add round_up(x,4) for vring_size to avoid kernel panic
      mic: vop: copy data to kernel space then write to io memory

Sibi Sankar (6):
      interconnect: qcom: sc7180: Replace xlate with xlate_extended
      dt-bindings: interconnect: Add OSM L3 DT binding on SM8150
      interconnect: qcom: Add OSM L3 support on SM8150
      interconnect: qcom: Lay the groundwork for adding EPSS support
      dt-bindings: interconnect: Add EPSS L3 DT binding on SM8250
      interconnect: qcom: Add EPSS L3 support on SM8250

Souptick Joarder (2):
      drivers/virt/fsl_hypervisor: Fix error handling path
      misc: mic: scif: Fix error handling path

Srinivas Kandagatla (7):
      soundwire: qcom: clear BIT FIELDs before value set.
      soundwire: qcom: add support to block packing mode
      soundwire: qcom: get max rows and cols info from compatible
      slimbus: core: check get_addr before removing laddr ida
      slimbus: core: do not enter to clock pause mode in core
      slimbus: qcom-ngd-ctrl: disable ngd in qmi server down callback
      soundwire: bus: add enumerated Slave device to device list

Stephen Boyd (1):
      interconnect: qcom: osm-l3: Mark more structures const

Suzuki K Poulose (1):
      coresight: etm4x: Handle unreachable sink in perf mode

Tian Tao (2):
      uacce: Use kobj_to_dev() instead of container_of()
      nvmem: core: Use kobj_to_dev() instead of container_of()

Tingwei Zhang (22):
      coresight: stm: Support marked packet
      coresight: cti: disclaim device only when it's claimed
      coresight: cti: remove pm_runtime_get_sync() from CPU hotplug
      coresight: cti: Write regsiters directly in cti_enable_hw()
      coresight: cpu_debug: Add module name in Kconfig
      coresight: cpu_debug: Define MODULE_DEVICE_TABLE
      coresight: Add coresight prefix to barrier_pkt
      coresight: Add try_get_module() in coresight_grab_device()
      coresight: stm: Allow to build coresight-stm as a module
      coresight: etm: perf: Fix warning caused by etm_setup_aux failure
      coresight: cti: Add function to register cti associate ops
      coresight: cti: Don't disable ect device if it's not enabled
      coresight: cti: Increase reference count when enabling cti
      coresight: cti: Allow cti to be built as a module
      coresight: catu: Allow catu drivers to be built as modules
      coresight: core: Allow the coresight core driver to be built as a module
      stm class: ftrace: Change dependency to TRACING
      tracing: Add flag to control different traces
      tracing: Add trace_export support for event trace
      tracing: Add trace_export support for trace_marker
      stm class: ftrace: Enable supported trace export flag
      stm class: ftrace: Use different channel accroding to CPU

Todd Kjos (1):
      binder: fix UAF when releasing todo list

Tom Rix (1):
      MAINTAINERS: Add Tom Rix as fpga reviewer

Tomas Winkler (3):
      mei: add support for mei extended header.
      mei: docs: add vtag ioctl documentation
      mei: virtio: virtualization frontend driver

Tomer Tayar (3):
      habanalabs: Include linux/bitfield.h only in habanalabs.h
      habanalabs: Save context in a command buffer object
      habanalabs: Add an option to map CB to device MMU

Vadym Kochan (4):
      eeprom: at25: set type id as EEPROM
      eeprom: 93xx46: set type id as EEPROM
      nvmem: core: fix missing of_node_put() in of_nvmem_device_get()
      nvmem: core: fix possibly memleak when use nvmem_cell_info_to_nvmem_cell()

Vinod Koul (11):
      soundwire: define and use addr bit masks
      soundwire: bus: use FIELD_GET()
      soundwire: slave: use SDW_DISCO_LINK_ID()
      soundwire: stream: use FIELD_{GET|PREP}
      soundwire: qcom : use FIELD_{GET|PREP}
      soundwire: cadence: use FIELD_{GET|PREP}
      soundwire: intel: use FIELD_{GET|PREP}
      soundwire: intel_init: use FIELD_{GET|PREP}
      soundwire: remove SDW_REG_SHIFT()
      soundwire: cadence: use u32p_replace_bits
      soundwire: intel: use {u32|u16}p_replace_bits

Wang Qing (1):
      drivers/greybus: Use kobj_to_dev()

Wang ShaoBo (1):
      misc: pvpanic: Use devm_platform_ioremap_resource()

Wei Yongjun (1):
      binderfs: make symbol 'binderfs_fs_parameters' static

Xu Wang (1):
      fsi: fsi-occ: fix return value check in occ_probe()

Xu Yilun (3):
      fpga: dfl: change data type of feature id to u16
      fpga: dfl: map feature mmio resources in their own feature drivers
      fpga: dfl: create a dfl bus type to support DFL devices

YangHui (1):
      binder: Modify comments

Yu Chen (1):
      misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on Hikey960

farah kassabri (3):
      habanalabs: remove security from ARB_MST_QUIET register
      habanalabs: extend busy engines mask to 64 bits
      habanalabs: add support for getting device total energy

 Documentation/ABI/stable/sysfs-bus-mhi             |    21 +
 Documentation/ABI/testing/sysfs-bus-dfl            |    15 +
 Documentation/ABI/testing/sysfs-bus-fsi            |     8 +
 Documentation/ABI/testing/sysfs-bus-mei            |     7 +
 .../ABI/testing/sysfs-bus-soundwire-slave          |    18 +
 Documentation/ABI/testing/sysfs-driver-habanalabs  |    18 +-
 Documentation/ABI/testing/sysfs-driver-w1_therm    |    51 +-
 .../devicetree/bindings/extcon/extcon-ptn5150.txt  |    27 -
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml |    60 +
 .../devicetree/bindings/fsi/fsi-master-aspeed.txt  |    12 +
 .../bindings/interconnect/interconnect.txt         |    24 +-
 .../bindings/interconnect/qcom,bcm-voter.yaml      |    20 +
 .../bindings/interconnect/qcom,osm-l3.yaml         |     2 +
 .../{qcom,sdm845.yaml => qcom,rpmh.yaml}           |    42 +-
 .../bindings/interconnect/qcom,sc7180.yaml         |    85 -
 .../devicetree/bindings/soundwire/qcom,sdw.txt     |     1 +
 Documentation/driver-api/mei/mei.rst               |    37 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |     5 +-
 Documentation/virt/index.rst                       |     1 +
 Documentation/virt/ne_overview.rst                 |    95 +
 Documentation/w1/slaves/w1_therm.rst               |   101 +-
 MAINTAINERS                                        |    37 +
 drivers/android/binder.c                           |    57 +-
 drivers/android/binder_alloc.c                     |    57 +-
 drivers/android/binder_alloc.h                     |     5 +-
 drivers/android/binder_alloc_selftest.c            |     2 +-
 drivers/android/binderfs.c                         |     2 +-
 drivers/base/firmware_loader/fallback.c            |    21 +-
 drivers/base/firmware_loader/fallback.h            |     5 +-
 drivers/base/firmware_loader/fallback_platform.c   |    12 +-
 drivers/base/firmware_loader/firmware.h            |     7 +-
 drivers/base/firmware_loader/main.c                |   135 +-
 drivers/bus/fsl-mc/dprc-driver.c                   |   190 +-
 drivers/bus/fsl-mc/dprc.c                          |   141 +-
 drivers/bus/fsl-mc/fsl-mc-allocator.c              |    12 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |    75 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |    31 +-
 drivers/bus/fsl-mc/mc-io.c                         |     7 +-
 drivers/bus/mhi/Kconfig                            |    20 +-
 drivers/bus/mhi/core/Makefile                      |     3 +-
 drivers/bus/mhi/core/boot.c                        |    17 +-
 drivers/bus/mhi/core/debugfs.c                     |   411 +
 drivers/bus/mhi/core/init.c                        |    87 +-
 drivers/bus/mhi/core/internal.h                    |    37 +-
 drivers/bus/mhi/core/main.c                        |    27 +-
 drivers/bus/mhi/core/pm.c                          |    28 +-
 drivers/char/Kconfig                               |     3 +-
 drivers/char/lp.c                                  |     6 +-
 drivers/char/mem.c                                 |    28 +
 drivers/char/mspec.c                               |     5 +-
 drivers/extcon/extcon-axp288.c                     |    13 +-
 drivers/extcon/extcon-max14577.c                   |     2 +-
 drivers/extcon/extcon-max77693.c                   |     2 +-
 drivers/extcon/extcon-max77843.c                   |     2 +-
 drivers/extcon/extcon-max8997.c                    |     2 +-
 drivers/extcon/extcon-palmas.c                     |    20 +-
 drivers/extcon/extcon-ptn5150.c                    |   226 +-
 drivers/extcon/extcon-usb-gpio.c                   |     2 +-
 drivers/fpga/dfl-fme-perf.c                        |     2 +-
 drivers/fpga/dfl-pci.c                             |    24 +-
 drivers/fpga/dfl.c                                 |   477 +-
 drivers/fpga/dfl.h                                 |   103 +-
 drivers/fpga/fpga-region.c                         |     2 +-
 drivers/fpga/stratix10-soc.c                       |    23 +-
 drivers/fpga/xilinx-spi.c                          |    77 +-
 drivers/fsi/fsi-core.c                             |    31 +-
 drivers/fsi/fsi-master-aspeed.c                    |   134 +-
 drivers/fsi/fsi-master-ast-cf.c                    |     7 +-
 drivers/fsi/fsi-master-gpio.c                      |     5 +-
 drivers/fsi/fsi-master-hub.c                       |    15 +-
 drivers/fsi/fsi-master.h                           |     3 +-
 drivers/fsi/fsi-occ.c                              |     2 +-
 drivers/fsi/fsi-sbefifo.c                          |     2 +-
 drivers/fsi/fsi-scom.c                             |     2 +-
 drivers/greybus/interface.c                        |     6 +-
 drivers/hwtracing/coresight/Kconfig                |    54 +-
 drivers/hwtracing/coresight/Makefile               |    26 +-
 drivers/hwtracing/coresight/coresight-catu.c       |    37 +-
 drivers/hwtracing/coresight/coresight-catu.h       |     2 -
 .../coresight/{coresight.c => coresight-core.c}    |   216 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |     2 +
 .../{coresight-cti.c => coresight-cti-core.c}      |    97 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |    28 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    25 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |     5 +-
 .../{coresight-etm3x.c => coresight-etm3x-core.c}  |   154 +-
 .../{coresight-etm4x.c => coresight-etm4x-core.c}  |   193 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |    11 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |     6 +
 drivers/hwtracing/coresight/coresight-funnel.c     |    65 +-
 drivers/hwtracing/coresight/coresight-platform.c   |    11 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    26 +-
 drivers/hwtracing/coresight/coresight-replicator.c |    65 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    31 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |     2 +
 .../{coresight-tmc.c => coresight-tmc-core.c}      |    25 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |     2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |    21 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |     3 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |    20 +-
 drivers/hwtracing/intel_th/pci.c                   |    10 +
 drivers/hwtracing/stm/Kconfig                      |     2 +-
 drivers/hwtracing/stm/ftrace.c                     |     7 +-
 drivers/interconnect/Makefile                      |     2 +-
 drivers/interconnect/bulk.c                        |   117 +
 drivers/interconnect/core.c                        |   140 +-
 drivers/interconnect/imx/imx.c                     |    13 +-
 drivers/interconnect/qcom/Kconfig                  |    20 +
 drivers/interconnect/qcom/Makefile                 |     4 +
 drivers/interconnect/qcom/bcm-voter.c              |    36 +-
 drivers/interconnect/qcom/icc-rpmh.c               |    30 +
 drivers/interconnect/qcom/icc-rpmh.h               |    21 +-
 drivers/interconnect/qcom/osm-l3.c                 |    91 +-
 drivers/interconnect/qcom/sc7180.c                 |     3 +-
 drivers/interconnect/qcom/sdm845.c                 |     3 +-
 drivers/interconnect/qcom/sm8150.c                 |   635 +
 drivers/interconnect/qcom/sm8150.h                 |   154 +
 drivers/interconnect/qcom/sm8250.c                 |   651 +
 drivers/interconnect/qcom/sm8250.h                 |   164 +
 drivers/misc/Kconfig                               |    10 +
 drivers/misc/Makefile                              |     1 +
 drivers/misc/cardreader/rts5227.c                  |   117 +-
 drivers/misc/cardreader/rts5228.c                  |     5 +-
 drivers/misc/cardreader/rts5249.c                  |   162 +-
 drivers/misc/cardreader/rts5260.c                  |    44 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |    24 +-
 drivers/misc/cardreader/rtsx_pcr.h                 |    17 +
 drivers/misc/eeprom/at25.c                         |     5 +-
 drivers/misc/eeprom/ee1004.c                       |    13 +-
 drivers/misc/eeprom/eeprom_93xx46.c                |     1 +
 drivers/misc/fastrpc.c                             |    20 +-
 drivers/misc/habanalabs/Kconfig                    |     1 -
 drivers/misc/habanalabs/common/Makefile            |     4 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   229 +-
 .../misc/habanalabs/common/command_submission.c    |   107 +-
 drivers/misc/habanalabs/common/context.c           |    38 +-
 drivers/misc/habanalabs/common/debugfs.c           |    92 +-
 drivers/misc/habanalabs/common/device.c            |    31 +-
 drivers/misc/habanalabs/common/firmware_if.c       |   229 +-
 drivers/misc/habanalabs/common/habanalabs.h        |   200 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |    76 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   105 +-
 drivers/misc/habanalabs/common/hw_queue.c          |    10 +-
 drivers/misc/habanalabs/common/hwmon.c             |    60 +-
 drivers/misc/habanalabs/common/irq.c               |     2 +-
 drivers/misc/habanalabs/common/memory.c            |    90 +-
 drivers/misc/habanalabs/common/mmu.c               |   812 +-
 drivers/misc/habanalabs/common/mmu_v1.c            |   863 ++
 drivers/misc/habanalabs/common/pci.c               |    17 +-
 drivers/misc/habanalabs/common/sysfs.c             |    60 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |   254 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    60 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 12351 +++++++++----------
 drivers/misc/habanalabs/goya/goya.c                |    89 +-
 drivers/misc/habanalabs/goya/goyaP.h               |     2 +-
 .../include/common/{armcp_if.h => cpucp_if.h}      |   298 +-
 drivers/misc/habanalabs/include/common/qman_if.h   |     2 +-
 drivers/misc/habanalabs/include/gaudi/gaudi.h      |     2 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   273 +-
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |     1 +
 .../misc/habanalabs/include/goya/goya_reg_map.h    |     1 +
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |     2 +
 drivers/misc/hisi_hikey_usb.c                      |   273 +
 drivers/misc/mei/Kconfig                           |    10 +
 drivers/misc/mei/Makefile                          |     3 +
 drivers/misc/mei/bus-fixup.c                       |    12 +
 drivers/misc/mei/bus.c                             |    89 +-
 drivers/misc/mei/client.c                          |   423 +-
 drivers/misc/mei/client.h                          |    22 +-
 drivers/misc/mei/debugfs.c                         |     9 +-
 drivers/misc/mei/hbm.c                             |   101 +-
 drivers/misc/mei/hbm.h                             |     2 +
 drivers/misc/mei/hw-virtio.c                       |   874 ++
 drivers/misc/mei/hw.h                              |   150 +-
 drivers/misc/mei/interrupt.c                       |   113 +-
 drivers/misc/mei/main.c                            |   284 +-
 drivers/misc/mei/mei_dev.h                         |    34 +-
 drivers/misc/mic/scif/scif_nodeqp.c                |     2 +-
 drivers/misc/mic/scif/scif_rma.c                   |     4 +-
 drivers/misc/mic/vop/Makefile                      |     2 +-
 drivers/misc/mic/vop/vop_main.c                    |     3 +-
 drivers/misc/mic/vop/vop_vringh.c                  |    24 +-
 drivers/misc/ocxl/Kconfig                          |     3 +-
 drivers/misc/ocxl/core.c                           |     7 +-
 drivers/misc/pvpanic.c                             |     8 +-
 drivers/misc/uacce/uacce.c                         |     2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |    10 +-
 drivers/nvmem/core.c                               |    50 +-
 drivers/nvmem/mtk-efuse.c                          |    14 -
 drivers/power/supply/bq27xxx_battery_hdq.c         |     2 +-
 drivers/power/supply/ds2760_battery.c              |     2 +-
 drivers/power/supply/max1721x_battery.c            |     2 +-
 drivers/slimbus/core.c                             |     6 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |     4 +
 drivers/soundwire/Kconfig                          |     7 +-
 drivers/soundwire/Makefile                         |     3 +
 drivers/soundwire/bus.c                            |   120 +-
 drivers/soundwire/bus.h                            |    52 +-
 drivers/soundwire/bus_type.c                       |     9 +
 drivers/soundwire/cadence_master.c                 |   199 +-
 drivers/soundwire/cadence_master.h                 |     5 +
 drivers/soundwire/generic_bandwidth_allocation.c   |   425 +
 drivers/soundwire/intel.c                          |   803 +-
 drivers/soundwire/intel.h                          |     4 +
 drivers/soundwire/intel_init.c                     |    22 +-
 drivers/soundwire/master.c                         |     2 +
 drivers/soundwire/mipi_disco.c                     |    18 +-
 drivers/soundwire/qcom.c                           |   118 +-
 drivers/soundwire/slave.c                          |    13 +-
 drivers/soundwire/stream.c                         |    45 +-
 drivers/soundwire/sysfs_local.h                    |     4 +
 drivers/soundwire/sysfs_slave.c                    |    58 +-
 drivers/uio/uio.c                                  |     4 +-
 drivers/virt/Kconfig                               |     2 +
 drivers/virt/Makefile                              |     2 +
 drivers/virt/fsl_hypervisor.c                      |    17 +-
 drivers/virt/nitro_enclaves/Kconfig                |    20 +
 drivers/virt/nitro_enclaves/Makefile               |     9 +
 drivers/virt/nitro_enclaves/ne_misc_dev.c          |  1733 +++
 drivers/virt/nitro_enclaves/ne_misc_dev.h          |   109 +
 drivers/virt/nitro_enclaves/ne_pci_dev.c           |   625 +
 drivers/virt/nitro_enclaves/ne_pci_dev.h           |   327 +
 drivers/virt/vboxguest/vboxguest_linux.c           |     9 +-
 drivers/w1/masters/mxc_w1.c                        |    14 +-
 drivers/w1/slaves/w1_ds2405.c                      |     2 +-
 drivers/w1/slaves/w1_ds2406.c                      |     2 +-
 drivers/w1/slaves/w1_ds2408.c                      |     2 +-
 drivers/w1/slaves/w1_ds2413.c                      |     2 +-
 drivers/w1/slaves/w1_ds2423.c                      |     2 +-
 drivers/w1/slaves/w1_ds2430.c                      |     2 +-
 drivers/w1/slaves/w1_ds2431.c                      |     2 +-
 drivers/w1/slaves/w1_ds2433.c                      |     2 +-
 drivers/w1/slaves/w1_ds2438.c                      |     2 +-
 drivers/w1/slaves/w1_ds250x.c                      |     2 +-
 drivers/w1/slaves/w1_ds2780.c                      |     2 +-
 drivers/w1/slaves/w1_ds2781.c                      |     2 +-
 drivers/w1/slaves/w1_ds2805.c                      |     2 +-
 drivers/w1/slaves/w1_ds28e04.c                     |     2 +-
 drivers/w1/slaves/w1_ds28e17.c                     |     2 +-
 drivers/w1/slaves/w1_therm.c                       |   459 +-
 drivers/w1/w1.c                                    |     4 +-
 fs/Makefile                                        |     3 +-
 fs/exec.c                                          |   132 +-
 fs/kernel_read_file.c                              |   189 +
 include/dt-bindings/interconnect/qcom,icc.h        |    26 +
 include/dt-bindings/interconnect/qcom,osm-l3.h     |     3 +
 include/dt-bindings/interconnect/qcom,sm8150.h     |   162 +
 include/dt-bindings/interconnect/qcom,sm8250.h     |   172 +
 include/linux/coresight.h                          |     3 +-
 include/linux/firmware.h                           |    12 +
 include/linux/fs.h                                 |    39 -
 include/linux/fsl/mc.h                             |    41 +-
 include/linux/ima.h                                |    20 +-
 include/linux/interconnect-provider.h              |    24 +-
 include/linux/interconnect.h                       |    22 +
 include/linux/kernel_read_file.h                   |    55 +
 include/linux/lsm_hook_defs.h                      |     6 +-
 include/linux/lsm_hooks.h                          |    13 +
 include/linux/mhi.h                                |    51 +-
 include/linux/miscdevice.h                         |    10 +-
 include/linux/nitro_enclaves.h                     |    11 +
 include/linux/security.h                           |    21 +-
 include/linux/soundwire/sdw.h                      |    48 +-
 include/linux/soundwire/sdw_registers.h            |     7 -
 include/linux/spi/eeprom.h                         |     2 +-
 include/linux/trace.h                              |     7 +
 include/linux/w1.h                                 |     2 +-
 include/uapi/linux/coresight-stm.h                 |     1 +
 include/uapi/linux/mei.h                           |    49 +
 include/uapi/linux/nitro_enclaves.h                |   359 +
 include/uapi/misc/fastrpc.h                        |     5 +-
 include/uapi/misc/habanalabs.h                     |    87 +-
 kernel/kexec.c                                     |     2 +-
 kernel/kexec_file.c                                |    19 +-
 kernel/module.c                                    |    24 +-
 kernel/trace/trace.c                               |   270 +-
 lib/test_firmware.c                                |   154 +-
 samples/mic/mpssd/mpssd.c                          |    24 +-
 samples/nitro_enclaves/.gitignore                  |     2 +
 samples/nitro_enclaves/Makefile                    |    16 +
 samples/nitro_enclaves/ne_ioctl_sample.c           |   883 ++
 security/integrity/digsig.c                        |     8 +-
 security/integrity/ima/ima_fs.c                    |    10 +-
 security/integrity/ima/ima_main.c                  |    73 +-
 security/integrity/ima/ima_policy.c                |     1 +
 security/loadpin/loadpin.c                         |    17 +-
 security/security.c                                |    28 +-
 security/selinux/hooks.c                           |     8 +-
 sound/soc/codecs/max98373-sdw.c                    |    18 +-
 sound/soc/codecs/rt1308-sdw.c                      |    17 +-
 sound/soc/codecs/rt5682-sdw.c                      |    20 +-
 sound/soc/codecs/rt700-sdw.c                       |    20 +-
 sound/soc/codecs/rt711-sdw.c                       |    20 +-
 sound/soc/codecs/rt715-sdw.c                       |    38 +-
 sound/soc/codecs/wsa881x.c                         |     1 +
 tools/testing/selftests/firmware/fw_filesystem.sh  |    91 +
 tools/testing/selftests/lkdtm/run.sh               |     2 +-
 297 files changed, 24461 insertions(+), 10014 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm845.yaml => qcom,rpmh.yaml} (60%)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 create mode 100644 Documentation/virt/ne_overview.rst
 create mode 100644 drivers/bus/mhi/core/debugfs.c
 rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (90%)
 rename drivers/hwtracing/coresight/{coresight-cti.c => coresight-cti-core.c} (93%)
 rename drivers/hwtracing/coresight/{coresight-etm3x.c => coresight-etm3x-core.c} (90%)
 rename drivers/hwtracing/coresight/{coresight-etm4x.c => coresight-etm4x-core.c} (92%)
 rename drivers/hwtracing/coresight/{coresight-tmc.c => coresight-tmc-core.c} (95%)
 create mode 100644 drivers/interconnect/bulk.c
 create mode 100644 drivers/interconnect/qcom/sm8150.c
 create mode 100644 drivers/interconnect/qcom/sm8150.h
 create mode 100644 drivers/interconnect/qcom/sm8250.c
 create mode 100644 drivers/interconnect/qcom/sm8250.h
 create mode 100644 drivers/misc/habanalabs/common/mmu_v1.c
 rename drivers/misc/habanalabs/include/common/{armcp_if.h => cpucp_if.h} (60%)
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/misc/mei/hw-virtio.c
 create mode 100644 drivers/soundwire/generic_bandwidth_allocation.c
 create mode 100644 drivers/virt/nitro_enclaves/Kconfig
 create mode 100644 drivers/virt/nitro_enclaves/Makefile
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_dev.c
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_dev.h
 create mode 100644 drivers/virt/nitro_enclaves/ne_pci_dev.c
 create mode 100644 drivers/virt/nitro_enclaves/ne_pci_dev.h
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/dt-bindings/interconnect/qcom,icc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h
 create mode 100644 include/linux/kernel_read_file.h
 create mode 100644 include/linux/nitro_enclaves.h
 create mode 100644 include/uapi/linux/nitro_enclaves.h
 create mode 100644 samples/nitro_enclaves/.gitignore
 create mode 100644 samples/nitro_enclaves/Makefile
 create mode 100644 samples/nitro_enclaves/ne_ioctl_sample.c
