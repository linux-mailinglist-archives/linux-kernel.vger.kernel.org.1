Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C82B3541
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 15:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKOO2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 09:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgKOO2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 09:28:46 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E120622447;
        Sun, 15 Nov 2020 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605450526;
        bh=VIOAT0Yd79uwQbHpg2AFcvasZwOqziw2wsAsk4qzqjU=;
        h=Date:From:To:Cc:Subject:From;
        b=YuYvNymnPppbxEQZYOxdXJIk3UivJEV/WmRYenfln4Lq2RYQfbZLbZQdxE5ejbOcG
         ZeE9wr1jwXj8lRPNTSnG7YIlaiKCAXA9DcEBSgd62KjZ6/HGx5tgGwYAu6xkAnIxkN
         ipc/fIOTaMiTeFwBvzeGUo8bzhgWI381gyREGL7M=
Date:   Sun, 15 Nov 2020 15:29:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver fixes for 5.10-rc4
Message-ID: <X7E7UiresGDdG1P1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc4

for you to fetch changes up to 6d853c9e4104b4fc8d55dc9cd3b99712aa347174:

  usb: cdc-acm: Add DISABLE_ECHO for Renesas USB Download mode (2020-11-13 15:26:49 +0100)

----------------------------------------------------------------
USB/Thunderbolt fixes for 5.10-rc4

Here are some small Thunderbolt and USB driver fixes for 5.10-rc4 to
solve some reported issues.

Nothing huge in here, just small things:
	- thunderbolt memory leaks fixed and new device ids added
	- revert of problem patch for the musb driver
	- new quirks added for USB devices
	- typec power supply fixes to resolve much reported problems
	  about charging notifications not working anymore

All except the cdc-acm driver quirk addition have been in linux-next
with no reported issues (the quirk patch was applied on Friday, and is
self-contained.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrey Konovalov (1):
      MAINTAINERS: add usb raw gadget entry

Casey Bowman (1):
      thunderbolt: Add uaccess dependency to debugfs interface

Chris Brandt (1):
      usb: cdc-acm: Add DISABLE_ECHO for Renesas USB Download mode

Geert Uytterhoeven (1):
      Revert "usb: musb: convert to devm_platform_ioremap_resource_byname"

Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v5.10-rc4' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus

Heikki Krogerus (1):
      usb: typec: ucsi: Report power supply changes

Jing Xiangfeng (1):
      thunderbolt: Add the missed ida_simple_remove() in ring_request_msix()

Mika Westerberg (3):
      thunderbolt: Fix memory leak if ida_simple_get() fails in enumerate_services()
      thunderbolt: Only configure USB4 wake for lane 0 adapters
      thunderbolt: Add support for Intel Tiger Lake-H

Zhang Qilong (1):
      xhci: hisilicon: fix refercence leak in xhci_histb_probe

 MAINTAINERS                   |  8 ++++++++
 drivers/thunderbolt/debugfs.c |  1 +
 drivers/thunderbolt/icm.c     |  2 ++
 drivers/thunderbolt/nhi.c     | 23 +++++++++++++++++++----
 drivers/thunderbolt/nhi.h     |  2 ++
 drivers/thunderbolt/tb.h      |  2 ++
 drivers/thunderbolt/usb4.c    |  4 ++++
 drivers/thunderbolt/xdomain.c |  1 +
 drivers/usb/class/cdc-acm.c   |  9 +++++++++
 drivers/usb/host/xhci-histb.c |  2 +-
 drivers/usb/musb/musb_dsps.c  |  4 +++-
 drivers/usb/typec/ucsi/psy.c  |  9 +++++++++
 drivers/usb/typec/ucsi/ucsi.c |  7 ++++++-
 drivers/usb/typec/ucsi/ucsi.h |  2 ++
 14 files changed, 69 insertions(+), 7 deletions(-)
