Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01028F20C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgJOM1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgJOM1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:27:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7E422255;
        Thu, 15 Oct 2020 12:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602764869;
        bh=Gp0eZLSliBCHObDs859PQFGEbyvwI2Pq9fahaq+5xJw=;
        h=Date:From:To:Cc:Subject:From;
        b=RfIzqfuOPu886C0njr7qHbu9dDq8zfDpLEzYa9NgE3ivE+ncFZxmMEooDg5KKIGiS
         OFUMrV3WcrB/7U7w/X1S0LSxnBX7CZmJh300CTCJ24/3T7fib+Dvzv2hZIhMO+T1TR
         ErPNAZFBrPTmOoRFbQOYokKM+6xhI+jjbWUjrTIc=
Date:   Thu, 15 Oct 2020 14:28:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY/Thunderbolt driver patches for 5.10-rc1
Message-ID: <20201015122822.GA4021571@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc1

for you to fetch changes up to 93578a25d4e21603518daf27a5f9caa4bf79de68:

  usb: musb: gadget: Use fallthrough pseudo-keyword (2020-10-10 12:32:29 +0200)

----------------------------------------------------------------
USB/PHY/Thunderbolt driver patches for 5.10-rc1

Here is the big set of USB, PHY, and Thunderbolt driver updates for
5.10-rc1.

Lots of tiny different things for these subsystems are in here,
including:
	- phy driver updates
	- thunderbolt / USB 4 updates and additions
	- USB gadget driver updates
	- xhci fixes and updates
	- typec driver additions and updates
	- api conversions to various drivers for core kernel api changes
	- new USB control message functions to make it harder to get
	  wrong, as found by syzbot (took 2 tries to get it right)
	- lots of tiny USB driver fixes and updates all over the place

All of these have been in linux-next for a while, with the exception of
the last "obviously correct" patch that updated a FALLTHROUGH comment
that got merged last weekend.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (5):
      USB: UDC: Expand device model API interface
      USB: UDC: net2280: Fix memory leaks
      USB: UDC: net2272: Fix memory leaks
      USB: hub: Clean up use of port initialization schemes and retries
      USB: hub: Add Kconfig option to reduce number of port initialization retries

Alex Dewar (1):
      usb: atm: don't use snprintf() for sysfs attrs

Allen Pais (7):
      usb: atm: convert tasklets to use new tasklet_setup() API
      usb: c67x00: convert tasklets to use new tasklet_setup() API
      usb: hcd: convert tasklets to use new tasklet_setup() API
      usb/gadget: f_midi: convert tasklets to use new tasklet_setup() API
      usb/gadget: fsl_qe_udc: convert tasklets to use new tasklet_setup() API
      usb: xhci: convert tasklets to use new tasklet_setup() API
      usb: mos7720: convert tasklets to use new tasklet_setup() API

Amelie Delaunay (5):
      dt-bindings: usb: dwc2: add optional usb-role-switch property
      usb: dwc2: override PHY input signals with usb role switch support
      usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15 SoCs
      usb: typec: add typec_find_pwr_opmode
      usb: typec: add support for STUSB160x Type-C controller family

Anand Moon (1):
      phy: samsung: Use readl_poll_timeout function

Azhar Shaikh (1):
      usb: typec: intel_pmc_mux: Pass correct USB Type-C port number to SoC

Badhri Jagan Sridharan (12):
      usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart
      usb: typec: pd: Fix formatting in pd.h header
      usb: typec: tcpm: Migrate workqueue to RT priority for processing events
      usb: typec: tcpci: Add register definitions to tcpci
      usb: typec: tcpci: Add support when hidden tx registers are inaccessible
      usb: typec: tcpci: update ROLE_CONTROL for DRP
      usb: typec: tcpci: Add a getter method to retrieve tcpm_port reference
      usb: typec: tcpci: Add set_vbus tcpci callback
      usb: typec: tcpci_maxim: Chip level TCPC driver
      usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
      usb: typec: tcpci: Implement callbacks for FRS
      usb: typec: tcpci_maxim: Add support for Sink FRS

Bastien Nocera (1):
      USB: Better name for __check_usb_generic()

Biju Das (2):
      dt-bindings: usb: renesas,usb3-peri: Document HS and SS data bus
      usb: typec: hd3ss3220: Use OF graph API to get the connector fwnode

Bryan O'Donoghue (1):
      USB: gadget: f_ncm: Fix NDP16 datagram validation

ChiYuan Huang (2):
      usb typec: mt6360: Add support for mt6360 Type-C driver
      usb typec: mt6360: Add MT6360 Type-C DT binding documentation

Chris Packham (1):
      usb: host: ehci-platform: Add workaround for brcm, xgs-iproc-ehci

Christian Lamparter (2):
      dt-bindings: usb: dwc2: add support for APM82181 SoCs USB OTG HS and FS
      usb: dwc2: add support for APM82181 USB OTG

Christophe JAILLET (1):
      usb: gadget: tegra-xudc: Avoid GFP_ATOMIC where it is not needed

Chunfeng Yun (18):
      phy: phy-bcm-ns-usb3: convert to readl_poll_timeout_atomic()
      phy: phy-bcm-ns2-usbdrd: convert to readl_poll_timeout_atomic()
      phy: phy-bcm-sr-usb: convert to readl_poll_timeout_atomic()
      phy: phy-qcom-apq8064-sata: convert to readl_relaxed_poll_timeout()
      phy: phy-pxa-28nm-hsic: convert to readl_poll_timeout()
      phy: phy-pxa-28nm-usb2: convert to readl_poll_timeout()
      usb: early: convert to readl_poll_timeout_atomic()
      usb: early: ehci-dbgp: convert to readl_poll_timeout_atomic()
      usb: pci-quirks: convert to readl_poll_timeout_atomic()
      usb: xhci-rcar: convert to readl_poll_timeout_atomic()
      usb: oxu210hp-hcd: convert to readl_poll_timeout_atomic()
      usb: fotg210-hcd: convert to readl_poll_timeout_atomic()
      usb: isp1760-hcd: convert to readl_poll_timeout_atomic()
      usb: phy-ulpi-viewport: convert to readl_poll_timeout_atomic()
      usb: phy: phy-mv-usb: convert to readl_poll_timeout_atomic()
      usb: udc: net2280: convert to readl_poll_timeout_atomic()
      iopoll: update kerneldoc of read_poll_timeout_atomic()
      usb: gadget: bcm63xx_udc: fix up the error of undeclared usb_debug_root

