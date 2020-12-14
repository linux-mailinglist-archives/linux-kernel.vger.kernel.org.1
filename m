Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC92D9557
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgLNJdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgLNJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:33:25 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:32:44 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id 49Yh2400R4C55Sk069YhWD; Mon, 14 Dec 2020 10:32:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kokDh-00ATA1-7L; Mon, 14 Dec 2020 10:32:41 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kokDg-003SXO-D3; Mon, 14 Dec 2020 10:32:40 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.11
Date:   Mon, 14 Dec 2020 10:32:37 +0100
Message-Id: <20201214093237.824639-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.11-tag1

for you to fetch changes up to 2ae92e8b9b7eb042ccb7e9fc7ea9431f211a1bd3:

  MAINTAINERS: Update m68k Mac entry (2020-12-07 10:48:16 +0100)

----------------------------------------------------------------
m68k updates for v5.11

  - Fix WARNING splat in pmac_zilog driver,
  - Fix ADB input device regression,
  - Assume maintainership for adb-iop and via-macii,
  - Minor fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Arnd Bergmann (1):
      m68k: Avoid xchg() warning

Finn Thain (8):
      m68k: mac: Refactor iop_preinit() and iop_init()
      m68k: mac: Remove dead code
      m68k: mac: Remove redundant VIA register writes
      m68k: mac: Update Kconfig help
      m68k: Fix WARNING splat in pmac_zilog driver
      macintosh/adb-iop: Always wait for reply message from IOP
      macintosh/adb-iop: Send correct poll command
      MAINTAINERS: Update m68k Mac entry

Geert Uytterhoeven (2):
      m68k: defconfig: Update defconfigs for v5.10-rc1
      m68k: defconfig: Enable KUnit tests

Laurent Vivier (1):
      m68k: Remove unused mach_max_dma_address

Youling Tang (2):
      m68k: Drop redundant NOTES in link script
      m68k: Add a missing ELF_DETAILS in link script

 MAINTAINERS                          |  2 ++
 arch/m68k/Kconfig.machine            |  8 ++----
 arch/m68k/amiga/config.c             |  8 ------
 arch/m68k/apollo/config.c            |  1 -
 arch/m68k/atari/config.c             |  1 -
 arch/m68k/bvme6000/config.c          |  1 -
 arch/m68k/configs/amiga_defconfig    |  9 ++++--
 arch/m68k/configs/apollo_defconfig   |  9 ++++--
 arch/m68k/configs/atari_defconfig    |  9 ++++--
 arch/m68k/configs/bvme6000_defconfig |  9 ++++--
 arch/m68k/configs/hp300_defconfig    |  9 ++++--
 arch/m68k/configs/mac_defconfig      |  9 ++++--
 arch/m68k/configs/multi_defconfig    |  9 ++++--
 arch/m68k/configs/mvme147_defconfig  |  9 ++++--
 arch/m68k/configs/mvme16x_defconfig  |  9 ++++--
 arch/m68k/configs/q40_defconfig      |  9 ++++--
 arch/m68k/configs/sun3_defconfig     |  9 ++++--
 arch/m68k/configs/sun3x_defconfig    |  9 ++++--
 arch/m68k/hp300/config.c             |  1 -
 arch/m68k/include/asm/cmpxchg.h      | 10 +++----
 arch/m68k/include/asm/machdep.h      |  1 -
 arch/m68k/kernel/setup_mm.c          |  1 -
 arch/m68k/kernel/vmlinux-nommu.lds   |  3 +-
 arch/m68k/kernel/vmlinux-std.lds     |  3 +-
 arch/m68k/kernel/vmlinux-sun3.lds    |  2 +-
 arch/m68k/mac/config.c               | 26 ++++++-----------
 arch/m68k/mac/iop.c                  | 54 ++++++++++++----------------------
 arch/m68k/mac/via.c                  | 21 --------------
 arch/m68k/mvme147/config.c           |  1 -
 arch/m68k/mvme16x/config.c           |  1 -
 arch/m68k/q40/config.c               |  5 ----
 arch/m68k/sun3x/config.c             |  2 --
 drivers/macintosh/adb-iop.c          | 56 ++++++++++++++++++++++++------------
 drivers/tty/serial/pmac_zilog.c      | 14 +++++----
 34 files changed, 171 insertions(+), 159 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
