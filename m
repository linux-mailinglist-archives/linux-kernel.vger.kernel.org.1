Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A18297AE2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 07:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759555AbgJXFNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 01:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgJXFNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 01:13:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012FBC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 22:13:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id az3so335440pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=FyIsB+gaIcHxAQo0rZx0L2tAsyceupiqK9XkzWHDLMc=;
        b=L8BR2WhnzckT0m5aJ2aziY/2sezjG6V4vvxTR2ESbuEPjQpo4d5cdvEk3NnGhDBrGV
         5181WmnG94aj9yAZ/Z/YYDieUsQDwZyVwzpVdWdvR21qhWuqZb1QsUN/D94ZjGUv0JDH
         Yx/INTBKLLTgFpyOnoys3oQ4Jh4s/GXVXSmMnzoKRjhkgDC2NxbvsaXL32R9u46zpIV4
         qj0AbCj6Qyzh+839aCLQcydRpCaO7j+5JLvD3ZszS7x6glkLLH4DmcNkTdcUktvz4S2Z
         XBtguqvu6GFnVOOEh6muyb7+7UZXP4UPPDKB7nN7d9E71szPEz92xHm6cM3hBK9mZ/me
         oG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=FyIsB+gaIcHxAQo0rZx0L2tAsyceupiqK9XkzWHDLMc=;
        b=NyGVMAqE3GfIeLayTet3TcK+X83uqu0lRr4FMd5fesbqekni1z7FkXT3Rsk6qyaS70
         5xuqSr1frHeIgm1rl1ATB626AuiJj0kXBLdXL0Z1g/hDqDvf/W1iDyVh11FY7+9MQT9H
         Yb9/5yKZVVxy47PWvK8xYnOTJVdz//emg6kxF3b8s9UL2GHfstk1RHbx7Z8RflOIGwDp
         h7awmDfUehz7OXuS0cP7PTVWSmQ5T97EYvCrZ1LJSPQbJkRKTKKa5EGKeOT0ZmKN3ZJM
         +d0s8TbmChSMXFtfXWRRxlZ25hb0G/w/Y/2eZqbwciL5sxir0iQ/Mty0nXPmuKxSdI76
         SrpA==
X-Gm-Message-State: AOAM533x/UKzjhimLsTcjxqqKGpjqTY6tceKsow5njHmHsWYZ/eEgkIU
        io8sEbhKpx29vB2j2tzNm0lcxQ==
X-Google-Smtp-Source: ABdhPJxhR31oDZ8cgCyRu5/yU1XmD4TCgTc2I/xDbH4a4w1D+xJ3c0rv/CuK6EmkbJ6JGXmZ2jj62Q==
X-Received: by 2002:a17:90a:fd12:: with SMTP id cv18mr990882pjb.221.1603516382692;
        Fri, 23 Oct 2020 22:13:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y137sm4070147pfc.77.2020.10.23.22.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 22:13:02 -0700 (PDT)
Date:   Fri, 23 Oct 2020 22:13:02 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Oct 2020 22:12:46 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.10 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ed53d520-0ecd-4767-ade1-f4266118c3c0@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit de22d2107ced3cc5355cc9dbbd85e44183546bd5:

  RISC-V: Add page table dump support for uefi (2020-10-02 14:31:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw1

for you to fetch changes up to e8d444d3e98c255f91d228984abc46cfdfaf48b4:

  riscv: remove address space overrides using set_fs() (2020-10-04 10:27:10 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.10 Merge Window, Part 2

This actually just contains a single patch set:

* The remainder of Christoph's work to remove set_fs, including the RISC-V
  portion.

----------------------------------------------------------------
I know I said in the previous PR that I'd keep including shortlogs as of the
last tag, but I haven't done that here as it would include my previous PR.
Essentially I wanted to wait for the base branch of this to land first, as it
touched a lot.  Rather than rebasing I've just left the original merge in
place and sent a shortlog against master.

I'm not sure why the diffstat shows so much more, though.  I manually checked
the commits and my merge has the same commits yours does.  It's my first time
trying this particular sort of merge (though the last one had a tag-based merge
of the same sort, which IIUC shouldn't be any different) so hopefully it went
OK.

Christoph Hellwig (8):
      uaccess: provide a generic TASK_SIZE_MAX definition
      asm-generic: improve the nommu {get,put}_user handling
      asm-generic: add nommu implementations of __{get,put}_kernel_nofault
      asm-generic: make the set_fs implementation optional
      riscv: use memcpy based uaccess for nommu again
      riscv: refactor __get_user and __put_user
      riscv: implement __get_kernel_nofault and __put_user_nofault
      riscv: remove address space overrides using set_fs()

Palmer Dabbelt (1):
      Merge branch 'base.set_fs' of git://git.kernel.org/.../viro/vfs into for-next

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
 arch/powerpc/include/asm/uaccess.h      |  67 ++++--------
 arch/powerpc/kernel/signal.c            |   3 -
 arch/powerpc/lib/sstep.c                |   6 +-
 arch/riscv/Kconfig                      |   1 +
 arch/riscv/include/asm/thread_info.h    |   6 --
 arch/riscv/include/asm/uaccess.h        | 177 ++++++++++++++++----------------
 arch/riscv/kernel/process.c             |   1 -
 arch/riscv/lib/Makefile                 |   2 +-
 arch/s390/Kconfig                       |   1 +
 arch/sh/Kconfig                         |   1 +
 arch/sparc/Kconfig                      |   1 +
 arch/um/Kconfig                         |   1 +
 arch/x86/ia32/ia32_aout.c               |   1 -
 arch/x86/include/asm/page_32_types.h    |  11 ++
 arch/x86/include/asm/page_64_types.h    |  38 +++++++
 arch/x86/include/asm/processor.h        |  60 +----------
 arch/x86/include/asm/thread_info.h      |   2 -
 arch/x86/include/asm/uaccess.h          |  26 +----
 arch/x86/kernel/asm-offsets.c           |   3 -
 arch/x86/lib/getuser.S                  |  47 ++++-----
 arch/x86/lib/putuser.S                  |  25 ++---
 arch/xtensa/Kconfig                     |   1 +
 drivers/misc/lkdtm/bugs.c               |  10 --
 drivers/misc/lkdtm/core.c               |   2 -
 drivers/misc/lkdtm/lkdtm.h              |   2 -
 drivers/misc/lkdtm/usercopy.c           |  15 ---
 fs/proc/inode.c                         | 119 ++++++++++++++-------
 fs/proc/proc_sysctl.c                   |  48 ++++-----
 fs/read_write.c                         |  69 ++++++++-----
 fs/splice.c                             | 130 +++--------------------
 include/asm-generic/uaccess.h           | 109 ++++++++++++--------
 include/linux/bpf-cgroup.h              |   2 +-
 include/linux/fs.h                      |   2 -
 include/linux/proc_fs.h                 |   1 +
 include/linux/uaccess.h                 |  22 ++++
 kernel/bpf/cgroup.c                     |   2 +-
 lib/test_bitmap.c                       |  91 ++++------------
 tools/testing/selftests/lkdtm/tests.txt |   2 -
 57 files changed, 509 insertions(+), 629 deletions(-)