Claudiu Beznea (1):
      usb: gadget: udc: atmel: use of_find_matching_node_and_match

Colin Ian King (2):
      USB: storage: isd200: fix spelling mistake "removeable" -> "removable"
      usb: gadget: fix spelling mistake "Dectected" -> "Detected"

Cristian Birsan (5):
      dt-bindings: usb: atmel: Update DT bindings documentation for sam9x60
      usb: gadget: udc: atmel: simplify endpoint allocation
      usb: gadget: udc: atmel: use 1 bank endpoints for control transfers
      usb: gadget: udc: atmel: update endpoint allocation for sam9x60
      ARM: dts: at91: sam9x60ek: enable usb device

Dan Carpenter (1):
      thunderbolt: debugfs: Fix uninitialized return in counters_write()

Eli Billauer (1):
      usb: core: Solve race condition in anchor cleanup functions

Ezequiel Garcia (1):
      phy: Move phy-rockchip-dphy-rx0 out of staging

Felipe Balbi (11):
      usb: dwc3: meson: fix coccinelle WARNING
      usb: dwc3: debug: fix sparse warning
      usb: dwc3: meson: fix checkpatch errors and warnings
      usb: dwc3: ulpi: fix checkpatch warning
      usb: dwc3: trace: fix checkpatch warnings
      usb: dwc3: debug: fix checkpatch warning
      usb: dwc3: ep0: fix checkpatch warnings
      usb: dwc3: qcom: fix checkpatch warnings
      usb: dwc3: debugfs: fix checkpatch warnings
      usb: dwc3: core: fix checkpatch warnings
      usb: dwc3: gadget: fix checkpatch warnings

Florian Fainelli (1):
      MAINTAINERS: Add entry for Broadcom BDC driver

Frank Wunderlich (1):
      usb: xhci-mtk: Fix typo

Gil Fine (2):
      thunderbolt: Introduce tb_switch_is_tiger_lake()
      thunderbolt: Add debugfs interface

Greg Kroah-Hartman (27):
      Merge 5.9-rc3 into usb-next
      Merge 5.9-rc5 into usb-next
      USB: move snd_usb_pipe_sanity_check into the USB core
      USB: add usb_control_msg_send() and usb_control_msg_recv()
      USB: core: message.c: use usb_control_msg_send() in a few places
      USB: core: hub.c: use usb_control_msg_send() in a few places
      USB: legousbtower: use usb_control_msg_recv()
      sound: usx2y: move to use usb_control_msg_send()
      sound: 6fire: move to use usb_control_msg_send() and usb_control_msg_recv()
      sound: line6: move to use usb_control_msg_send() and usb_control_msg_recv()
      sound: hiface: move to use usb_control_msg_send()
      Bluetooth: ath3k: use usb_control_msg_send() and usb_control_msg_recv()
      ALSA: remove calls to usb_pipe_type_check for control endpoints
      Merge 5.0-rc6 into usb-next
      Merge a31128384dfd ("Merge tag 'libnvdimm-fixes-5.9-rc7' of git://git.kernel.org/.../nvdimm/nvdimm") into usb-next
      Merge tag 'usb-ci-v5.10-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next
      sound: usx2y: move to use usb_control_msg_send()
      sound: 6fire: move to use usb_control_msg_send() and usb_control_msg_recv()
      USB: legousbtower: use usb_control_msg_recv()
      sound: line6: move to use usb_control_msg_send() and usb_control_msg_recv()
      sound: hiface: move to use usb_control_msg_send()
      Bluetooth: ath3k: use usb_control_msg_send() and usb_control_msg_recv()
      Merge tag 'thunderbolt-for-v5.10-rc1' of git://git.kernel.org/.../westeri/thunderbolt into usb-next
      Merge tag 'phy-for-5.10' of git://git.kernel.org/.../phy/linux-phy into usb-next
      Merge tag 'usb-for-v5.10' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge 5.9-rc8 into usb-next
      Merge tag 'usb-serial-5.10-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next

Grygorii Strashko (3):
      phy: ti: gmii-sel: move phy init in separate function
      phy: ti: gmii-sel: use features mask during init
      phy: ti: gmii-sel: retrieve ports number and base offset from dt

Gustavo A. R. Silva (1):
      usb: musb: gadget: Use fallthrough pseudo-keyword

Hamish Martin (2):
      usb: ohci: Default to per-port over-current protection
      usb: ohci: Make distrust_firmware param default to false

Heikki Krogerus (4):
      usb: typec: intel_pmc_mux: Check the port status before connect
      usb: typec: intel_pmc_mux: Support for device role (UFP)
      usb: typec: intel_pmc_mux: Add dependency on ACPI
      usb: typec: displayport: Reduce noise from the driver

JC Kuo (1):
      usb: host: xhci-tegra: remove a duplicated entry

Jing Xiangfeng (1):
      USB: usblcd: Remove the superfluous break

Johan Hovold (6):
      Revert "cdc-acm: hardening against malicious devices"
      USB: cdc-acm: handle broken union descriptors
      USB: cdc-acm: use common data-class define
      USB: cdc-acm: clean up no-union-descriptor handling
      USB: serial: ftdi_sio: clean up jtag quirks
      USB: serial: qcserial: fix altsetting probing

