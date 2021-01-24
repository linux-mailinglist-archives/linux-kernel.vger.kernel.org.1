Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DCB301BED
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbhAXMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:52:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39149 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhAXMwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:52:30 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l3err-0004jk-4O; Sun, 24 Jan 2021 12:51:47 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] misc fixes for v5.11-rc5
Date:   Sun, 24 Jan 2021 13:51:22 +0100
Message-Id: <20210124125121.3969248-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are some fixes for v5.11-rc5 that should hopefully be fairly
uncontroversial. I've had them sitting around for a bit but only got around
sending them now after concluding the idmapped mounts stuff. Sorry for the
delay.

/* Summary */
- Jann reported sparse complaints because of a missing __user annotation in a
  helper we added way back when we added pidfd_send_signal() to avoid compat
  syscall handling. This contains a fix for this.
- Yanfei replaces a reference in a comment to the _do_fork() helper I removed a
  while ago with a reference to the new kernel_clone() replacement.
- Alexander Guril added a simple coding style fix.

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2021-01-24

for you to fetch changes up to cb5021ca622fe83923e0789f99fe7227cbcd3f68:

  kthread: remove comments about old _do_fork() helper (2021-01-11 15:11:56 +0100)

/* Testing */
The patches have been sitting in -next for a while. No build failures or
warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflict with e1ae4b0be158 ("Merge branch 'mtd/fixes'
of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux") when pulling the
tag.

Please consider pulling these changes from the signed for-linus-2021-01-24 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2021-01-24

----------------------------------------------------------------
Alexander Guril (1):
      Kernel: fork.c: Fix coding style: Do not use {} around single-line statements

Jann Horn (1):
      signal: Add missing __user annotation to copy_siginfo_from_user_any

Yanfei Xu (1):
      kthread: remove comments about old _do_fork() helper

 include/trace/events/sched.h | 2 +-
 kernel/fork.c                | 6 ++----
 kernel/kthread.c             | 2 +-
 kernel/signal.c              | 3 ++-
 4 files changed, 6 insertions(+), 7 deletions(-)
