Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5942C19F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgKXA3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKXA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA65C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:36 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so20563574wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNz3xKoutWR4nz0OrEakBf/3W1qDSFus3UiO0EblEv8=;
        b=n+M+hYWqW8rhatkQC/ruNhIpOBRonphJK6iRj5ckMUONI+jeC46hXsS+F448eR9roH
         f+W2cWOABZPjdT8h/Kv4/kzhP4IEyvPcrur5KZ29bqGfwalTUAsuYeMRfuey5HaeamKO
         U4bY7H6FdnrKgwNqczwlPYQv9HiSzLuZsA3k9I7iJNZptCLtapIiJqAiyhj/zD6kJQKB
         WQ7CAkNd57Q4MlPiFJ9tfpaO4f6lfylKfMkLEGpq4zBcaJKU4rDTCA+TmYYakr6bx3GU
         nMHHYTylZMrgavyDiwbyJwsgRdlaW/0jx5UMXejU3EhX6I1W3HEvPkCBmtlP7bbBvOBk
         W6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNz3xKoutWR4nz0OrEakBf/3W1qDSFus3UiO0EblEv8=;
        b=hyyIIxKPWt1NBpmMSiKkll8NjSXqRd0K5PUZy8819NN6IFaDT1h2SInzJQvr6bCvDj
         ONEMZFCOj/T8/HMbYBbNYxIRHvUQjCLAZzbaFQyatabpJT30o1sNifPvRShkWsUlDt4Z
         wLjjAHsHvrLMluP9WHZWJB1OuVmoxgd4sS2dIEKwj/zh1Zxtxn5DLj8eIo+6CtTf6dkQ
         +ql9kBhkrAYaEAY+Gyc4FRmyOdYB0uKGkzoKb0lCqGiO5h69HNimXkKwiHDFwZbvIawo
         eVswc2qD8ciEnx9uKxC/CAC04eaJc8ES2zEZnVgCdC5NAek+Id3ugoZeUYHDCym0Srn4
         G75g==
X-Gm-Message-State: AOAM530IdMmRWIfrSSMCsb0kq2NOU9i/xUB0Mcw8tbtIDGJx7NLsv0YF
        x0nrX2vqZKT45O65XOc1g9W+a9f5taX0xmln
X-Google-Smtp-Source: ABdhPJxLooGBO7uA4nI31mkCOzrZY2FwztGHRbhA3oNfSpnzFi6YpHRuR4w8Ptvp0DbFh/7JUN81rQ==
X-Received: by 2002:adf:8028:: with SMTP id 37mr2245344wrk.111.1606177774498;
        Mon, 23 Nov 2020 16:29:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:33 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v2 00/19] Add generic vdso_base tracking
Date:   Tue, 24 Nov 2020 00:29:13 +0000
Message-Id: <20201124002932.1220517-1-dima@arista.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 Changes:
- Rename user_landing to vdso_base as it tracks vDSO VMA start address,
  rather than the explicit address to land (Andy)
- Reword and don't use "new-execed" and "new-born" task (Andy)
- Fix failures reported by build robot

Started from discussion [1], where was noted that currently a couple of
architectures support mremap() for vdso/sigpage, but not munmap().
If an application maps something on the ex-place of vdso/sigpage,
later after processing signal it will land there (good luck!)

Patches set is based on linux-next (next-20201123) and it depends on
changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
on my changes in akpm (fixing several mremap() issues).

Logically, the patches set divides on:
- patch       1: a cleanup for patches in x86/cleanups
- patches  2-11: cleanups for arch_setup_additional_pages()
- patches 12-13: x86 signal changes for unmapped vdso
- patches 14-19: provide generic vdso_base in mm_struct

In the end, besides cleanups, it's now more predictable what happens for
applications with unmapped vdso on architectures those support .mremap()
for vdso/sigpage.

