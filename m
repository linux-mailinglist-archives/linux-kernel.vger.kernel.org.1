Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D92C710D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391280AbgK1Vwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732557AbgK1TB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:01:59 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A37921527;
        Sat, 28 Nov 2020 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606566108;
        bh=Y0VLObZ7sDlZQU5Lu7IdF+WlaG5/Eqs/1V2TqTBE1rQ=;
        h=Date:From:To:Cc:Subject:From;
        b=kyzT9BRp074TPB7Lg53SGB10AYY8MYgf1+NR647LFyvKAOycbRxMMdYd035YapKrz
         /JN69x1tr0xqkntq/9qAgNvX7SjXIieWpJXgtr0v7kW+TneVJ/xFMMyhGhKqHIsrog
         NPV0eBpsbR4BOsBJy5RiGnmOAaFPq/sTNR/zYiXw=
Date:   Sat, 28 Nov 2020 13:22:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver fixes for 5.10-rc6
Message-ID: <X8JBIBWUEgxr1lSY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc6

for you to fetch changes up to 484cfbe5fb61469a5f5a276258a8b3973164b56f:

  usb: typec: stusb160x: fix power-opmode property with typec-power-opmode (2020-11-27 14:44:26 +0100)

----------------------------------------------------------------
USB / PHY driver fixes for 5.10-rc6

Here are a few small USB and PHY driver fixes for 5.10-rc6.  They
include:
  - small PHY driver fixes to resolve reported issues
  - USB quirks added for "broken" devices
  - typec fixes for reported problems
  - USB gadget fixes for small issues

Full details are in the shortlog, nothing major in here and all have
been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (1):
      phy: usb: Fix incorrect clearing of tca_drv_sel bit in SETUP reg for 7211

Alan Stern (2):
      USB: core: Fix regression in Hercules audio card
      USB: core: Change %pK for __user pointers to %px

Amelie Delaunay (1):
      usb: typec: stusb160x: fix power-opmode property with typec-power-opmode

Bryan O'Donoghue (2):
      phy: qualcomm: usb: Fix SuperSpeed PHY OF dependency
      phy: qualcomm: Fix 28 nm Hi-Speed USB PHY OF dependency

Colin Ian King (1):
      phy: mediatek: fix spelling mistake in Kconfig "veriosn" -> "version"

Geert Uytterhoeven (1):
      phy: intel: PHY_INTEL_KEEMBAY_EMMC should depend on ARCH_KEEMBAY

Greg Kroah-Hartman (2):
      Merge tag 'usb-fixes-v5.10-rc5' of git://git.kernel.org/.../peter.chen/usb into usb-linus
      Merge tag 'phy-fixes-5.10' of git://git.kernel.org/.../phy/linux-phy into usb-linus

Marc Zyngier (1):
      phy: tegra: xusb: Fix dangling pointer on probe failure

Peter Chen (2):
      usb: cdns3: gadget: initialize link_trb as NULL
      usb: cdns3: gadget: calculate TD_SIZE based on TD

Randy Dunlap (1):
      usb: typec: qcom-pmic-typec: fix builtin build errors

Stephen Boyd (1):
      phy: qcom-qmp: Initialize another pointer to NULL

Zhang Qilong (2):
      usb: gadget: f_midi: Fix memleak in f_midi_alloc
      usb: gadget: Fix memleak in gadgetfs_fill_super

Zou Wei (1):
      phy: cpcap-usb: Use IRQF_ONESHOT

penghao (1):
      USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for Lenovo A630Z TIO built-in usb-audio card

 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c |  5 -----
 drivers/phy/intel/Kconfig                         |  2 +-
 drivers/phy/mediatek/Kconfig                      |  2 +-
 drivers/phy/motorola/phy-cpcap-usb.c              |  3 ++-
 drivers/phy/qualcomm/Kconfig                      |  4 ++--
 drivers/phy/qualcomm/phy-qcom-qmp.c               |  2 +-
 drivers/phy/tegra/xusb.c                          |  1 +
 drivers/usb/cdns3/gadget.c                        | 26 ++++++++++++-----------
 drivers/usb/core/devio.c                          | 14 ++++++------
 drivers/usb/core/quirks.c                         | 10 +++++++++
 drivers/usb/gadget/function/f_midi.c              | 10 ++++++---
 drivers/usb/gadget/legacy/inode.c                 |  3 +++
 drivers/usb/typec/Kconfig                         |  1 +
 drivers/usb/typec/stusb160x.c                     |  2 +-
 14 files changed, 51 insertions(+), 34 deletions(-)
