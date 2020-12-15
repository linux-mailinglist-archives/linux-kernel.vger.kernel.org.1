Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F350F2DAAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgLOKQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgLOKQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:16:39 -0500
Date:   Tue, 15 Dec 2020 11:17:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608027357;
        bh=2miM2pQ31OPfk1UwcZA/rQi1fJ61IA238xULLgQCiPc=;
        h=From:To:Cc:Subject:From;
        b=KVbInHTq8wA5MU+vfU39USbkOcGEbx3ZPK0FQ19OHRhhPj0ydA8DWXQu36ygR4xlX
         Ryg7YxILcu0dORTjxTdQsKHlksV+tcoFRc4OBFlBQfw02ATY51dD+GBiU+KFLhljGW
         aM7nfOD2VWYxzvJjlCbvEI3xGANERUqOuX9NUDqo=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver changes for 5.11-rc1
Message-ID: <X9iNHGpdcl3cAlo4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc1

for you to fetch changes up to a256e24021bf7ceedd29fe65eb45c7adfffffad2:

  usb: phy: convert comma to semicolon (2020-12-11 16:51:20 +0100)

----------------------------------------------------------------
USB / Thunderbolt patches for 5.11-rc1

Here is the big USB and thunderbolt pull request for 5.11-rc1.

Nothing major in here, just the grind of constant development to support
new hardware and fix old issues:
  - thunderbolt updates for new USB4 hardware
  - cdns3 major driver updates
  - lots of typec updates and additions as more hardware is available
  - usb serial driver updates and fixes
  - other tiny USB driver updates

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmed S. Darwish (7):
      USB: serial: digi_acceleport: remove in_interrupt() usage
      usb: hosts: Remove in_interrupt() from comments
      usb: gadget: udc: Remove in_interrupt()/in_irq() from comments
      usb: core: Replace in_interrupt() in comments
      usb: gadget: pxa27x_udc: Replace in_interrupt() usage in comments
      usbip: Remove in_interrupt() check
      usb: xhci: Remove in_interrupt() checks

Al Cooper (2):
      dt-bindings: Add support for Broadcom USB pin map driver
      usb: Add driver to allow any GPIO to be used for 7211 USB signals

Alan Stern (1):
      USB: legotower: fix logical error in recent commit

Andrey Konovalov (1):
      kcov, usb: only collect coverage from __usb_hcd_giveback_urb in softirq

Aswath Govindraju (1):
      MAINTAINERS: Add myself as a reviewer for CADENCE USB3 DRD IP DRIVER

Badhri Jagan Sridharan (21):
      dt-bindings: connector: Add property to set initial current cap for FRS
      usb: typec: tcpm: Refactor logic for new-source-frs-typec-current
      usb: typec: tcpm: frs sourcing vbus callback
      usb: typec: tcpci: frs sourcing vbus callback
      usb: typec: tcpci_maxim: Fix vbus stuck on upon diconnecting sink
      usb: typec: tcpm: Implement enabling Auto Discharge disconnect support
      usb: typec: tcpci: Implement Auto discharge disconnect callbacks
      usb: typec: tcpci_maxim: Enable auto discharge disconnect
      usb: typec: tcpci_maxim: Fix uninitialized return variable
      dt-bindings: usb: Maxim type-c controller device tree binding document
      usb: typec: tcpci_maxim: Fix the compatible string
      usb: typec: tcpm: Disregard vbus off while in PR_SWAP_SNK_SRC_SOURCE_ON
      usb: typec: tcpm: Stay in SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS till Rp is seen
      usb: typec: tcpm: Pass down negotiated rev to update retry count
      usb: typec: tcpm: Clear send_discover in tcpm_check_send_discover
      usb: typec: tcpm: Introduce vsafe0v for vbus
      usb: typec: tcpci: Add support to report vSafe0V
      usb: typec: tcpci_maxim: Enable VSAFE0V signalling
      USB: typec: tcpci: Add Bleed discharge to POWER_CONTROL definition
      usb: typec: tcpci: Enable bleed discharge when auto discharge is enabled
      usb: typec: tcpm: Update vbus_vsafe0v on init

Benjamin Berg (2):
      usb: typec: ucsi: acpi: Always decode connector change information
      usb: typec: ucsi: Work around PPM losing change information

