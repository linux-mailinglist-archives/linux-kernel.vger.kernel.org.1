Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECA2F078A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbhAJOKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbhAJOKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:10:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97DCF2333E;
        Sun, 10 Jan 2021 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610287783;
        bh=qx0PDNl7K0ujYA+xmp3tepZFkfNJbClmmtaz/xw7Hek=;
        h=Date:From:To:Cc:Subject:From;
        b=mSV8RvuYCgya7dTlwKpll1ATDR6IWOXgbKA3wNezMpBm8KboCsd9d0xxVqZsdaaTK
         05vzMEU4NRy8/LUEs1izI1fCTwBoT6/eUicPR7o6LUpbSC0Av3+97hBz92TMkAJs0+
         5bR4meGVVZ8y+7wT8WKQ95y2GO19xo/inIrw15+U=
Date:   Sun, 10 Jan 2021 15:10:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.11-rc3
Message-ID: <X/sK8J7QqiNSPZ1e@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc3

for you to fetch changes up to a5c7682aaaa10e42928d73de1c9e1e02d2b14c2e:

  usb: dwc3: gadget: Clear wait flag on dequeue (2021-01-07 14:24:35 +0100)

----------------------------------------------------------------
USB fixes for 5.11-rc3

Here are a number of small USB driver fixes for 5.11-rc3.

Include in here are:
	- USB gadget driver fixes for reported issues
	- new usb-serial driver ids
	- dma from stack bugfixes
	- typec bugfixes
	- dwc3 bugfixes
	- xhci driver bugfixes
	- other small misc usb driver bugfixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

Andrey Konovalov (1):
      kcov, usb: hide in_serving_softirq checks in __usb_hcd_giveback_urb

Arnd Bergmann (1):
      usb: gadget: select CONFIG_CRC32

Aswath Govindraju (1):
      dt-bindings: usb: Add new compatible string for AM64 SoC

Bjørn Mork (1):
      USB: serial: option: add Quectel EM160R-GL

Chandana Kishori Chiluveru (1):
      usb: gadget: configfs: Preserve function ordering after bind failure

Daniel Palmer (1):
      USB: serial: option: add LongSung M5710 module support

Eddie Hung (1):
      usb: gadget: configfs: Fix use-after-free issue with udc_name

Fabio Estevam (1):
      usb: gadget: fsl_mxc_udc: Remove the driver

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.11-rc3' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Jerome Brunet (1):
      usb: gadget: f_uac2: reset wMaxPacketSize

Johan Hovold (3):
      USB: yurex: fix control-URB timeout handling
      USB: serial: iuu_phoenix: fix DMA from stack
      USB: usblp: fix DMA to stack

Madhusudanarao Amara (1):
      usb: typec: intel_pmc_mux: Configure HPD first for HPD+IRQ request

Manish Narani (1):
      usb: gadget: u_ether: Fix MTU size mismatch with RX packet size

Michael Grzeschik (1):
      USB: xhci: fix U1/U2 handling for hardware with XHCI_INTEL_HOST quirk set

Peter Chen (1):
      usb: gadget: core: change the comment for usb_gadget_connect

Peter Robinson (1):
      usb: typec: Fix copy paste error for NVIDIA alt-mode description

Prashant Malani (1):
      usb: typec: Send uevent for num_altmodes update

Randy Dunlap (1):
      usb: usbip: vhci_hcd: protect shift size

Roger Quadros (1):
      MAINTAINERS: Update address for Cadence USB3 driver

Sean Young (1):
      USB: cdc-acm: blacklist another IR Droid device

Serge Semin (3):
      usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
      usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
      usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression

Sriharsha Allenki (1):
      usb: gadget: Fix spinlock lockup on usb_function_deactivate

Tetsuo Handa (1):
      USB: cdc-wdm: Fix use after free in service_outstanding_interrupt().

Thinh Nguyen (2):
      usb: uas: Add PNY USB Portable SSD to unusual_uas
      usb: dwc3: gadget: Clear wait flag on dequeue

Wesley Cheng (1):
      usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup

Yang Yingliang (1):
      USB: gadget: legacy: fix return error code in acm_ms_bind()

Yu Kuai (1):
      usb: chipidea: ci_hdrc_imx: add missing put_device() call in usbmisc_get_init_data()

Zheng Zengkai (1):
      usb: dwc3: meson-g12a: disable clk on error handling path in probe

Zqiang (1):
      usb: gadget: function: printer: Fix a memory leak for interface descriptor

taehyun.cho (1):
      usb: gadget: enable super speed plus

 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   6 +-
 MAINTAINERS                                        |   2 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   6 +-
 drivers/usb/class/cdc-acm.c                        |   4 +
 drivers/usb/class/cdc-wdm.c                        |  16 ++-
 drivers/usb/class/usblp.c                          |  21 +++-
 drivers/usb/core/hcd.c                             |   8 +-
 drivers/usb/dwc3/core.h                            |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   2 +-
 drivers/usb/dwc3/gadget.c                          |  16 +--
 drivers/usb/dwc3/ulpi.c                            |  38 ++++---
 drivers/usb/gadget/Kconfig                         |   2 +
 drivers/usb/gadget/composite.c                     |  10 +-
 drivers/usb/gadget/configfs.c                      |  19 +++-
 drivers/usb/gadget/function/f_printer.c            |   1 +
 drivers/usb/gadget/function/f_uac2.c               |  69 +++++++++---
 drivers/usb/gadget/function/u_ether.c              |   9 +-
 drivers/usb/gadget/legacy/acm_ms.c                 |   4 +-
 drivers/usb/gadget/udc/Kconfig                     |   2 +-
 drivers/usb/gadget/udc/Makefile                    |   1 -
 drivers/usb/gadget/udc/core.c                      |   3 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |  35 ++++--
 drivers/usb/gadget/udc/fsl_mxc_udc.c               | 122 ---------------------
 drivers/usb/host/xhci.c                            |  24 ++--
 drivers/usb/misc/yurex.c                           |   3 +
 drivers/usb/serial/iuu_phoenix.c                   |  20 +++-
 drivers/usb/serial/option.c                        |   3 +
 drivers/usb/storage/unusual_uas.h                  |   7 ++
 drivers/usb/typec/altmodes/Kconfig                 |   2 +-
 drivers/usb/typec/class.c                          |   2 +
 drivers/usb/typec/mux/intel_pmc_mux.c              |  11 ++
 drivers/usb/usbip/vhci_hcd.c                       |   2 +
 include/linux/kcov.h                               |  21 ++++
 33 files changed, 267 insertions(+), 225 deletions(-)
 delete mode 100644 drivers/usb/gadget/udc/fsl_mxc_udc.c
