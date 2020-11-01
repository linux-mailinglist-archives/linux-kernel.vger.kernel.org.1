Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1ED2A1E2F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgKANHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgKANHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:07:54 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F89208B6;
        Sun,  1 Nov 2020 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236073;
        bh=6wW6da8NV5Ji12C/+Ol0ymbD4lz0GyZ3uJRx/+gEQtw=;
        h=Date:From:To:Cc:Subject:From;
        b=mT+1t6b2zMbtiqz4p2bRLx1R7rE+SnDuzEvPCYtTEBr5P2SFgnq7dyIEdbmj8l0fS
         HePVDBDHY3n8ikkiwoGHZZvFv3iKA7cDSrNT6JWL6dWFt2nGq3qP1Q+soo4xWi3nZv
         r6iKdMPiTyHRXmYPiXGTGC2cupfoGD+JTH0NSE4E=
Date:   Sun, 1 Nov 2020 14:08:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.10-rc2
Message-ID: <20201101130836.GA4065915@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc2

for you to fetch changes up to 00c27a1df8ff5e99b383e2b4cbf947a4926fb534:

  Merge tag 'usb-v5.10-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-linus (2020-10-30 11:46:49 +0100)

----------------------------------------------------------------
USB driver fixes for 5.10-rc2

Here are a number of small bugfixes for reported issues in some USB
drivers.  They include:
	- typec bugfixes
	- xhci bugfixes and lockdep warning fixes
	- cdc-acm driver regression fix
	- kernel doc fixes
	- cdns3 driver bugfixes for a bunch of reported issues
	- other tiny USB driver fixes

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amelie Delaunay (2):
      usb: typec: add missing MODULE_DEVICE_TABLE() to stusb160x
      usb: typec: stusb160x: fix signedness comparison issue with enum variables

Bastien Nocera (2):
      usbcore: Check both id_table and match() when both available
      USB: apple-mfi-fastcharge: don't probe unhandled devices

Colin Ian King (1):
      xhci: Fix sizeof() mismatch

Dan Carpenter (2):
      usb: typec: stusb160x: fix some signedness bugs
      usb: typec: stusb160x: fix an IS_ERR() vs NULL check in probe

Greg Kroah-Hartman (1):
      Merge tag 'usb-v5.10-rc2' of git://git.kernel.org/.../peter.chen/usb into usb-linus

Jerome Brunet (1):
      usb: cdc-acm: fix cooldown mechanism

Li Jun (1):
      usb: typec: tcpm: reset hard_reset_count for any disconnect

Mathias Nyman (1):
      xhci: Don't create stream debugfs files with spinlock held.

Mauro Carvalho Chehab (1):
      usb: fix kernel-doc markups

Pawel Laszczak (2):
      usb: cdns3: Variable 'length' set but not used
      usb: cdns3: Fix on-chip memory overflow issue

Peter Chen (2):
      usb: cdns3: gadget: suspicious implicit sign extension
      usb: cdns3: gadget: own the lock wrongly at the suspend routine

Ran Wang (1):
      usb: host: fsl-mph-dr-of: check return of dma_set_mask()

Sandeep Singh (1):
      usb: xhci: Workaround for S3 issue on AMD SNPS 3.0 xHC

Tang Bin (1):
      usb: host: ehci-tegra: Fix error handling in tegra_ehci_probe()

 drivers/usb/cdns3/ep0.c                 |  65 +++++++++---------
 drivers/usb/cdns3/gadget.c              | 115 ++++++++++++++++++--------------
 drivers/usb/cdns3/gadget.h              |   5 +-
 drivers/usb/class/cdc-acm.c             |  12 ++--
 drivers/usb/class/cdc-acm.h             |   3 +-
 drivers/usb/core/driver.c               |  30 ++++++---
 drivers/usb/core/generic.c              |   4 +-
 drivers/usb/core/usb.h                  |   2 +
 drivers/usb/dwc3/core.c                 |   2 +-
 drivers/usb/dwc3/core.h                 |   2 +-
 drivers/usb/gadget/composite.c          |   2 +-
 drivers/usb/host/ehci-tegra.c           |   4 +-
 drivers/usb/host/fsl-mph-dr-of.c        |   9 ++-
 drivers/usb/host/xhci-mem.c             |   4 +-
 drivers/usb/host/xhci-pci.c             |  17 +++++
 drivers/usb/host/xhci.c                 |   5 +-
 drivers/usb/host/xhci.h                 |   1 +
 drivers/usb/misc/apple-mfi-fastcharge.c |  17 +++--
 drivers/usb/typec/mux.c                 |   2 +-
 drivers/usb/typec/stusb160x.c           |  24 +++----
 drivers/usb/typec/tcpm/tcpm.c           |   6 +-
 include/linux/usb/composite.h           |   2 +-
 22 files changed, 195 insertions(+), 138 deletions(-)