I'm aware of only one user that unmaps vdso - Valgrind [2].
(there possibly are more, but this one is "special", it unmaps vdso, but
 not vvar, which confuses CRIU [Checkpoint Restore In Userspace], that's
 why I'm aware of it)

Patches as a .git branch:
https://github.com/0x7f454c46/linux/tree/setup_additional_pages-v2

v1 Link:
https://lore.kernel.org/lkml/20201108051730.2042693-1-dima@arista.com/

[1]: https://lore.kernel.org/linux-arch/CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com/
[2]: https://github.com/checkpoint-restore/criu/issues/488

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Guo Ren <guoren@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: x86@kernel.org

Dmitry Safonov (19):
  x86/elf: Check in_x32_syscall() in compat_arch_setup_additional_pages()
  elf: Move arch_setup_additional_pages() to generic elf.h
  arm64: Use in_compat_task() in arch_setup_additional_pages()
  x86: Remove compat_arch_setup_additional_pages()
  elf: Remove compat_arch_setup_additional_pages()
  elf/vdso: Reuse arch_setup_additional_pages() parameters
  elf: Use sysinfo_ehdr in ARCH_DLINFO()
  arm/vdso: Remove vdso pointer from mm->context
  s390/vdso: Remove vdso_base pointer from mm->context
  sparc/vdso: Remove vdso pointer from mm->context
  mm/mmap: Make vm_special_mapping::mremap return void
  x86/signal: Land on &frame->retcode when vdso isn't mapped
  x86/signal: Check if vdso_image_32 is mapped before trying to land on it
  mm: Add vdso_base in mm_struct
  x86/vdso: Migrate to generic vdso_base
  arm/vdso: Migrate to generic vdso_base
  arm64/vdso: Migrate compat signals to generic vdso_base
  arm64/vdso: Migrate native signals to generic vdso_base
  mips/vdso: Migrate to generic vdso_base

 arch/alpha/include/asm/elf.h              |  2 +-
 arch/arm/Kconfig                          |  2 +
 arch/arm/include/asm/elf.h                | 10 +---
 arch/arm/include/asm/mmu.h                |  3 -
 arch/arm/include/asm/vdso.h               |  6 +-
 arch/arm/kernel/process.c                 | 14 +----
 arch/arm/kernel/signal.c                  |  6 +-
 arch/arm/kernel/vdso.c                    | 20 ++-----
 arch/arm64/Kconfig                        |  2 +
 arch/arm64/include/asm/elf.h              | 27 ++-------
 arch/arm64/kernel/signal.c                | 10 +++-
 arch/arm64/kernel/signal32.c              | 17 ++++--
 arch/arm64/kernel/vdso.c                  | 50 +++++++---------
 arch/csky/Kconfig                         |  1 +
 arch/csky/include/asm/elf.h               |  4 --
 arch/csky/kernel/vdso.c                   |  3 +-
 arch/hexagon/Kconfig                      |  1 +
 arch/hexagon/include/asm/elf.h            |  6 --
 arch/hexagon/kernel/vdso.c                |  3 +-
 arch/ia64/include/asm/elf.h               |  2 +-
 arch/mips/Kconfig                         |  2 +
 arch/mips/include/asm/elf.h               | 10 +---
 arch/mips/kernel/signal.c                 | 11 ++--
 arch/mips/kernel/vdso.c                   |  5 +-
 arch/mips/vdso/genvdso.c                  |  9 ---
 arch/nds32/Kconfig                        |  1 +
 arch/nds32/include/asm/elf.h              |  8 +--
 arch/nds32/kernel/vdso.c                  |  3 +-
 arch/nios2/Kconfig                        |  1 +
 arch/nios2/include/asm/elf.h              |  4 --
 arch/nios2/mm/init.c                      |  2 +-
 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/include/asm/elf.h            |  9 +--
 arch/powerpc/kernel/vdso.c                |  3 +-
 arch/riscv/Kconfig                        |  1 +
 arch/riscv/include/asm/elf.h              |  9 +--
 arch/riscv/kernel/vdso.c                  | 11 ++--
 arch/s390/Kconfig                         |  1 +
 arch/s390/include/asm/elf.h               | 10 +---
 arch/s390/include/asm/mmu.h               |  1 -
 arch/s390/kernel/vdso.c                   | 13 +---
 arch/sh/Kconfig                           |  1 +
 arch/sh/include/asm/elf.h                 | 16 ++---
 arch/sh/kernel/vsyscall/vsyscall.c        |  3 +-
 arch/sparc/Kconfig                        |  1 +
 arch/sparc/include/asm/elf_64.h           | 11 +---
 arch/sparc/include/asm/mmu_64.h           |  1 -
 arch/sparc/vdso/vma.c                     | 18 +++---
 arch/x86/Kconfig                          |  2 +
 arch/x86/entry/common.c                   |  7 ++-
 arch/x86/entry/vdso/extable.c             |  4 +-
 arch/x86/entry/vdso/vma.c                 | 72 ++++++++++++-----------
 arch/x86/ia32/ia32_signal.c               | 18 +++---
 arch/x86/include/asm/compat.h             |  6 ++
 arch/x86/include/asm/elf.h                | 44 +++++---------
 arch/x86/include/asm/mmu.h                |  1 -
 arch/x86/include/asm/vdso.h               |  4 ++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 +-
 arch/x86/kernel/signal.c                  | 25 ++++----
 arch/x86/um/asm/elf.h                     |  9 +--
 arch/x86/um/vdso/vma.c                    |  2 +-
 fs/Kconfig.binfmt                         |  3 +
 fs/aio.c                                  |  3 +-
 fs/binfmt_elf.c                           | 19 +++---
 fs/binfmt_elf_fdpic.c                     | 17 +++---
 fs/compat_binfmt_elf.c                    | 12 ----
 include/linux/elf.h                       | 24 ++++++--
 include/linux/mm.h                        |  3 +-
 include/linux/mm_types.h                  | 12 +++-
 mm/Kconfig                                |  3 +
 mm/mmap.c                                 | 21 ++++++-
 mm/mremap.c                               |  2 +-
 72 files changed, 313 insertions(+), 358 deletions(-)


base-commit: 62918e6fd7b5751c1285c7f8c6cbd27eb6600c02
-- 
2.29.2

