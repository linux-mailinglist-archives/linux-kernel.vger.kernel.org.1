Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9312DC250
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgLPOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgLPOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:34:24 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F175C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:33:44 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id p5so22722146iln.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Bpb+CE1uHpEVtJpf8353KYHpND+ojr7K/ZhCcqL4ElI=;
        b=L5J1XK+lGX6sLe4CHDPpS6o8qB4iOEsUndfyjWuGLzxT/IL8kZ6ZxXYubGgJaInZ2F
         Fuq1zLCmkyqI2k6IQOOpyzHO+wTHBMN0J+4zasAUBCMggUVShXnOp/YPhK0iYL/DSgTk
         X6PvzDMLL8FTT2A/M1HwseLS2x7eR9RKaKyVkRRif8xSpFjzn7dkLj4eVht8x8BEDvln
         GTcE5dijRcerS22Tt2AIrzulN669vA37ZyqtnkXmKyjUFFDG/gn4Q4D0JSCJe0KJqQZq
         dDY5zWe3nXF1JWuneXo0YrOIslbWUSATwcRJrMFSIJNnVpdNJhC3gF8SwGMxezMpIGol
         5QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Bpb+CE1uHpEVtJpf8353KYHpND+ojr7K/ZhCcqL4ElI=;
        b=i8Ojtwf5CP30zx/KmhGUJYv3G/b2cooidKuDTlCdw0uODzLwCWz6TdFVV/aOYBM1hz
         MU4W+lja6r9SeoQdDp1wd6N89GV3BAM0zkLI6u77NOEeN0qFG09FykVD7tZxi3qsECI+
         3qIpFMUAO1d/191mdXnMXt46FLqTbv/zeBQT0PKMrz3tw7rYnW1fVMEEeDNJMALxN8Wx
         RfnqlY6bZpfvxicoydoDN0RBTt6oDhBSF5xNhMm1lpULRzdPE4HQp4eXstQT2FQT3c9L
         Y8xx9ntab5We7h8kZila7Ln6NuT2RUJcEBqI6QXoW4Le6Geq226VAxvJwMDjqDl99Kg9
         na+w==
X-Gm-Message-State: AOAM5338A+qAYiTCoehRt7HYE5gr55sVI1BCGrK3DHci40xUYgEbAnIf
        Jrc7pew/OANfChWbQ3ms3kAeEg==
X-Google-Smtp-Source: ABdhPJyMcv2CReUO063tF7ksAO+vr90dkSfeBz4y1eCMoCEdzCYM3EPsux1LB9rUDIl8h4W7L+6q/g==
X-Received: by 2002:a92:dcc4:: with SMTP id b4mr2197124ilr.164.1608129223542;
        Wed, 16 Dec 2020 06:33:43 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v22sm1382204ila.84.2020.12.16.06.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 06:33:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] TIF_NOTIFY_SIGNAL for all archs
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
Date:   Wed, 16 Dec 2020 07:33:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull sits on top of of the core entry/exit and x86 entry branch
from the tip tree, which contains the generic and x86 parts of this
work. Here we convert the rest of the archs to support
TIF_NOTIFY_SIGNAL. With that done, we can get rid of JOBCTL_TASK_WORK
from task_work and signal.c, and also remove a deadlock work-around in
io_uring around knowing that signal based task_work waking is invoked
with the sighand wait queue head lock.

The motivation for this work is to decouple signal notify based
task_work, of which io_uring is a heavy user of, from sighand. The
sighand lock becomes a huge contention point, particularly for threaded
workloads where it's shared between threads. Even outside of threaded
applications it's slower than it needs to be.

Roman Gershman <romger@amazon.com> reported that his networked workload
dropped from 1.6M QPS at 80% CPU to 1.0M QPS at 100% CPU after io_uring
was changed to use TIF_NOTIFY_SIGNAL. The time was all spent hammering
on the sighand lock, showing 57% of the CPU time there [1].

There are further cleanups possible on top of this. One example is
TIF_PATCH_PENDING, where a patch already exists to use TIF_NOTIFY_SIGNAL
instead. Hopefully this will also lead to more consolidation, but the
work stands on its own as well.

This throws a trivial merge conflict with arm64 since you pulled that,
which is just a renumbering exercise and fiddling with _TIF_WORK_MASK in
that same file (arch/arm64/include/asm/thread_info.h).

[1] https://github.com/axboe/liburing/issues/215

Please pull!


The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/tif-task_work.arch-2020-12-14

for you to fetch changes up to 355fb9e2b78e78b38ec00f5cd9b05c6aceb98335:

  io_uring: remove 'twa_signal_ok' deadlock work-around (2020-12-12 09:17:38 -0700)

----------------------------------------------------------------
tif-task_work.arch-2020-12-14

