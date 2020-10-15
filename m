Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8244A28ED7E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgJOHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:20:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:35557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgJOHUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602746429;
        bh=TjiKD1ybPL6RrFzpezKiT7e3LIZK2s89ZT0rhem0VNI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=DSY1VpbsHU4vzMPW3ATSdd0fv0LZ7TQzee9x+ofiRLWDpG83+k696JcAow8bzdmL7
         OqKAPFgZxzSCOy0M6Aie4rqt6imromv+2S2YoInFfyJunI4ZIrm6z96Iegibc1XgOA
         kzp8OzBGQE+yPBKiIW3j/hs8N7xuhuEOGUZ6AohY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.190.52]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1knVFI0pZF-00NOPG; Thu, 15
 Oct 2020 09:20:29 +0200
Date:   Thu, 15 Oct 2020 09:20:25 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.10-rc1
Message-ID: <20201015072025.GA18655@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:X5dmF/O+HVchxB+VN4KvmQSqOdxwWeR5H5zn5Ta+pDuzx3I8oNS
 sy3pWi/NiJ0My43vH3H9uSY3njPb0cQdgNDlFL+anDNkE5EoB5fex7ygsXmMdRag/6txy9v
 h84XRhWe/B4mHeDUy7Yi3pSzf/cbscE8EU5EwmJKpSzQnal4IHTphjrMon2CMTyIGExiKXd
 TzODdcWjtyaIc560B8Rww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xwih3ZKuynI=:R6YMSQHj9vjnZR5w8u434S
 oDssbDnFocbgPl1JJrRVbQcvgEZxrDzItZbzoDNJMs94gY5f+/TlXthU1GNyOBQc8IgssLGJU
 zjwx17ATIWotZ9EcN9fyIAJXG5Sl4ZH4NUCzpXaQbSZbRkbelmBa0X27lk4nmR6LPXF9a41AN
 MoGCsS6RmkxqaQ2/NhugpLDQMawYRTz3zDSNWI46TI8UDf5nOZJtQ9kgMOf4c5DN3xtEuwGRI
 pScPfMrUWuwd93glHwSJpx8r9fnGDxEJ6Cy4v+CXoQ/yEgZiLvG0WqhpnBYF7nDBp5GFFSGqF
 CFg60rOYfFIt5jZS6KR6EDmTkI1uAj5kJuAst2A7zbTi+MmjsQ+iG+Tg7L6dPxpkO0geMd16G
 yjCK1fMzYFqhtSu4p5p1B7qlpRrzzpfiOkcLovvfU9A0zlqCKq1dFIUCHAXq/qB4escibJj7Q
 eCE1SzcSho9JME8YMQHm1Y8bYQgFrvH9U1cuooKxhIxf2X0JzO1dUuqAO9oinKUIbhqJOuaHU
 qQJIWvtVZ3+RZXWBM1kE0vk3Otp3HffpqpB5MEAzXX1DsjyJWJ66xWaMZQx1Sva6jDsw34jMN
 pRvQX98+42LWQCXXD1geQPfw5KBOLmOhTq3GGF8MnEOS874ZBwxcV/8P4EpfSTYvWe2Ue3AfJ
 Hp1mIfm+viWBOp2HHEk54S0sgLboD+lGlXM1bMOmGTvutQYug1H1CXF7bk/woM7rFKBhOB/tD
 9b9cMLwMRcTAJcjvAqRvDAw/RFf+0tUNeoxIHBdkzMI/25xqe7llrsRhAEsIqnTAoTMRsQzPT
 5MdDbNi341O5wFIizxXzQVKLiFAdJn54Ogn1sP59IjPaC/Jop04RIMwaIumxg08TbnDbVpd1w
 TkYZ/r7yRgZr12HYwBAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the fixes and updates for the parisc architecture for kernel 5.10-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.10-1