Krzysztof Kozlowski (1):
      usb: gadget: s3c: Remove unused 'udc' variable

Kunihiko Hayashi (2):
      dt-bindings: phy: Add UniPhier AHCI PHY description
      phy: socionext: Add UniPhier AHCI PHY driver support

Lad Prabhakar (5):
      dt-bindings: usb: renesas,usb-xhci: Document r8a774e1 support
      dt-bindings: usb: renesas, usb3-peri: Document r8a774e1 support
      dt-bindings: usb: renesas,usbhs: Add r8a774e1 support
      dt-bindings: usb: renesas,usb-xhci: Document r8a774e1 support
      dt-bindings: usb: convert ti,hd3ss3220 bindings to json-schema

Leonid Bloch (1):
      USB: serial: option: Add Telit FT980-KS composition

Li Jun (7):
      dt-bindings: phy-imx8mq-usb: add compatible string for imx8mp usb phy
      phy: freescale: imx8mq-usb: add support for imx8mp usb phy
      usb: xhci: add debugfs support for ep with stream
      usb: dwc3: core: do not queue work if dr_mode is not USB_DR_MODE_OTG
      usb: dwc3: core: don't trigger runtime pm when remove driver
      usb: dwc3: core: add phy cleanup for probe error handling
      usb: dwc3: debugfs: do not queue work if try to change mode on non-drd

Linus Walleij (2):
      usb: gadget: udc: Drop surplus include
      usb: gadget: pch_udc: Convert to use GPIO descriptors

Liu Shixin (3):
      usbip: simplify the return expression of usbip_core_init()
      USB: bcma: use module_bcma_driver to simplify the code
      usb: appledisplay: use module_usb_driver to simplify the code

Lorenzo Colitti (4):
      usb: gadget: f_ncm: fix ncm_bitrate for SuperSpeed and above.
      usb: gadget: f_ncm: set SuperSpeed bulk descriptor bMaxBurst to 15
      usb: gadget: f_ncm: allow using NCM in SuperSpeed Plus gadgets.
      usb: gadget: u_ether: enable qmult on SuperSpeed Plus as well

Lukas Bulwahn (1):
      MAINTAINERS: make linux-usb list remarks consistent

Marc Zyngier (2):
      usb: dwc2: Always disable regulators on driver teardown
      usb: dwc2: Always disable regulators on driver teardown

Martin Blumenstingl (1):
      usb: dwc2: Add missing cleanups when usb_add_gadget_udc() fails

Mathias Nyman (2):
      xhci: Tune interrupt blocking for isochronous transfers
      xhci: don't create endpoint debugfs entry before ring buffer is set.

Mauro Carvalho Chehab (2):
      usb: dwc3: simple: add support for Hikey 970
      dt-bindings: document a new quirk for dwc3

Michał Mirosław (1):
      usb: gadget: f_acm: don't disable disabled EP

Mika Westerberg (31):
      thunderbolt: Software CM only should set force power in Tiger Lake
      thunderbolt: Use bit 31 to check if Firmware CM is running in Tiger Lake
      thunderbolt: Do not program NFC buffers for USB4 router protocol adapters
      thunderbolt: No need to log an error if tb_switch_lane_bonding_enable() fails
      thunderbolt: Send reset only to first generation routers
      thunderbolt: Tear down DP tunnels when suspending
      thunderbolt: Initialize TMU again on resume
      thunderbolt: Do not change default USB4 router notification timeout
      thunderbolt: Configure link after lane bonding is enabled
      thunderbolt: Set port configured for both ends of the link
      thunderbolt: Configure port for XDomain
      thunderbolt: Disable lane 1 for XDomain connection
      thunderbolt: Enable wakes from system suspend
      PCI / thunderbolt: Switch to use device links instead of PCI quirk
      ACPI: Export acpi_get_first_physical_node() to modules
      thunderbolt: Create device links from ACPI description
      thunderbolt: Add runtime PM for Software CM
      thunderbolt: Move struct tb_cap_any to tb_regs.h
      thunderbolt: Introduce tb_port_next_cap()
      thunderbolt: Introduce tb_switch_next_cap()
      thunderbolt: Introduce tb_port_is_nhi()
      thunderbolt: Check for Intel vendor ID when identifying controller
      thunderbolt: Introduce tb_switch_is_ice_lake()
      thunderbolt: No need to warn in TB_CFG_ERROR_INVALID_CONFIG_SPACE
      thunderbolt: Only stop control channel when entering freeze
      thunderbolt: Allow KUnit tests to be built also when CONFIG_USB4=m
      thunderbolt: Use "if USB4" instead of "depends on" in Kconfig
      thunderbolt: Handle ERR_LOCK notification
      thunderbolt: Log correct zeroX entries in decode_error()
      thunderbolt: Correct tb_check_quirks() kernel-doc
      thunderbolt: Capitalize comment on top of QUIRK_FORCE_POWER_LINK_CONTROLLER

Minas Harutyunyan (1):
      usb: dwc2: Fix INTR OUT transfers in DDMA mode.

Mychaela N. Falconia (2):
      USB: serial: ftdi_sio: add support for FreeCalypso JTAG+UART adapters
      USB: serial: ftdi_sio: use cur_altsetting for consistency

Nathan Chancellor (1):
      usb: dwc2: Fix parameter type in function pointer prototype

Neil Armstrong (2):
      dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG Families USB Glue Bindings
      usb: dwc-meson-g12a: Add support for USB on AXG SoCs