----------------------------------------------------------------
Jens Axboe (30):
      Merge tag 'core-entry-notify-signal' of git://git.kernel.org/.../tip/tip into tif-task_work.arch
      Merge branch 'x86/entry' of git://git.kernel.org/.../tip/tip into tif-task_work.arch
      arc: add support for TIF_NOTIFY_SIGNAL
      arm64: add support for TIF_NOTIFY_SIGNAL
      m68k: add support for TIF_NOTIFY_SIGNAL
      nios32: add support for TIF_NOTIFY_SIGNAL
      parisc: add support for TIF_NOTIFY_SIGNAL
      powerpc: add support for TIF_NOTIFY_SIGNAL
      mips: add support for TIF_NOTIFY_SIGNAL
      s390: add support for TIF_NOTIFY_SIGNAL
      um: add support for TIF_NOTIFY_SIGNAL
      sh: add support for TIF_NOTIFY_SIGNAL
      openrisc: add support for TIF_NOTIFY_SIGNAL
      csky: add support for TIF_NOTIFY_SIGNAL
      hexagon: add support for TIF_NOTIFY_SIGNAL
      microblaze: add support for TIF_NOTIFY_SIGNAL
      arm: add support for TIF_NOTIFY_SIGNAL
      xtensa: add support for TIF_NOTIFY_SIGNAL
      alpha: add support for TIF_NOTIFY_SIGNAL
      c6x: add support for TIF_NOTIFY_SIGNAL
      h8300: add support for TIF_NOTIFY_SIGNAL
      ia64: add support for TIF_NOTIFY_SIGNAL
      nds32: add support for TIF_NOTIFY_SIGNAL
      riscv: add support for TIF_NOTIFY_SIGNAL
      sparc: add support for TIF_NOTIFY_SIGNAL
      task_work: remove legacy TWA_SIGNAL path
      io_uring: JOBCTL_TASK_WORK is no longer used by task_work
      signal: kill JOBCTL_TASK_WORK
      kernel: remove checking for TIF_NOTIFY_SIGNAL
      io_uring: remove 'twa_signal_ok' deadlock work-around

 arch/alpha/include/asm/thread_info.h      |  2 ++
 arch/alpha/kernel/entry.S                 |  2 +-
 arch/alpha/kernel/signal.c                |  2 +-
 arch/arc/include/asm/thread_info.h        |  4 ++-
 arch/arc/kernel/entry.S                   |  3 ++-
 arch/arc/kernel/signal.c                  |  2 +-
 arch/arm/include/asm/thread_info.h        |  7 +++++-
 arch/arm/kernel/entry-common.S            |  6 ++---
 arch/arm/kernel/entry-v7m.S               |  2 +-
 arch/arm/kernel/signal.c                  |  2 +-
 arch/arm64/include/asm/thread_info.h      |  5 +++-
 arch/arm64/kernel/signal.c                |  2 +-
 arch/c6x/include/asm/thread_info.h        |  1 +
 arch/c6x/kernel/asm-offsets.c             |  1 +
 arch/c6x/kernel/signal.c                  |  3 ++-
 arch/csky/include/asm/thread_info.h       |  5 +++-
 arch/csky/kernel/signal.c                 |  2 +-
 arch/h8300/include/asm/thread_info.h      |  4 ++-
 arch/h8300/kernel/signal.c                |  2 +-
 arch/hexagon/include/asm/thread_info.h    |  2 ++
 arch/hexagon/kernel/process.c             |  2 +-
 arch/ia64/include/asm/thread_info.h       |  4 ++-
 arch/ia64/kernel/process.c                |  3 ++-
 arch/m68k/include/asm/thread_info.h       |  1 +
 arch/m68k/kernel/signal.c                 |  3 ++-
 arch/microblaze/include/asm/thread_info.h |  2 ++
 arch/microblaze/kernel/signal.c           |  3 ++-
 arch/mips/include/asm/thread_info.h       |  4 ++-
 arch/mips/kernel/signal.c                 |  2 +-
 arch/nds32/include/asm/thread_info.h      |  2 ++
 arch/nds32/kernel/ex-exit.S               |  2 +-
 arch/nds32/kernel/signal.c                |  2 +-
 arch/nios2/include/asm/thread_info.h      |  2 ++
 arch/nios2/kernel/signal.c                |  3 ++-
 arch/openrisc/include/asm/thread_info.h   |  2 ++
 arch/openrisc/kernel/signal.c             |  2 +-
 arch/parisc/include/asm/thread_info.h     |  4 ++-
 arch/parisc/kernel/signal.c               |  3 ++-
 arch/powerpc/include/asm/thread_info.h    |  5 +++-
 arch/powerpc/kernel/signal.c              |  2 +-
 arch/riscv/include/asm/thread_info.h      |  5 +++-
 arch/riscv/kernel/signal.c                |  2 +-
 arch/s390/include/asm/thread_info.h       |  2 ++
 arch/s390/kernel/entry.S                  | 11 +++++----
 arch/s390/kernel/signal.c                 |  2 +-
 arch/sh/include/asm/thread_info.h         |  4 ++-
 arch/sh/kernel/signal_32.c                |  2 +-
 arch/sparc/include/asm/thread_info_32.h   |  4 ++-
 arch/sparc/include/asm/thread_info_64.h   |  6 +++--
 arch/sparc/kernel/signal_32.c             |  2 +-
 arch/sparc/kernel/signal_64.c             |  2 +-
 arch/um/include/asm/thread_info.h         |  2 ++
 arch/um/kernel/process.c                  |  3 ++-
 arch/xtensa/include/asm/thread_info.h     |  5 +++-
 arch/xtensa/kernel/entry.S                |  4 +--
 arch/xtensa/kernel/signal.c               |  3 ++-
 fs/io_uring.c                             | 30 ++++++-----------------
 include/linux/entry-common.h              |  4 ---
 include/linux/sched/jobctl.h              |  4 +--
 include/linux/sched/signal.h              |  2 --
 include/linux/tracehook.h                 |  4 ---
 kernel/signal.c                           | 22 -----------------
 kernel/task_work.c                        | 30 +----------------------
 63 files changed, 128 insertions(+), 139 deletions(-)

-- 
Jens Axboe