This patchset includes:
* Added fw_cfg support for parisc on qemu
* Added font support in sti text console driver for byte- and word-mode ROMs
* Switch to more fine grained lws locks and improve spinlock handling
* Add ioread64_hi_lo() and iowrite64_hi_lo() to avoid 0-day linking errors
* Mark pointers volatile in __xchg8(), __xchg32() and __xchg64() to help compiler
* Header file cleanups, mostly removal of unused HP-UX compat defines
* Drop one bit from our O_NONBLOCK define to become now 000200000
* Add MAP_UNINITIALIZED define to avoid userspace compile errors
* Drop CONFIG_IDE from defconfigs
* Speed up synchronize_caches() on UP machines
* Rewrite tlb flush threshold calculation
* Comment fixes and cleanups

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 3e4fb4346c781068610d03c12b16c0cfb0fd24a3:

  Merge tag 'spdx-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx (2020-10-14 16:19:42 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.10-1

for you to fetch changes up to 7ff3f14ddc355bfbc94c766f43b90606b1f79e83:

  parisc/sticon: Add user font support (2020-10-15 08:12:59 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      parisc: disable CONFIG_IDE in defconfigs

Helge Deller (11):
      fw_cfg: Add support for parisc architecture
      parisc: Add qemu fw_cfg interface
      parisc: Avoid external interrupts when IPI finishes
      parisc: Drop HP-UX specific fcntl and signal flags
      parisc: Define O_NONBLOCK to become 000200000
      parisc: Drop useless comments in uapi/asm/signal.h
      parisc: Add ioread64_hi_lo() and iowrite64_hi_lo()
      parisc: Install vmlinuz instead of zImage file
      parisc: Add MAP_UNINITIALIZED define
      parisc/sticon: Always register sticon console driver
      parisc/sticon: Add user font support

John David Anglin (6):
      parisc: Add alternative patching to synchronize_caches define
      parisc: Fix comments and enable interrupts later
      parisc: Mark pointers volatile in __xchg8(), __xchg32() and __xchg64()
      parisc: Switch to more fine grained lws locks
      parisc: Rewrite tlb flush threshold calculation
      parisc: Improve spinlock handling

 arch/parisc/Kconfig                         |   1 +
 arch/parisc/configs/generic-32bit_defconfig |   6 +-
 arch/parisc/configs/generic-64bit_defconfig |   6 +-
 arch/parisc/include/asm/barrier.h           |   6 +-
 arch/parisc/include/asm/cmpxchg.h           |  14 +-
 arch/parisc/include/asm/futex.h             |   4 +-
 arch/parisc/include/asm/socket.h            |   4 +-
 arch/parisc/include/asm/spinlock.h          |  23 ++-
 arch/parisc/include/uapi/asm/fcntl.h        |   7 +-
 arch/parisc/include/uapi/asm/mman.h         |   1 +
 arch/parisc/include/uapi/asm/signal.h       |   5 +-
 arch/parisc/install.sh                      |   2 +-
 arch/parisc/kernel/cache.c                  |  18 +-
 arch/parisc/kernel/entry.S                  |  14 +-
 arch/parisc/kernel/inventory.c              |  30 +++
 arch/parisc/kernel/smp.c                    |   9 +-
 arch/parisc/kernel/syscall.S                |  10 +-
 arch/parisc/lib/bitops.c                    |   6 +-
 arch/parisc/lib/iomap.c                     |  18 ++
 drivers/firmware/Kconfig                    |   2 +-
 drivers/firmware/qemu_fw_cfg.c              |   3 +
 drivers/video/console/Kconfig               |   1 +
 drivers/video/console/sticon.c              | 297 ++++++++++++++++------------
 drivers/video/console/sticore.c             | 284 +++++++++++++-------------
 drivers/video/fbdev/sticore.h               |  27 ++-
 tools/arch/parisc/include/uapi/asm/mman.h   |   1 -
 26 files changed, 453 insertions(+), 346 deletions(-)
