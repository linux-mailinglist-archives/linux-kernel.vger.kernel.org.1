Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED7A28DBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgJNImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:42:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50978 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgJNImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:42:33 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kScMg-0005lo-Jr; Wed, 14 Oct 2020 08:42:30 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] kernel_clone() for v5.10
Date:   Wed, 14 Oct 2020 10:41:54 +0200
Message-Id: <20201014084153.170148-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
Here is the kernel_clone() series for v5.10. During the v5.9 merge window we
reworked the process creation codepaths across multiple architectures. After
this work we were only left with the _do_fork() helper based on the struct
kernel_clone_args calling convention. As was pointed out _do_fork() isn't valid
kernelese especially for a helper that isn't just static.

This series removes the _do_fork() helper and introduces the new kernel_clone()
helper. The process creation cleanup didn't change the name to something more
reasonable mainly because _do_fork() was used in quite a few places. So sending
this as a separate series seemed the better strategy.

I originally intended to send this early in the v5.9 development cycle after
the merge window had closed but given that this was touching quite a few places
I decided to defer this until the v5.10 merge window.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel-clone-v5.9

for you to fetch changes up to 06fe45634942dc96c316bbb789049a4b0b692542:

  sched: remove _do_fork() (2020-08-20 13:12:59 +0200)

/* Testing */
All patches are based on v5.9-rc1 and have been sitting in linux-next since
then. No build failures or warnings were observed. All old and new tests are
passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from linux-next and no merge
conflicts showed up doing a test-merge with current mainline b5fc7a89e58b
("Merge tag 'overflow-v5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux").

Please consider pulling these changes from the signed kernel-clone-v5.9 tag.

Thanks!
Christian

----------------------------------------------------------------
kernel-clone-v5.9

----------------------------------------------------------------
Christian Brauner (11):
      fork: introduce kernel_clone()
      h8300: switch to kernel_clone()
      ia64: switch to kernel_clone()
      m68k: switch to kernel_clone()
      nios2: switch to kernel_clone()
      sparc: switch to kernel_clone()
      x86: switch to kernel_clone()
      kprobes: switch to kernel_clone()
      kgdbts: switch to kernel_clone()
      tracing: switch to kernel_clone()
      sched: remove _do_fork()

 Documentation/trace/histogram.rst                  |  4 +-
 arch/h8300/kernel/process.c                        |  2 +-
 arch/ia64/kernel/process.c                         |  4 +-
 arch/m68k/kernel/process.c                         | 10 ++---
 arch/nios2/kernel/process.c                        |  2 +-
 arch/sparc/kernel/process.c                        |  6 +--
 arch/x86/kernel/sys_ia32.c                         |  2 +-
 drivers/misc/kgdbts.c                              | 48 +++++++++++-----------
 include/linux/sched/task.h                         |  2 +-
 kernel/fork.c                                      | 16 ++++----
 samples/kprobes/kprobe_example.c                   |  6 +--
 samples/kprobes/kretprobe_example.c                |  4 +-
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  2 +-
 .../ftrace/test.d/dynevent/clear_select_events.tc  |  2 +-
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |  2 +-
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |  4 +-
 .../ftrace/test.d/kprobe/add_and_remove.tc         |  2 +-
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |  2 +-
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |  4 +-
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |  2 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  4 +-
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     | 10 ++---
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |  2 +-
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          | 14 +++----
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |  2 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 12 +++---
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |  4 +-
 .../selftests/ftrace/test.d/kprobe/profile.tc      |  2 +-
 28 files changed, 88 insertions(+), 88 deletions(-)
