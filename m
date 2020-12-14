Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692482D98C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439798AbgLNN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:29:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51991 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439365AbgLNN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:28:38 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kontG-0007MJ-9W; Mon, 14 Dec 2020 13:27:50 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Some fixes for v5.11
Date:   Mon, 14 Dec 2020 14:27:45 +0100
Message-Id: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are some fixes for v5.11.

/* Summary */
This contains several fixes which felt worth being combined into a single pr:
- Use put_nsproxy() instead of open-coding it switch_task_namespaces().
- Kirill's work to unify lifecycle management for all namespaces.
  The lifetime counters are used identically for all namespaces types.
  Namespaces may of course have additional unrelated counters and these are
  not altered. This work allows us to unify the type of the counters and
  reduces maintenance cost by moving the counter in one place and
  indicating that basic lifetime management is identical for all
  namespaces.
- Peilin's fix adding 3 byte padding to Dmitry's PTRACE_GET_SYSCALL_INFO
  uapi struct to prevent an info leak.
- Two smal patches to convert from the /* fall through */ comment
  annotation to the fallthrough keyword annotation which I had taken into
  my branch and into -next before df561f6688fe ("treewide: Use fallthrough
  pseudo-keyword") made it upstream which fixed this tree-wide. Since I
  didn't want to invalidate all testing for other commits I didn't rebase
  and kept them.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fixes-v5.11

for you to fetch changes up to aabe19b8279340c43294688b4d9527a893c60463:

  nsproxy: use put_nsproxy() in switch_task_namespaces() (2020-11-19 10:57:02 +0100)

/* Testing */
Most of the patches here have been sitting in -next since
v5.9-rc1; so a rather long time. Especially for the ns counter changes and
the uapi change to the ptrace_get_syscall_info() struct it seemed worth
waiting for a while to be confident there aren't any subtle regressions we
missed. No build failures or warnings were observed. All old and new tests
are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflict with 2c85ebc57b3e ("Linux 5.10") when
pulling the tag.

Please consider pulling these changes from the signed fixes-v5.11 tag.

Thanks!
Christian

----------------------------------------------------------------
fixes-v5.11

----------------------------------------------------------------
Christian Brauner (2):
      ns: Add a common refcount into ns_common
      net: Use generic ns_common::count

Hui Su (1):
      nsproxy: use put_nsproxy() in switch_task_namespaces()

Kirill Tkhai (7):
      uts: Use generic ns_common::count
      ipc: Use generic ns_common::count
      pid: Use generic ns_common::count
      user: Use generic ns_common::count
      mnt: Use generic ns_common::count
      cgroup: Use generic ns_common::count
      time: Use generic ns_common::count

Miaohe Lin (2):
      signal: Convert to the new fallthrough notation
      sys: Convert to the new fallthrough notation

Peilin Ye (1):
      ptrace: Prevent kernel-infoleak in ptrace_get_syscall_info()

 fs/mount.h                     |  3 +--
 fs/namespace.c                 |  4 ++--
 include/linux/cgroup.h         |  5 ++---
 include/linux/ipc_namespace.h  |  3 +--
 include/linux/ns_common.h      |  3 +++
 include/linux/pid_namespace.h  |  4 +---
 include/linux/time_namespace.h |  9 ++++-----
 include/linux/user_namespace.h |  5 ++---
 include/linux/utsname.h        |  9 ++++-----
 include/net/net_namespace.h    | 11 ++++-------
 include/uapi/linux/ptrace.h    |  3 ++-
 init/version.c                 |  2 +-
 ipc/msgutil.c                  |  2 +-
 ipc/namespace.c                |  4 ++--
 kernel/cgroup/cgroup.c         |  2 +-
 kernel/cgroup/namespace.c      |  2 +-
 kernel/nsproxy.c               |  6 +++---
 kernel/pid.c                   |  2 +-
 kernel/pid_namespace.c         | 13 +++----------
 kernel/signal.c                |  2 +-
 kernel/sys.c                   |  2 +-
 kernel/time/namespace.c        |  9 +++------
 kernel/user.c                  |  2 +-
 kernel/user_namespace.c        |  4 ++--
 kernel/utsname.c               |  7 ++-----
 net/core/net-sysfs.c           |  6 +++---
 net/core/net_namespace.c       |  6 +++---
 net/ipv4/inet_timewait_sock.c  |  4 ++--
 net/ipv4/tcp_metrics.c         |  2 +-
 29 files changed, 58 insertions(+), 78 deletions(-)