Nicolas Saenz Julienne (9):
      dt-bindings: reset: Add a binding for the RPi Firmware reset controller
      reset: Add Raspberry Pi 4 firmware reset controller
      ARM: dts: bcm2711: Add firmware usb reset node
      ARM: dts: bcm2711: Add reset controller to xHCI node
      usb: xhci-pci: Add support for reset controllers
      Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
      usb: host: pci-quirks: Bypass xHCI quirks for Raspberry Pi 4
      Revert "firmware: raspberrypi: Introduce vl805 init routine"
      Revert "PCI: brcmstb: Wait for Raspberry Pi's firmware when present"

Oliver Neukum (14):
      USB: microtek: use set_host_byte()
      USB: UAS: fix disconnect by unplugging a hub
      USB: UAS: use macro for reporting results
      USB: adutux: fix debugging
      USB: cdc-acm: cleanup of data structures
      Revert "USB: core: hub.c: use usb_control_msg_send() in a few places"
      Revert "Bluetooth: ath3k: use usb_control_msg_send() and usb_control_msg_recv()"
      Revert "sound: hiface: move to use usb_control_msg_send()"
      Revert "sound: line6: move to use usb_control_msg_send() and usb_control_msg_recv()"
      Revert "sound: 6fire: move to use usb_control_msg_send() and usb_control_msg_recv()"
      Revert "sound: usx2y: move to use usb_control_msg_send()"
      Revert "USB: legousbtower: use usb_control_msg_recv()"
      USB: correct API of usb_control_msg_send/recv
      USB: cdc-wdm: Make wdm_flush() interruptible and add wdm_fsync().

Paul Cercueil (5):
      usb/misc: usb4604: Use pm_ptr() macro
      usb/misc: usb3503: Use pm_ptr() macro
      usb/host: ehci-platform: Use pm_ptr() macro
      usb/host: ehci-spear: Use pm_ptr() macro
      usb/host: ehci-npcm7xx: Use pm_ptr() macro

Pawel Laszczak (2):
      usb: cdns3: Enable workaround for USB2.0 PHY Rx compliance test PHY lockup
      usb: gadget: config_ep_by_speed_and_alt instead of config_ep_by_speed

Peter Chen (32):
      doc: dt-binding: ci-hdrc-usb2: add property for samsung picophy
      usb: chipidea: imx: add two samsung picophy parameters tuning implementation
      usb: chipidea: ci_hdrc_imx: restore pinctrl
      usb: host: xhci-plat: add platform data support
      usb: host: xhci-plat: add .suspend_quirk for struct xhci_plat_priv
      usb: host: xhci-plat: delete the unnecessary code
      usb: host: xhci-plat: add priv quirk for skip PHY initialization
      usb: host: xhci-plat: add wakeup entry at sysfs
      usb: host: xhci-plat: improve the comments for xhci_plat_suspend
      usb: xhci: omit duplicate actions when suspending a runtime suspended host.
      usb: cdns3: gadget: free interrupt after gadget has deleted
      MAINTAINERS: add Cadence USB3 DRD IP driver entry
      usb: cdns3: introduce set_phy_power_on{off} APIs
      usb: cdns3: add runtime PM support
      usb: cdns3: imx: add glue layer runtime pm implementation
      usb: cdns3: core: quit if it uses role switch class
      usb: cdns3: gadget: set fast access bit
      usb: cdns3: gadget: clear the interrupt status when disconnect the host
      usb: cdns3: drd: call PHY .set_mode accordingly
      usb: cdns3: gadget: move wait configuration operation
      usb: cdns3: gadget: fix some endian issues
      usb: cdns3: gadget: fix possible memory leak
      usb: dwc3: allocate gadget structure dynamically
      Revert "usb: udc: allow adding and removing the same gadget device"
      usb: gadget: core: do not try to disconnect gadget if it is not connected
      usb: cdns3: gadget: using correct sg operations
      usb: cdns3: gadget: improve the dump TRB operation at cdns3_ep_run_transfer
      usb: cdns3: gadget: add CHAIN and ISP bit for sg list use case
      usb: cdns3: gadget: handle sg list use case at completion correctly
      usb: cdns3: gadget: need to handle sg case for workaround 2 case
      usb: cdns3: gadget: sg_support is only for DEV_VER_V2 or above
      usb: cdns3: gadget: enlarge the TRB ring length

Petko Manolov (2):
      net: rtl8150: Use the new usb control message API.
      net: pegasus: Use the new usb control message API.

Qinglang Miao (1):
      usb: gadget: lpc32xx_udc: Convert to DEFINE_SHOW_ATTRIBUTE

Rajmohan Mani (2):
      thunderbolt: Optimize Force Power logic
      thunderbolt: Optimize NHI LC mailbox command processing

Ramuthevar Vadivel Murugan (2):
      dt-bindings: phy: Add USB PHY support for Intel LGM SoC
      phy: Add USB3 PHY support for Intel LGM SoC

Randy Dunlap (3):
      usb: phy: phy-ab8500-usb: fix spello of "function"
      phy: fix USB_LGM_PHY warning & build errors
      usb: phy: phy-ab8500-usb: fix spello of "function"

Raymond Tan (1):
      usb: dwc3: pci: Allow Elkhart Lake to utilize DSM method for PM functionality

Rikard Falkeborn (11):
      phy: cadence: salvo: Constify cdns_salvo_phy_ops
      phy: fsl-imx8mq-usb: Constify imx8mq_usb_phy_ops
      phy: hisilicon; Constify hi3660_phy_ops
      phy: lantiq: rcu-usb2: Constify ltq_rcu_usb2_phy_ops
      phy: lantiq: vrx200-pcie: Constify ltq_vrx200_pcie_phy_ops
      phy: ralink-usb: Constify ralink_usb_phy_ops
      phy: samsung-ufs: Constify samsung_ufs_phy_ops
      phy: qcom-ipq4019-usb: Constify static phy_ops structs
      phy: cadence: Sierra: Constify static structs
      phy: cadence: salvo: Constify cdns_nxp_sequence_pair
      phy: cadence: torrent: Constify regmap_config structs

