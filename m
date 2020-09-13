Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033D7267EBC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgIMIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgIMIib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:38:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429AF207C3;
        Sun, 13 Sep 2020 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599986310;
        bh=XIsK2T6IEfYK6oxzBICpOka54NDByIdBn1LtLGKiv/A=;
        h=Date:From:To:Cc:Subject:From;
        b=QdJ6bhpprt2ao/2TTSetwP/gUWjDBpwGFzhl8/jJnuwDCoSHTk1P1XalAJt54ACbD
         zKU5NxyGho3MNtGUy0VzD8bnwaGvVXi6Zyui5nKh261WfVvi0Jiv3DX/MZvSRROTdT
         mY8hE5/drx9hzoR6hDqVv0End0k7TBz2hYKrPquQ=
Date:   Sun, 13 Sep 2020 10:38:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.9-rc5
Message-ID: <20200913083832.GA906642@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc5

for you to fetch changes up to 952e934d7f682a961c92eb9bbd521a4876e201fe:

  Revert "dyndbg: accept query terms like file=bar and module=foo" (2020-09-10 18:45:03 +0200)

----------------------------------------------------------------
Char / Misc driver fixes for 5.9-rc5

Here are a number of small driver fixes for 5.9-rc5

Included in here are:
	- habanalabs driver fixes
	- interconnect driver fixes
	- soundwire driver fixes
	- dyndbg fixes for reported issues, and then reverts to fix it
	  all up to a sane state.
	- phy driver fixes
Full details of these are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (6):
      Merge tag 'misc-habanalabs-fixes-2020-08-31' of git://people.freedesktop.org/~gabbayo/linux into char-misc-nexxt
      Merge tag 'soundwire-5.9-fixes' of git://git.kernel.org/.../vkoul/soundwire into char-misc-linus
      Merge tag 'phy-fixes-5.9' of git://git.kernel.org/.../phy/linux-phy into char-misc-linus
      Merge tag 'icc-5.9-rc4' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-linus
      Revert "dyndbg: fix problem parsing format="foo bar""
      Revert "dyndbg: accept query terms like file=bar and module=foo"

Jim Cromie (3):
      dyndbg: give %3u width in pr-format, cosmetic only
      dyndbg: refine export, rename to dynamic_debug_exec_queries()
      dyndbg: fix problem parsing format="foo bar"

Matthias Kaehlcke (1):
      interconnect: Show bandwidth for disabled paths as zero in debugfs

Mike Tipton (1):
      interconnect: qcom: Fix small BW votes being truncated to zero

Moti Haimovski (1):
      habanalabs: prevent user buff overflow

Ofir Bitton (1):
      habanalabs: fix report of RAZWI initiator coordinates

Pierre-Louis Bossart (1):
      soundwire: bus: fix typo in comment on INTSTAT registers

Roger Quadros (1):
      phy: omap-usb2-phy: disable PHY charger detect

Rustam Kovhaev (1):
      scripts/tags.sh: exclude tools directory from tags generation

Sivaprakash Murugesan (1):
      phy: qcom-qmp: Use correct values for ipq8074 PCIe Gen2 PHY init

Tetsuo Handa (1):
      video: fbdev: fix OOB read in vga_8planes_imageblit()

Tom Rix (1):
      soundwire: fix double free of dangling pointer

Wei Yongjun (1):
      phy: qualcomm: fix return value check in qcom_ipq806x_usb_phy_probe()

YueHaibing (1):
      phy: qualcomm: fix platform_no_drv_owner.cocci warnings

 Documentation/admin-guide/dynamic-debug-howto.rst  |  1 -
 drivers/interconnect/core.c                        | 10 ++-
 drivers/interconnect/qcom/bcm-voter.c              | 27 ++++---
 drivers/misc/habanalabs/common/debugfs.c           |  2 +-
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    | 32 ++++-----
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        |  5 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 16 +++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 +
 drivers/phy/ti/phy-omap-usb2.c                     | 47 +++++++++++--
 drivers/soundwire/bus.c                            |  2 +-
 drivers/soundwire/stream.c                         |  8 ++-
 drivers/video/fbdev/vga16fb.c                      |  2 +-
 include/linux/dynamic_debug.h                      | 20 ++++--
 lib/dynamic_debug.c                                | 82 ++++++++++++----------
 scripts/tags.sh                                    |  8 ++-
 15 files changed, 172 insertions(+), 92 deletions(-)
