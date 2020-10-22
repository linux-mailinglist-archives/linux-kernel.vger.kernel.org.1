Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F65295833
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503167AbgJVGBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438274AbgJVGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:01:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D91EC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 23:01:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVTfE-005zm1-V8; Thu, 22 Oct 2020 06:01:29 +0000
Date:   Thu, 22 Oct 2020 07:01:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git set_fs pile
Message-ID: <20201022060128.GS3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Christoph's set_fs base series + fixups.  A few trivial conflicts
(arch/{ia64,m68k/s390}/Kconfig and arch/x86/lib/getuser.S); proposed
resolution in #merge-candidate, same as in -next.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.set_fs

for you to fetch changes up to 7b84b665c874f60d84547635341e418f20cbbab2:

  fs: Allow a NULL pos pointer to __kernel_read (2020-10-15 14:20:42 -0400)

----------------------------------------------------------------
Christoph Hellwig (13):
      proc: remove a level of indentation in proc_get_inode
      proc: cleanup the compat vs no compat file ops
      proc: add a read_iter method to proc proc_ops
      fs: don't allow kernel reads and writes without iter ops
      fs: don't allow splice read/write without explicit ops
      uaccess: add infrastructure for kernel builds with set_fs()
      test_bitmap: remove user bitmap tests
      lkdtm: remove set_fs-based tests
      x86: move PAGE_OFFSET, TASK_SIZE & friends to page_{32,64}_types.h
      x86: make TASK_SIZE_MAX usable from assembly code
      x86: remove address space overrides using set_fs()
      powerpc: use non-set_fs based maccess routines
      powerpc: remove address space overrides using set_fs()

Matthew Wilcox (Oracle) (3):
      sysctl: Convert to iter interfaces
      fs: Allow a NULL pos pointer to __kernel_write
      fs: Allow a NULL pos pointer to __kernel_read

 arch/Kconfig                            |   3 +
 arch/alpha/Kconfig                      |   1 +
 arch/arc/Kconfig                        |   1 +
 arch/arm/Kconfig                        |   1 +
 arch/arm64/Kconfig                      |   1 +
 arch/c6x/Kconfig                        |   1 +
 arch/csky/Kconfig                       |   1 +
 arch/h8300/Kconfig                      |   1 +
 arch/hexagon/Kconfig                    |   1 +
 arch/ia64/Kconfig                       |   1 +
 arch/m68k/Kconfig                       |   1 +
 arch/microblaze/Kconfig                 |   1 +
 arch/mips/Kconfig                       |   1 +
 arch/nds32/Kconfig                      |   1 +
 arch/nios2/Kconfig                      |   1 +
 arch/openrisc/Kconfig                   |   1 +
 arch/parisc/Kconfig                     |   1 +
 arch/powerpc/include/asm/processor.h    |   7 --
 arch/powerpc/include/asm/thread_info.h  |   5 +-
 arch/powerpc/include/asm/uaccess.h      |  67 ++++++----------
 arch/powerpc/kernel/signal.c            |   3 -
 arch/powerpc/lib/sstep.c                |   6 +-
 arch/riscv/Kconfig                      |   1 +
 arch/s390/Kconfig                       |   1 +
 arch/sh/Kconfig                         |   1 +
 arch/sparc/Kconfig                      |   1 +
 arch/um/Kconfig                         |   1 +
 arch/x86/ia32/ia32_aout.c               |   1 -
 arch/x86/include/asm/page_32_types.h    |  11 +++
 arch/x86/include/asm/page_64_types.h    |  38 ++++++++++
 arch/x86/include/asm/processor.h        |  60 +--------------
 arch/x86/include/asm/thread_info.h      |   2 -
 arch/x86/include/asm/uaccess.h          |  26 +------
 arch/x86/kernel/asm-offsets.c           |   3 -
 arch/x86/lib/getuser.S                  |  47 ++++++------
 arch/x86/lib/putuser.S                  |  25 +++---
 arch/xtensa/Kconfig                     |   1 +
 drivers/misc/lkdtm/bugs.c               |  10 ---
 drivers/misc/lkdtm/core.c               |   2 -
 drivers/misc/lkdtm/lkdtm.h              |   2 -
 drivers/misc/lkdtm/usercopy.c           |  15 ----
 fs/proc/inode.c                         | 119 ++++++++++++++++++++---------
 fs/proc/proc_sysctl.c                   |  48 ++++++------
 fs/read_write.c                         |  71 ++++++++++-------
 fs/splice.c                             | 130 ++++----------------------------
 include/linux/bpf-cgroup.h              |   2 +-
 include/linux/fs.h                      |   2 -
 include/linux/proc_fs.h                 |   1 +
 include/linux/uaccess.h                 |  18 +++++
 kernel/bpf/cgroup.c                     |   2 +-
 lib/test_bitmap.c                       |  91 ++++++----------------
 tools/testing/selftests/lkdtm/tests.txt |   2 -
 52 files changed, 346 insertions(+), 495 deletions(-)
