Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501EC301BEF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhAXM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbhAXM6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:58:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C71D22D2C;
        Sun, 24 Jan 2021 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611493040;
        bh=ORrbIoAKONfrwMn2ANs/UF4XGznpuxl1SFQQAMy3ouo=;
        h=Date:From:To:Cc:Subject:From;
        b=DIYzk3hweqsPdltdYuU/tGhjen9sk5pji3bNDcSMwZavkCRazcRQ3/Px5k/lDgj5q
         TXVS48TfCOj56c/mknceccRIHTj+yTQUhivzSwmamW5+EpcriT7u2/dsJX9EsV1jWD
         +zKLtZqVOjCkRPiXOjs9P65Wz966gK8xPkvQpPYQ=
Date:   Sun, 24 Jan 2021 13:57:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.11-rc5
Message-ID: <YA1urjFySDgiW7QE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc5

for you to fetch changes up to ef02684c4e67d8c35ac83083564135bc7b1d3445:

  usb: bdc: Make bdc pci driver depend on BROKEN (2021-01-19 14:10:46 +0100)

----------------------------------------------------------------
USB fixes for 5.11-rc5

Here are some small USB driver fixes for 5.11-rc5.  They resolve:
	- xhci issues for some reported problems
	- ehci driver issue for one specific device
	- USB gadget fixes for some reported problems
	- cdns3 driver fixes for issues reported
	- MAINTAINERS file update
	- thunderbolt minor fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: gadget: dummy-hcd: Fix errors in port-reset handling

Eugene Korenevsky (1):
      ehci: fix EHCI host controller initialization sequence

Greg Kroah-Hartman (2):
      Merge tag 'usb-v5.11-rc3' of git://git.kernel.org/.../peter.chen/usb into usb-linus
      Merge tag 'thunderbolt-for-v5.11-rc4' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus

JC Kuo (1):
      xhci: tegra: Delay for disabling LFPS detector

Longfang Liu (1):
      USB: ehci: fix an interrupt calltrace error

Mathias Nyman (1):
      xhci: make sure TRB is fully written before giving it to the controller

Mika Westerberg (1):
      thunderbolt: Drop duplicated 0x prefix from format string

Patrik Jakobsson (1):
      usb: bdc: Make bdc pci driver depend on BROKEN

Peter Chen (4):
      usb: cdns3: imx: fix writing read-only memory issue
      usb: cdns3: imx: fix can't create core device the second time issue
      usb: cdns3: imx: improve driver .remove API
      MAINTAINERS: update Peter Chen's email address

Roger Quadros (1):
      MAINTAINERS: Update address for Cadence USB3 driver

Ryan Chen (1):
      usb: gadget: aspeed: fix stop dma register setting.

Thinh Nguyen (1):
      usb: udc: core: Use lock when write to soft_connect

 MAINTAINERS                              |  6 +++---
 drivers/thunderbolt/icm.c                |  2 +-
 drivers/usb/cdns3/cdns3-imx.c            | 22 +++++++++++-----------
 drivers/usb/gadget/udc/aspeed-vhub/epn.c |  5 ++++-
 drivers/usb/gadget/udc/bdc/Kconfig       |  2 +-
 drivers/usb/gadget/udc/core.c            | 13 ++++++++++---
 drivers/usb/gadget/udc/dummy_hcd.c       | 10 +++++++---
 drivers/usb/host/ehci-hcd.c              | 12 ++++++++++++
 drivers/usb/host/ehci-hub.c              |  3 +++
 drivers/usb/host/xhci-ring.c             |  2 ++
 drivers/usb/host/xhci-tegra.c            |  7 +++++++
 11 files changed, 61 insertions(+), 23 deletions(-)