Bui Quang Minh (1):
      USB: dummy-hcd: Fix uninitialized array use in init()

Colin Ian King (1):
      usb: phy: Fix spelling mistake in Kconfig help text

Dan Carpenter (4):
      usb: misc: brcmstb-usb-pinmap: Fix an IS_ERR() vs NULL check
      USB: apple-mfi-fastcharge: Fix use after free in probe
      usb: mtu3: mtu3_debug: remove an unused struct member
      usb: mtu3: fix memory corruption in mtu3_debugfs_regset()

Davidlohr Bueso (1):
      USB: serial: mos7720: defer state restore to a workqueue

Enrico Weigelt, metux IT consult (3):
      drivers: usb: atm: reduce noise
      drivers: usb: atm: use atm_info() instead of atm_printk(KERN_INFO ...
      drivers: usb: atm: use pr_err() and pr_warn() instead of raw printk()

Fabio Estevam (5):
      usb: host: imx21-hcd: Remove the driver
      usb: host: ehci-mxc: Remove the driver
      usb: chipidea: ci_hdrc_imx: Pass DISABLE_DEVICE_STREAMING flag to imx6ul
      usb: chipidea: usbmisc_imx: Use of_device_get_match_data()
      usb: chipidea: ci_hdrc_imx: Use of_device_get_match_data()

Greg Kroah-Hartman (10):
      USB: host: isp1362: delete isp1362_show_regs()
      Merge 5.10-rc2 into usb-next
      Merge 5.10-rc3 into usb-next
      Merge 5.10-rc4 into here.
      Merge 5.10-rc6 into usb-next
      Merge 5.10-rc7 into usb-next
      Merge tag 'thunderbolt-for-v5.11-rc1' of git://git.kernel.org/.../westeri/thunderbolt into usb-next
      Merge tag 'usb-v5.11-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next
      USB: gadget: f_fs: remove likely/unlikely
      Merge tag 'usb-serial-5.11-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next

Guido Günther (2):
      usb: typec: tps6598x: Select USB_ROLE_SWITCH and REGMAP_I2C
      usb: typec: tps6598x: Export some power supply properties

Gustavo A. R. Silva (1):
      usb: Fix fall-through warnings for Clang

Hans de Goede (1):
      xhci-pci: Allow host runtime PM as default for Intel Alpine Ridge LP

Heikki Krogerus (2):
      usb: pd: DFP product types
      usb: typec: Add type sysfs attribute file for partners

Isaac Hazan (4):
      thunderbolt: Add link_speed and link_width to XDomain
      thunderbolt: Add functions for enabling and disabling lane bonding on XDomain
      thunderbolt: Add DMA traffic test driver
      MAINTAINERS: Add Isaac as maintainer of Thunderbolt DMA traffic test driver

Jack Pham (1):
      usb: gadget: f_fs: Re-use SS descriptors for SuperSpeedPlus

Johan Hovold (27):
      USB: serial: keyspan_pda: fix dropped unthrottle interrupts
      USB: serial: keyspan_pda: fix write deadlock
      USB: serial: keyspan_pda: fix stalled writes
      USB: serial: keyspan_pda: fix write-wakeup use-after-free
      USB: serial: keyspan_pda: fix tx-unthrottle use-after-free
      USB: serial: keyspan_pda: fix write unthrottling
      USB: serial: keyspan_pda: refactor write-room handling
      USB: serial: keyspan_pda: fix write implementation
      USB: serial: keyspan_pda: increase transmitter threshold
      USB: serial: keyspan_pda: add write-fifo support
      USB: serial: keyspan_pda: clean up xircom/entrega support
      USB: serial: keyspan_pda: clean up comments and whitespace
      USB: serial: keyspan_pda: use BIT() macro
      USB: serial: keyspan_pda: drop redundant usb-serial pointer
      USB: serial: digi_acceleport: fix write-wakeup deadlocks
      USB: serial: remove write wait queue
      USB: serial: mos7720: fix parallel-port state restore
      USB: serial: cp210x: return early on unchanged termios
      USB: serial: cp210x: clean up line-control handling
      USB: serial: cp210x: set terminal settings on open
      USB: serial: cp210x: drop flow-control debugging
      USB: serial: cp210x: refactor flow-control handling
      USB: serial: cp210x: clean up dtr_rts()
      USB: core: drop short-transfer check from usb_control_msg_send()
      USB: core: return -EREMOTEIO on short usb_control_msg_recv()
      USB: core: drop pipe-type check from new control-message helpers
      USB: serial: option: add interface-number sanity check to flag handling

Kyle Tso (2):
      USB: typec: tcpm: Fix PR_SWAP error handling
      USB: typec: tcpm: Add a 30ms room for tPSSourceOn in PR_SWAP

Li Jun (1):
      xhci: Give USB2 ports time to enter U3 in bus suspend

Linus Walleij (1):
      usb: isp1301-omap: Convert to use GPIO descriptors

Lucas Tanure (1):
      USB: apple-mfi-fastcharge: Fix kfree after failed kzalloc

Lukas Bulwahn (1):
      USB: storage: avoid use of uninitialized values in error path

Marc Zyngier (3):
      USB: serial: ftdi_sio: report the valid GPIO lines to gpiolib
      USB: serial: ftdi_sio: drop GPIO line checking dead code
      USB: serial: ftdi_sio: log the CBUS GPIO validity

Mika Westerberg (19):
      thunderbolt: Do not clear USB4 router protocol adapter IFC and ISE bits
      thunderbolt: Find XDomain by route instead of UUID
      thunderbolt: Create XDomain devices for loops back to the host
      thunderbolt: Create debugfs directory automatically for services
      thunderbolt: Make it possible to allocate one directional DMA tunnel
      thunderbolt: Add support for end-to-end flow control
      thunderbolt: Move max_boot_acl field to correct place in struct icm
      thunderbolt: Log which connection manager implementation is used
      thunderbolt: Log adapter numbers in decimal in path activation/deactivation
      thunderbolt: Keep the parent runtime resumed for a while on device disconnect
      thunderbolt: Return -ENOTCONN when ERR_CONN is received
      thunderbolt: Perform USB4 router NVM upgrade in two phases
      thunderbolt: Pass metadata directly to usb4_switch_op()
      thunderbolt: Pass TX and RX data directly to usb4_switch_op()
      thunderbolt: Add connection manager specific hooks for USB4 router operations
      thunderbolt: Move constants for USB4 router operations to tb_regs.h
      thunderbolt: Add USB4 router operation proxy for firmware connection manager
      thunderbolt: Add support for Intel Maple Ridge
      xhci-pci: Allow host runtime PM as default for Intel Maple Ridge xHCI

Nick Desaulniers (1):
      usb: fix a few cases of -Wfallthrough

Oliver Neukum (2):
      USB: add RESET_RESUME quirk for Snapscan 1212
      USB: UAS: introduce a quirk to set no_write_same

Pawel Laszczak (2):
      usb: cdns3: Add static to cdns3_gadget_exit function
      usb: cdns3: Rids of duplicate error message

Peter Chen (8):
      usb: cdns3: host: add .suspend_quirk for xhci-plat.c
      usb: cdns3: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
      usb: cdns3: host: disable BEI support
      usb: cdns3: add quirk for enable runtime pm by default
      usb: cdns3: imx: enable runtime pm by default
      doc: dt-binding: cdns,usb3: add wakeup-irq
      usb: chipidea: add tracepoint support for udc
      usb: chipidea: trace: fix the endian issue

Prashant Malani (7):
      usb: pd: Add captive Type C cable type
      usb: typec: Add number of altmodes partner attr
      usb: typec: Add plug num_altmodes sysfs attr
      usb: typec: Fix num_altmodes kernel-doc error
      usb: typec: Consolidate sysfs ABI documentation
      usb: typec: Expose Product Type VDOs via sysfs
      usb: typec: Add class for plug alt mode device

Rikard Falkeborn (3):
      USB: core: Constify static attribute_group structs
      usb: typec: Constify static attribute_group structs
      usb: common: ulpi: Constify static attribute_group struct

Roger Quadros (1):
      usb: cdns3: fix NULL pointer dereference on no platform data

Sebastian Andrzej Siewior (1):
      usb: hcd.h: Remove RUN_CONTEXT

Sudip Mukherjee (1):
      usb: host: ehci-sched: add comment about find_tt() not returning error

Tejas Joglekar (2):
      usb: xhci: Set quirk for XHCI_SG_TRB_CACHE_SIZE_QUIRK
      usb: xhci: Use temporary buffer to consolidate SG

Thomas Gleixner (3):
      USB: sisusbvga: Make console support depend on BROKEN
      usb: atm: Replace in_interrupt() usage in comment
      USB: host: ehci-pmcmsp: Cleanup usb_hcd_msp_remove()

Tom Rix (5):
      USB: serial: iuu_phoenix: remove unneeded break
      usb: misc: iowarrior: remove unneeded break
      usb: storage: freecom: remove unneeded break
      usb: host: xhci-mem: remove unneeded break
      USB: host: u123-hcd: remove trailing semicolon in macro definition

Utkarsh Patel (6):
      usb: typec: Correct the bit values for the Thunderbolt rounded/non-rounded cable support
      platform/chrome: cros_ec_typec: Correct the Thunderbolt rounded/non-rounded cable support
      usb: typec: intel_pmc_mux: Configure Thunderbolt cable generation bits
      usb: typec: Remove one bit support for the Thunderbolt rounded/non-rounded cable
      usb: typec: intel_pmc_mux: Use correct response message bits
      usb: typec: intel_pmc_mux: Configure cable generation value for USB4

Will McVicker (2):
      USB: gadget: f_rndis: fix bitrate for SuperSpeed and above
      USB: gadget: f_midi: setup SuperSpeed Plus descriptors

Xu Wang (1):
      usb: fotg210-hcd: remove casting dma_alloc_coherent

Yang Yingliang (1):
      usb/max3421: fix return error code in max3421_probe()

Zhang Qilong (2):
      usb: ehci-omap: Fix PM disable depth umbalance in ehci_hcd_omap_probe
      usb: oxu210hp-hcd: Fix memory leak in oxu_create

Zheng Yongjun (3):
      usb: typec: tcpm: convert comma to semicolon
      usb: ucsi: convert comma to semicolon
      usb: phy: convert comma to semicolon

Zou Wei (1):
      usb: misc: brcmstb-usb-pinmap: Make sync_all_pins static

pumahsu (1):
      USB: typec: tcpm: Hard Reset after not receiving a Request

taehyun.cho (1):
      USB: gadget: f_acm: add support for SuperSpeed Plus

 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   28 +
 Documentation/ABI/testing/sysfs-class-typec        |  142 +-
 Documentation/admin-guide/kernel-parameters.txt    |    1 +
 .../bindings/connector/usb-connector.yaml          |   19 +
 .../devicetree/bindings/usb/brcm,usb-pinmap.yaml   |   70 +
 .../devicetree/bindings/usb/cdns,usb3.yaml         |    5 +
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   75 +
 MAINTAINERS                                        |   15 +
 arch/arm/configs/badge4_defconfig                  |    1 -
 arch/arm/configs/corgi_defconfig                   |    1 -
 arch/arm/configs/pxa_defconfig                     |    1 -
 arch/arm/configs/spitz_defconfig                   |    1 -
 arch/arm/mach-omap1/board-h2.c                     |   22 +-
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/configs/rm200_defconfig                  |    1 -
 arch/powerpc/configs/g5_defconfig                  |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 drivers/net/thunderbolt.c                          |    2 +-
 drivers/platform/chrome/cros_ec_typec.c            |    3 +-
 drivers/thunderbolt/Kconfig                        |   13 +
 drivers/thunderbolt/Makefile                       |    3 +
 drivers/thunderbolt/ctl.c                          |    7 +-
 drivers/thunderbolt/debugfs.c                      |   24 +
 drivers/thunderbolt/dma_test.c                     |  736 ++++++++
 drivers/thunderbolt/icm.c                          |  240 ++-
 drivers/thunderbolt/nhi.c                          |   36 +-
 drivers/thunderbolt/nhi.h                          |    1 +
 drivers/thunderbolt/path.c                         |   17 +-
 drivers/thunderbolt/switch.c                       |   53 +-
 drivers/thunderbolt/tb.c                           |    2 +
 drivers/thunderbolt/tb.h                           |   22 +
 drivers/thunderbolt/tb_msgs.h                      |   28 +
 drivers/thunderbolt/tb_regs.h                      |   14 +
 drivers/thunderbolt/tunnel.c                       |   50 +-
 drivers/thunderbolt/usb4.c                         |  269 +--
 drivers/thunderbolt/xdomain.c                      |  148 +-
 drivers/usb/Makefile                               |    1 -
 drivers/usb/atm/cxacru.c                           |    9 +-
 drivers/usb/atm/usbatm.c                           |    4 +-
 drivers/usb/atm/xusbatm.c                          |    2 +-
 drivers/usb/cdns3/cdns3-imx.c                      |    2 +-
 drivers/usb/cdns3/core.c                           |   15 +-
 drivers/usb/cdns3/core.h                           |    4 +
 drivers/usb/cdns3/gadget-export.h                  |    3 -
 drivers/usb/cdns3/gadget.c                         |    2 +-
 drivers/usb/cdns3/host-export.h                    |    6 +
 drivers/usb/cdns3/host.c                           |   60 +-
 drivers/usb/chipidea/Makefile                      |    5 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   10 +-
 drivers/usb/chipidea/trace.c                       |   23 +
 drivers/usb/chipidea/trace.h                       |   92 +
 drivers/usb/chipidea/udc.c                         |   10 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |    7 +-
 drivers/usb/common/ulpi.c                          |    2 +-
 drivers/usb/core/buffer.c                          |    6 +-
 drivers/usb/core/config.c                          |    1 +
 drivers/usb/core/endpoint.c                        |    2 +-
 drivers/usb/core/hcd-pci.c                         |    6 +-
 drivers/usb/core/hcd.c                             |   37 +-
 drivers/usb/core/hub.c                             |    3 +-
 drivers/usb/core/message.c                         |   47 +-
 drivers/usb/core/port.c                            |    4 +-
 drivers/usb/core/quirks.c                          |    3 +
 drivers/usb/core/sysfs.c                           |   14 +-
 drivers/usb/core/usb.c                             |    4 +-
 drivers/usb/gadget/function/f_acm.c                |    2 +-
 drivers/usb/gadget/function/f_fs.c                 |  184 +-
 drivers/usb/gadget/function/f_loopback.c           |    2 +-
 drivers/usb/gadget/function/f_midi.c               |    6 +
 drivers/usb/gadget/function/f_rndis.c              |    4 +-
 drivers/usb/gadget/function/f_sourcesink.c         |    1 +
 drivers/usb/gadget/udc/core.c                      |    2 -
 drivers/usb/gadget/udc/dummy_hcd.c                 |   10 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |   19 +-
 drivers/usb/host/Kconfig                           |   17 -
 drivers/usb/host/Makefile                          |    2 -
 drivers/usb/host/ehci-fsl.c                        |    9 +-
 drivers/usb/host/ehci-hcd.c                        |    2 +-
 drivers/usb/host/ehci-mxc.c                        |  213 ---
 drivers/usb/host/ehci-omap.c                       |    1 +
 drivers/usb/host/ehci-pmcmsp.c                     |   15 +-
 drivers/usb/host/ehci-sched.c                      |   12 +
 drivers/usb/host/fotg210-hcd.c                     |    4 +-
 drivers/usb/host/imx21-dbg.c                       |  439 -----
 drivers/usb/host/imx21-hcd.c                       | 1933 --------------------
 drivers/usb/host/imx21-hcd.h                       |  431 -----
 drivers/usb/host/isp116x-hcd.c                     |    1 +
 drivers/usb/host/isp1362.h                         |   54 -
 drivers/usb/host/max3421-hcd.c                     |    4 +-
 drivers/usb/host/ohci-at91.c                       |   11 +-
 drivers/usb/host/ohci-hcd.c                        |    2 +-
 drivers/usb/host/ohci-hub.c                        |    1 +
 drivers/usb/host/ohci-omap.c                       |    9 +-
 drivers/usb/host/ohci-pxa27x.c                     |   11 +-
 drivers/usb/host/ohci-s3c2410.c                    |   12 +-
 drivers/usb/host/oxu210hp-hcd.c                    |    5 +-
 drivers/usb/host/u132-hcd.c                        |    6 +-
 drivers/usb/host/xhci-hub.c                        |    4 +
 drivers/usb/host/xhci-mem.c                        |    3 +-
 drivers/usb/host/xhci-pci.c                        |    6 +-
 drivers/usb/host/xhci-plat.c                       |    3 +
 drivers/usb/host/xhci-ring.c                       |    4 +-
 drivers/usb/host/xhci.c                            |  135 +-
 drivers/usb/host/xhci.h                            |    5 +
 drivers/usb/misc/Kconfig                           |    9 +
 drivers/usb/misc/Makefile                          |    1 +
 drivers/usb/misc/apple-mfi-fastcharge.c            |   13 +-
 drivers/usb/misc/brcmstb-usb-pinmap.c              |  351 ++++
 drivers/usb/misc/iowarrior.c                       |    3 -
 drivers/usb/misc/legousbtower.c                    |    2 +-
 drivers/usb/misc/sisusbvga/Kconfig                 |    2 +-
 drivers/usb/misc/yurex.c                           |    1 +
 drivers/usb/mtu3/mtu3_debug.h                      |    1 -
 drivers/usb/mtu3/mtu3_debugfs.c                    |    2 +-
 drivers/usb/musb/tusb6010.c                        |    1 +
 drivers/usb/phy/Kconfig                            |    2 +-
 drivers/usb/phy/phy-isp1301-omap.c                 |   31 +-
 drivers/usb/serial/Kconfig                         |   19 +-
 drivers/usb/serial/Makefile                        |    1 -
 drivers/usb/serial/cp210x.c                        |  499 ++---
 drivers/usb/serial/digi_acceleport.c               |   62 +-
 drivers/usb/serial/ftdi_sio.c                      |   23 +-
 drivers/usb/serial/iuu_phoenix.c                   |    2 -
 drivers/usb/serial/keyspan_pda.c                   |  548 +++---
 drivers/usb/serial/mos7720.c                       |  236 +--
 drivers/usb/serial/option.c                        |   23 +-
 drivers/usb/storage/ene_ub6250.c                   |    1 +
 drivers/usb/storage/freecom.c                      |    1 -
 drivers/usb/storage/transport.c                    |    9 +-
 drivers/usb/storage/uas.c                          |    4 +
 drivers/usb/storage/unusual_uas.h                  |    7 +-
 drivers/usb/storage/usb.c                          |    3 +
 drivers/usb/typec/Kconfig                          |    5 +-
 drivers/usb/typec/class.c                          |  298 ++-
 drivers/usb/typec/mux/intel_pmc_mux.c              |   17 +-
 drivers/usb/typec/tcpm/fusb302.c                   |   16 +-
 drivers/usb/typec/tcpm/tcpci.c                     |  123 +-
 drivers/usb/typec/tcpm/tcpci.h                     |   25 +-
 drivers/usb/typec/tcpm/tcpci_maxim.c               |   51 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  227 ++-
 drivers/usb/typec/tcpm/wcove.c                     |    3 +-
 drivers/usb/typec/tps6598x.c                       |  103 ++
 drivers/usb/typec/ucsi/psy.c                       |    6 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  125 +-
 drivers/usb/typec/ucsi/ucsi.h                      |    2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |    5 +-
 drivers/usb/usbip/usbip_common.c                   |    5 -
 include/dt-bindings/usb/pd.h                       |    8 +
 include/linux/platform_data/usb-ehci-mxc.h         |   14 -
 include/linux/thunderbolt.h                        |   18 +-
 include/linux/usb/hcd.h                            |    4 -
 include/linux/usb/pd.h                             |    2 +
 include/linux/usb/pd_vdo.h                         |   19 +-
 include/linux/usb/serial.h                         |    2 -
 include/linux/usb/tcpm.h                           |   28 +-
 include/linux/usb/typec.h                          |    2 +
 include/linux/usb/typec_tbt.h                      |    6 +-
 include/linux/usb_usual.h                          |    2 +
 158 files changed, 4292 insertions(+), 4702 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max33359.yaml
 create mode 100644 drivers/thunderbolt/dma_test.c
 create mode 100644 drivers/usb/chipidea/trace.c
 create mode 100644 drivers/usb/chipidea/trace.h
 delete mode 100644 drivers/usb/host/ehci-mxc.c
 delete mode 100644 drivers/usb/host/imx21-dbg.c
 delete mode 100644 drivers/usb/host/imx21-hcd.c
 delete mode 100644 drivers/usb/host/imx21-hcd.h
 create mode 100644 drivers/usb/misc/brcmstb-usb-pinmap.c
 delete mode 100644 include/linux/platform_data/usb-ehci-mxc.h