Roger Quadros (4):
      phy: omap-usb2-phy: fix coding style issues
      dt-binding: phy: convert ti,omap-usb2 to YAML
      dt-bindings: usb: Convert cdns-usb3.txt to YAML schema
      dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable property

Sandeep Maheswaram (1):
      usb: dwc3: qcom: Add interconnect support in dwc3 driver

Scott Chen (1):
      USB: serial: pl2303: add device-id for HP GC device

Sekhar Nori (3):
      phy: ti: am654: simplify regfield handling
      phy: ti: am654: simplify return handling
      phy: ti: am654: update PCIe serdes config

Sergey Korolev (1):
      USB: core: remove polling for /sys/kernel/debug/usb/devices

Sergey Shtylyov (1):
      usb: core: driver: fix stray tabs in error messages

Shuah Khan (1):
      usbip: vhci_hcd: fix calling usb_hcd_giveback_urb() with irqs enabled

Stephen Boyd (8):
      dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy information
      phy: qcom-qmp: Move phy mode into struct qmp_phy
      phy: qcom-qmp: Remove 'initialized' in favor of 'init_count'
      phy: qcom-qmp: Move 'serdes' and 'cfg' into 'struct qcom_phy'
      phy: qcom-qmp: Get dp_com I/O resource by index
      phy: qcom-qmp: Use devm_platform_ioremap_resource() to simplify
      phy: qcom-qmp: Add support for DP in USB3+DP combo phy
      phy: qcom-qmp: Add support for sc7180 DP phy

Swapnil Jakhade (22):
      phy: Add new PHY attribute max_link_rate
      phy: cadence-torrent: Set Torrent PHY attributes
      phy: cadence-torrent: Use of_device_get_match_data() to get driver data
      phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg addresses
      phy: cadence-torrent: Enable support for multiple subnodes
      phy: cadence-torrent: Add separate regmap functions for torrent and DP
      phy: cadence-torrent: Check total lane count for all subnodes is within limit
      dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
      dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for generic use
      phy: cadence-torrent: Add single link PCIe support
      phy: cadence-torrent: Check cmn_ready assertion during PHY power on
      phy: cadence-torrent: Add PHY APB reset support
      dt-bindings: phy: Add PHY_TYPE_QSGMII definition
      phy: cadence-torrent: Add support for PHY multilink configuration
      phy: cadence-torrent: Update PHY reset for multilink configuration
      phy: cadence-torrent: Add clk changes for multilink configuration
      phy: cadence-torrent: Add PHY link configuration sequences for single link
      phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
      phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
      phy: cadence-torrent: Add single link USB register sequences
      phy: cadence-torrent: Add PCIe + USB multilink configuration
      phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration

Tang Bin (2):
      usb: bdc: Fix unused assignment in bdc_probe()
      usb: bdc: remove duplicated error message

Tao Ren (1):
      usb: gadget: aspeed: fixup vhub port irq handling

Thierry Reding (5):
      usb: common: usb-conn-gpio: Make VBUS supply optional
      usb: common: usb-conn-gpio: Print error on failure to get VBUS
      usb: gadget: tegra-xudc: Use consistent spelling and formatting
      usb: gadget: tegra-xudc: Properly align parameters
      usb: gadget: tegra-xudc: Do not print errors on probe deferral

Thinh Nguyen (21):
      usb: dwc3: gadget: Resume pending requests after CLEAR_STALL
      usb: dwc3: gadget: END_TRANSFER before CLEAR_STALL command
      usb: dwc3: core: Properly default unspecified speed
      usb: dwc3: core: Print warning on unsupported speed
      usb: dwc3: gadget: Refactor ep command completion
      usb: dwc3: gadget: Check MPS of the request length
      usb: dwc3: gadget: Reclaim extra TRBs after request completion
      usb: dwc3: gadget: Refactor preparing extra TRB
      usb: dwc3: gadget: Improve TRB ZLP setup
      usb: dwc3: ep0: Fix ZLP for OUT ep0 requests
      usb: dwc3: gadget: Return the number of prepared TRBs
      usb: dwc3: gadget: Check for number of TRBs prepared
      usb: dwc3: gadget: Set IOC if not enough for extra TRBs
      usb: dwc3: gadget: Refactor preparing last TRBs
      usb: dwc3: gadget: Rename misleading function names
      usb: dwc3: gadget: Allow restarting a transfer
      usb: dwc3: gadget: Look ahead when setting IOC
      usb: dwc3: gadget: Revise setting IOC when no TRB left
      usb: dwc3: gadget: Keep TRBs in request order
      usb: dwc3: gadget: Return early if no TRB update
      usb: dwc3: gadget: Support up to max stream id

Tian Tao (1):
      thunderbolt: Use kobj_to_dev() instead of container_of()

Tom Yan (3):
      usb-storage: fix sdev->host->dma_dev
      uas: fix sdev->host->dma_dev
      uas: bump hw_max_sectors to 2048 blocks for SS or faster drives

Tomasz Figa (1):
      phy: rockchip-dphy-rx0: Include linux/delay.h

Tomi Valkeinen (2):
      dt-bindings: phy: cdns,torrent-phy: add reset-names
      dt-bindings: phy: ti,phy-j721e-wiz: fix bindings for torrent phy

Vincent Mailhol (1):
      usb: cdc-acm: add quirk to blacklist ETAS ES58X devices

Vinod Koul (3):
      Merge branch 'fixes' into next
      Merge branch 'topic/phy_attrs' into next
      phy: qcom-qmp: initialize the pointer to NULL

Wan Ahmad Zainie (5):
      phy: intel: Rename phy-intel to phy-intel-lgm
      dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
      phy: intel: Add Keem Bay eMMC PHY support
      dt-bindings: usb: Add Intel Keem Bay USB controller bindings
      usb: dwc3: of-simple: Add compatible string for Intel Keem Bay platform

