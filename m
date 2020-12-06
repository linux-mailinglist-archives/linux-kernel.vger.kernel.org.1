Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8072D2D0582
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgLFOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 09:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgLFOfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 09:35:03 -0500
Date:   Sun, 6 Dec 2020 15:35:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607265256;
        bh=K6Irs/gF8HG6nqADqyNd2Oa959DrEAgrcnR5z5p3yLs=;
        h=From:To:Cc:Subject:From;
        b=F60MB53XlO/DGY1s1g9hLAhVSZ1JejjPhN5GgJhD1Qsu83xqEfF9rugrV4ZNa7ehu
         wCAT9S1ap8h3iX5e2Ac/gwrCqyXp+A/kXNYG4ZnRIEmgSK2OPr1dOnjgyFWzyBmWde
         0AX9p2aaqLGPQAwATZDTPEXMXZ1af2BnDLnBd1n8=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.10-rc7
Message-ID: <X8zsMIpNKLSkS6ya@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc7

for you to fetch changes up to a4b98a7512f18534ce33a7e98e49115af59ffa00:

  usb: gadget: f_fs: Use local copy of descriptors for userspace copy (2020-12-04 16:09:10 +0100)

----------------------------------------------------------------
USB fixes for 5.10-rc7

Here are some small USB fixes for 5.10-rc7 that resolve a number of
reported issues, and add some new device ids.

Nothing major here, but these solve some problems that people were
having with the 5.10-rc tree:
	- reverts for USB storage dma settings that broke working
	  devices
	- thunderbolt use-after-free fix
	- cdns3 driver fixes
	- gadget driver userspace copy fix
	- new device ids

All of these except for the reverts have been in linux-next with no
reported issues.  The reverts are "clean" and were tested by Hans, as
well as passing the 0-day tests.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bjørn Mork (1):
      USB: serial: option: fix Quectel BG96 matching

Giacinto Cifelli (1):
      USB: serial: option: add support for Thales Cinterion EXS82

Greg Kroah-Hartman (6):
      Merge tag 'usb-fixes-v5.10-rc6' of git://git.kernel.org/.../peter.chen/usb into usb-linus
      Merge tag 'thunderbolt-for-v5.10-rc7' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-5.10-rc7' of https://git.kernel.org/.../johan/usb-serial into usb-linus
      Revert "uas: bump hw_max_sectors to 2048 blocks for SS or faster drives"
      Revert "uas: fix sdev->host->dma_dev"
      Revert "usb-storage: fix sdev->host->dma_dev"

Jan-Niklas Burfeind (1):
      USB: serial: ch341: add new Product ID for CH341A

Johan Hovold (2):
      USB: serial: ch341: sort device-id entries
      USB: serial: kl5kusb105: fix memleak on open

Linus Walleij (1):
      usb: ohci-omap: Fix descriptor conversion

Mika Westerberg (1):
      thunderbolt: Fix use-after-free in remove_unplugged_switch()

Peter Chen (2):
      usb: cdns3: gadget: clear trb->length as zero after preparing every trb
      usb: cdns3: core: fix goto label for error path

Roger Quadros (1):
      usb: cdns3: Fix hardware based role switch

Vamsi Krishna Samavedam (1):
      usb: gadget: f_fs: Use local copy of descriptors for userspace copy

Vincent Palatin (1):
      USB: serial: option: add Fibocom NL668 variants

 arch/arm/mach-omap1/board-osk.c    |  2 +-
 drivers/thunderbolt/icm.c          | 10 +++++++---
 drivers/usb/cdns3/core.c           | 29 ++++++++++++++++-------------
 drivers/usb/cdns3/gadget.c         |  1 +
 drivers/usb/gadget/function/f_fs.c |  6 ++++--
 drivers/usb/host/ohci-omap.c       |  4 ++--
 drivers/usb/serial/ch341.c         |  5 +++--
 drivers/usb/serial/kl5kusb105.c    | 10 ++++------
 drivers/usb/serial/option.c        | 10 ++++++----
 drivers/usb/storage/scsiglue.c     |  2 +-
 drivers/usb/storage/uas.c          | 19 ++++++-------------
 drivers/usb/storage/usb.c          |  5 ++---
 12 files changed, 53 insertions(+), 50 deletions(-)
