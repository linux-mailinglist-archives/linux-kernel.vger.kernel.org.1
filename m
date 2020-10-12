Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5028B463
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgJLMJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgJLMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:09:09 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229C4C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:09:08 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id f0952300w4C55Sk06095aF; Mon, 12 Oct 2020 14:09:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kRwdV-0005XZ-NS; Mon, 12 Oct 2020 14:09:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kRwdV-0003OP-Kn; Mon, 12 Oct 2020 14:09:05 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.10
Date:   Mon, 12 Oct 2020 14:09:04 +0200
Message-Id: <20201012120904.12998-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.10-tag1

for you to fetch changes up to 50c5feeea0af99a4401fd54fd72bec1333a496ca:

  ide/macide: Convert Mac IDE driver to platform driver (2020-09-28 10:48:17 +0200)

----------------------------------------------------------------
m68k updates for v5.10

  - Conversion of the Mac IDE driver to a platform driver,
  - Minor cleanups and fixes.

Thanks for pulling!

----------------------------------------------------------------
Alexander A. Klimov (1):
      m68k: Replace HTTP links with HTTPS ones

Christoph Hellwig (1):
      m68k: Use get_kernel_nofault() in show_registers()

Finn Thain (2):
      m68k: Correct some typos in comments
      ide/macide: Convert Mac IDE driver to platform driver

Geert Uytterhoeven (7):
      m68k: amiga: Fix Denise detection on OCS
      zorro: Fix address space collision message with RAM expansion boards
      m68k: Revive _TIF_* masks
      m68k: amiga: Clean up Amiga hardware configuration
      m68k: Sort selects in main Kconfig
      m68k: mm: Use PAGE_ALIGNED() helper
      m68k: mm: Remove superfluous memblock_alloc*() casts

 arch/m68k/Kconfig                   |  24 ++++----
 arch/m68k/amiga/config.c            | 118 ++++++++++++++++++------------------
 arch/m68k/configs/mac_defconfig     |   1 +
 arch/m68k/configs/multi_defconfig   |   1 +
 arch/m68k/include/asm/thread_info.h |   8 +++
 arch/m68k/kernel/head.S             |  16 ++---
 arch/m68k/kernel/traps.c            |   5 +-
 arch/m68k/mac/config.c              |  41 +++++++++++++
 arch/m68k/mac/macboing.c            |   2 +-
 arch/m68k/mm/mcfmmu.c               |   2 +-
 arch/m68k/mm/motorola.c             |   9 ++-
 drivers/ide/Kconfig                 |   7 ++-
 drivers/ide/macide.c                |  66 +++++++++++++-------
 drivers/zorro/zorro.c               |   2 +-
 14 files changed, 184 insertions(+), 118 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