Wesley Cheng (2):
      usb: dwc3: Stop active transfers before halting the controller
      usb: typec: Add QCOM PMIC typec detection driver

Wilken Gottwalt (1):
      USB: serial: option: add Cellient MPL200 card

Xu Wang (1):
      USB: yurex: remove needless check before usb_free_coherent()

Ye Bin (1):
      usb: gadget: fsl: Fix unsigned expression compared with zero in fsl_udc_probe

Yoshihiro Shimoda (1):
      usb: gadget: u_serial: clear suspended flag when disconnecting

Yu Chen (1):
      usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc

YueHaibing (4):
      usb: mtu3: Remove unsused inline function is_first_entry
      phy: ti: j721e-wiz: Remove duplicate include
      usb: host: ehci-sched: Remove ununsed function tt_start_uframe()
      usb: mtu3: Remove unsused inline function is_first_entry

Zqiang (2):
      usb: gadget: function: printer: fix use-after-free in __lock_acquire
      usb: gadget: uvc: Fix the wrong v4l2_device_unregister call

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |   21 +
 .../devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt |    2 +-
 .../bindings/phy/intel,lgm-emmc-phy.yaml           |   17 +-
 .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml |   58 +
 .../bindings/phy/phy-cadence-torrent.yaml          |   96 +-
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |   95 +-
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   76 +
 .../devicetree/bindings/phy/ti,omap-usb2.yaml      |   74 +
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   13 +-
 Documentation/devicetree/bindings/phy/ti-phy.txt   |   37 -
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |   22 +-
 .../devicetree/bindings/usb/atmel-usb.txt          |    1 +
 .../devicetree/bindings/usb/cdns,usb3.yaml         |   96 +
 .../devicetree/bindings/usb/cdns-usb3.txt          |   45 -
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    9 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |    5 +
 Documentation/devicetree/bindings/usb/dwc3.txt     |    3 +
 .../bindings/usb/intel,keembay-dwc3.yaml           |   77 +
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         |   95 +
 .../devicetree/bindings/usb/renesas,usb-xhci.yaml  |    1 +
 .../devicetree/bindings/usb/renesas,usb3-peri.yaml |   35 +-
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |    1 +
 .../devicetree/bindings/usb/ti,hd3ss3220.txt       |   38 -
 .../devicetree/bindings/usb/ti,hd3ss3220.yaml      |   82 +
 MAINTAINERS                                        |   20 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts               |   13 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |   22 +
 arch/arm/boot/dts/sam9x60.dtsi                     |   14 +
 drivers/acpi/bus.c                                 |    1 +
 drivers/bluetooth/ath3k.c                          |   93 +-
 drivers/firmware/Kconfig                           |    3 +-
 drivers/firmware/raspberrypi.c                     |   61 -
 drivers/net/usb/pegasus.c                          |   61 +-
 drivers/net/usb/rtl8150.c                          |   32 +-
 drivers/pci/controller/pcie-brcmstb.c              |   17 -
 drivers/pci/quirks.c                               |   57 -
 drivers/phy/Kconfig                                |   11 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             |   22 +-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          |   13 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c              |   19 +-
 drivers/phy/cadence/phy-cadence-salvo.c            |    8 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |   24 +-
 drivers/phy/cadence/phy-cadence-torrent.c          | 2119 +++++++++++++++++++-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         |   79 +-
 drivers/phy/hisilicon/phy-hi3660-usb3.c            |    2 +-
 drivers/phy/intel/Kconfig                          |   22 +-
 drivers/phy/intel/Makefile                         |    5 +-
 drivers/phy/intel/phy-intel-keembay-emmc.c         |  307 +++
 .../{phy-intel-combo.c => phy-intel-lgm-combo.c}   |    0
 .../{phy-intel-emmc.c => phy-intel-lgm-emmc.c}     |    0
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           |    2 +-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |    2 +-
 drivers/phy/marvell/phy-pxa-28nm-hsic.c            |   40 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c            |   33 +-
 drivers/phy/phy-lgm-usb.c                          |  284 +++
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |   21 +-
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c        |    4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 1053 ++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   80 +
 drivers/phy/ralink/phy-ralink-usb.c                |    2 +-
 drivers/phy/rockchip/Kconfig                       |   12 +
 drivers/phy/rockchip/Makefile                      |    1 +
 .../rockchip}/phy-rockchip-dphy-rx0.c              |    1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |   39 +-
 drivers/phy/samsung/phy-samsung-ufs.c              |    2 +-
 drivers/phy/socionext/Kconfig                      |   10 +
 drivers/phy/socionext/Makefile                     |    1 +
 drivers/phy/socionext/phy-uniphier-ahci.c          |  321 +++
 drivers/phy/ti/phy-am654-serdes.c                  |  325 +--
 drivers/phy/ti/phy-gmii-sel.c                      |  159 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |    1 -
 drivers/phy/ti/phy-omap-usb2.c                     |   36 +-
 drivers/reset/Kconfig                              |   11 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-raspberrypi.c                  |  122 ++
 drivers/staging/media/Kconfig                      |    2 -
 drivers/staging/media/Makefile                     |    1 -
 .../staging/media/phy-rockchip-dphy-rx0/Kconfig    |   13 -
 .../staging/media/phy-rockchip-dphy-rx0/Makefile   |    2 -
 drivers/staging/media/phy-rockchip-dphy-rx0/TODO   |    6 -
 drivers/thunderbolt/Kconfig                        |   14 +-
 drivers/thunderbolt/Makefile                       |    4 +-
 drivers/thunderbolt/acpi.c                         |  117 ++
 drivers/thunderbolt/cap.c                          |  136 +-
 drivers/thunderbolt/ctl.c                          |   23 +-
 drivers/thunderbolt/debugfs.c                      |  701 +++++++
 drivers/thunderbolt/domain.c                       |   48 +-
 drivers/thunderbolt/icm.c                          |    5 +-
 drivers/thunderbolt/lc.c                           |  151 +-
 drivers/thunderbolt/nhi.c                          |   90 +-
 drivers/thunderbolt/nhi_ops.c                      |   31 +-
 drivers/thunderbolt/quirks.c                       |    2 +-
 drivers/thunderbolt/switch.c                       |  216 +-
 drivers/thunderbolt/tb.c                           |  207 +-
 drivers/thunderbolt/tb.h                           |  160 +-
 drivers/thunderbolt/tb_msgs.h                      |    1 +
 drivers/thunderbolt/tb_regs.h                      |   34 +-
 drivers/thunderbolt/test.c                         |   13 +-
 drivers/thunderbolt/usb4.c                         |  251 ++-
 drivers/usb/atm/cxacru.c                           |   27 +-
 drivers/usb/atm/usbatm.c                           |   14 +-
 drivers/usb/c67x00/c67x00-sched.c                  |    7 +-
 drivers/usb/cdns3/cdns3-imx.c                      |  191 +-
 drivers/usb/cdns3/core.c                           |  202 +-
 drivers/usb/cdns3/core.h                           |   17 +
 drivers/usb/cdns3/drd.c                            |   20 +
 drivers/usb/cdns3/drd.h                            |    5 +-
 drivers/usb/cdns3/ep0.c                            |   10 +-
 drivers/usb/cdns3/gadget.c                         |  276 ++-
 drivers/usb/cdns3/gadget.h                         |   11 +-
 drivers/usb/cdns3/host.c                           |    7 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   13 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    2 +
 drivers/usb/chipidea/usbmisc_imx.c                 |   21 +
 drivers/usb/class/cdc-acm.c                        |   79 +-
 drivers/usb/class/cdc-acm.h                        |   19 +-
 drivers/usb/class/cdc-wdm.c                        |   72 +-
 drivers/usb/common/usb-conn-gpio.c                 |   32 +-
 drivers/usb/core/Kconfig                           |   14 +
 drivers/usb/core/devices.c                         |   41 -
 drivers/usb/core/driver.c                          |    8 +-
 drivers/usb/core/generic.c                         |    4 +-
 drivers/usb/core/hcd.c                             |    6 +-
 drivers/usb/core/hub.c                             |   62 +-
 drivers/usb/core/message.c                         |  180 +-
 drivers/usb/core/urb.c                             |  120 +-
 drivers/usb/core/usb.h                             |    1 -
 drivers/usb/dwc2/Kconfig                           |    1 +
 drivers/usb/dwc2/Makefile                          |    2 +-
 drivers/usb/dwc2/core.h                            |    9 +
 drivers/usb/dwc2/drd.c                             |  180 ++
 drivers/usb/dwc2/gadget.c                          |   42 +-
 drivers/usb/dwc2/params.c                          |    5 +-
 drivers/usb/dwc2/platform.c                        |   43 +-
 drivers/usb/dwc3/core.c                            |   90 +-
 drivers/usb/dwc3/core.h                            |   47 +-
 drivers/usb/dwc3/debug.h                           |    8 +-
 drivers/usb/dwc3/debugfs.c                         |   59 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   41 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    2 +
 drivers/usb/dwc3/dwc3-pci.c                        |    3 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  128 +-
 drivers/usb/dwc3/ep0.c                             |   61 +-
 drivers/usb/dwc3/gadget.c                          |  593 +++---
 drivers/usb/dwc3/gadget.h                          |    3 +-
 drivers/usb/dwc3/trace.h                           |   17 +-
 drivers/usb/dwc3/ulpi.c                            |    2 +-
 drivers/usb/early/ehci-dbgp.c                      |   15 +-
 drivers/usb/early/xhci-dbc.c                       |   14 +-
 drivers/usb/gadget/function/f_acm.c                |    8 +-
 drivers/usb/gadget/function/f_midi.c               |    6 +-
 drivers/usb/gadget/function/f_ncm.c                |   10 +-
 drivers/usb/gadget/function/f_printer.c            |   16 +-
 drivers/usb/gadget/function/f_tcm.c                |   12 +-
 drivers/usb/gadget/function/f_uvc.c                |    8 +-
 drivers/usb/gadget/function/u_ether.c              |    2 +-
 drivers/usb/gadget/function/u_serial.c             |    1 +
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |   10 +-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |    3 +
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   68 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h            |    3 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |    1 +
 drivers/usb/gadget/udc/bdc/bdc_core.c              |    9 +-
 drivers/usb/gadget/udc/core.c                      |   82 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |    7 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |    9 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |   17 +-
 drivers/usb/gadget/udc/net2272.c                   |   24 +-
 drivers/usb/gadget/udc/net2272.h                   |    1 +
 drivers/usb/gadget/udc/net2280.c                   |   32 +-
 drivers/usb/gadget/udc/net2280.h                   |    1 +
 drivers/usb/gadget/udc/pch_udc.c                   |   55 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |    3 -
 drivers/usb/gadget/udc/tegra-xudc.c                |   60 +-
 drivers/usb/host/bcma-hcd.c                        |   13 +-
 drivers/usb/host/ehci-npcm7xx.c                    |    8 +-
 drivers/usb/host/ehci-platform.c                   |   16 +-
 drivers/usb/host/ehci-sched.c                      |   20 -
 drivers/usb/host/ehci-spear.c                      |    8 +-
 drivers/usb/host/fotg210-hcd.c                     |   20 +-
 drivers/usb/host/ohci-hcd.c                        |   18 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   21 +-
 drivers/usb/host/pci-quirks.c                      |   35 +-
 drivers/usb/host/xhci-dbgtty.c                     |    6 +-
 drivers/usb/host/xhci-debugfs.c                    |  109 +-
 drivers/usb/host/xhci-debugfs.h                    |   10 +
 drivers/usb/host/xhci-mtk.c                        |    6 +-
 drivers/usb/host/xhci-pci.c                        |   10 +
 drivers/usb/host/xhci-plat.c                       |   44 +-
 drivers/usb/host/xhci-plat.h                       |    1 +
 drivers/usb/host/xhci-rcar.c                       |   43 +-
 drivers/usb/host/xhci-ring.c                       |   23 +-
 drivers/usb/host/xhci-tegra.c                      |    1 -
 drivers/usb/host/xhci.c                            |   11 +-
 drivers/usb/host/xhci.h                            |    3 +
 drivers/usb/image/microtek.c                       |   14 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |   20 +-
 drivers/usb/misc/adutux.c                          |    1 +
 drivers/usb/misc/appledisplay.c                    |   14 +-
 drivers/usb/misc/legousbtower.c                    |   61 +-
 drivers/usb/misc/usb3503.c                         |   18 +-
 drivers/usb/misc/usb4604.c                         |    8 +-
 drivers/usb/misc/usblcd.c                          |    1 -
 drivers/usb/misc/yurex.c                           |    6 +-
 drivers/usb/mtu3/mtu3.h                            |    6 -
 drivers/usb/musb/musb_gadget_ep0.c                 |    2 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |    2 +-
 drivers/usb/phy/phy-mv-usb.c                       |   18 +-
 drivers/usb/phy/phy-ulpi-viewport.c                |   12 +-
 drivers/usb/serial/ftdi_sio.c                      |   37 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |    7 +
 drivers/usb/serial/mos7720.c                       |    8 +-
 drivers/usb/serial/option.c                        |    5 +
 drivers/usb/serial/pl2303.c                        |    1 +
 drivers/usb/serial/pl2303.h                        |    1 +
 drivers/usb/serial/qcserial.c                      |    4 +-
 drivers/usb/storage/isd200.c                       |    2 +-
 drivers/usb/storage/scsiglue.c                     |    2 +-
 drivers/usb/storage/uas.c                          |   31 +-
 drivers/usb/storage/usb.c                          |    5 +-
 drivers/usb/typec/Kconfig                          |   24 +
 drivers/usb/typec/Makefile                         |    2 +
 drivers/usb/typec/altmodes/displayport.c           |    2 +-
 drivers/usb/typec/class.c                          |   15 +
 drivers/usb/typec/hd3ss3220.c                      |   18 +-
 drivers/usb/typec/mux/Kconfig                      |    1 +
 drivers/usb/typec/mux/intel_pmc_mux.c              |  207 +-
 drivers/usb/typec/qcom-pmic-typec.c                |  262 +++
 drivers/usb/typec/stusb160x.c                      |  875 ++++++++
 drivers/usb/typec/tcpm/Kconfig                     |   14 +
 drivers/usb/typec/tcpm/Makefile                    |   14 +-
 drivers/usb/typec/tcpm/tcpci.c                     |  113 +-
 drivers/usb/typec/tcpm/tcpci.h                     |   25 +
 drivers/usb/typec/tcpm/tcpci_maxim.c               |  503 +++++
 drivers/usb/typec/tcpm/tcpci_mt6360.c              |  212 ++
 drivers/usb/typec/tcpm/tcpm.c                      |  362 +++-
 drivers/usb/usbip/usbip_common.c                   |    8 +-
 drivers/usb/usbip/vhci_hcd.c                       |    8 +-
 include/dt-bindings/phy/phy-cadence-torrent.h      |   13 +
 include/dt-bindings/phy/phy.h                      |    1 +
 .../dt-bindings/reset/raspberrypi,firmware-reset.h |   13 +
 include/linux/iopoll.h                             |    4 +-
 include/linux/phy/phy.h                            |    2 +
 include/linux/usb.h                                |    9 +
 include/linux/usb/gadget.h                         |   27 +-
 include/linux/usb/pd.h                             |   26 +-
 include/linux/usb/tcpm.h                           |    8 +-
 include/linux/usb/typec.h                          |    1 +
 include/soc/bcm2835/raspberrypi-firmware.h         |    7 -
 sound/usb/6fire/firmware.c                         |   38 +-
 sound/usb/helper.c                                 |   16 +-
 sound/usb/helper.h                                 |    1 -
 sound/usb/hiface/pcm.c                             |   14 +-
 sound/usb/line6/driver.c                           |   72 +-
 sound/usb/line6/podhd.c                            |   23 +-
 sound/usb/line6/toneport.c                         |    9 +-
 sound/usb/mixer_scarlett_gen2.c                    |    2 +-
 sound/usb/quirks.c                                 |   12 +-
 sound/usb/usx2y/us122l.c                           |   42 +-
 260 files changed, 12933 insertions(+), 2874 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
 create mode 100644 drivers/phy/intel/phy-intel-keembay-emmc.c
 rename drivers/phy/intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} (100%)
 rename drivers/phy/intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c} (100%)
 create mode 100644 drivers/phy/phy-lgm-usb.c
 rename drivers/{staging/media/phy-rockchip-dphy-rx0 => phy/rockchip}/phy-rockchip-dphy-rx0.c (99%)
 create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c
 create mode 100644 drivers/reset/reset-raspberrypi.c
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/Makefile
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/TODO
 create mode 100644 drivers/thunderbolt/acpi.c
 create mode 100644 drivers/thunderbolt/debugfs.c
 create mode 100644 drivers/usb/dwc2/drd.c
 create mode 100644 drivers/usb/typec/qcom-pmic-typec.c
 create mode 100644 drivers/usb/typec/stusb160x.c
 create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.c
 create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
 create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h
 create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h
