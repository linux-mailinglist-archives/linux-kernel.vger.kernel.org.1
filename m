Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD62ECB23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 08:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbhAGHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 02:53:15 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38157 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbhAGHxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:53:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UKzE3JU_1610005951;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UKzE3JU_1610005951)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Jan 2021 15:52:32 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>
Subject: [PATCH v2 4.9 00/10] fix a race in release_task when flushing the dentry
Date:   Thu,  7 Jan 2021 15:52:12 +0800
Message-Id: <20210107075222.62623-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dentries such as /proc/<pid>/ns/ have the DCACHE_OP_DELETE flag, they 
should be deleted when the process exits. 

Suppose the following race appears： 

release_task                 dput 
-> proc_flush_task 
                             -> dentry->d_op->d_delete(dentry) 
-> __exit_signal 
                             -> dentry->d_lockref.count--  and return. 

In the proc_flush_task(), if another process is using this dentry, it will
not be deleted. At the same time, in dput(), d_op->d_delete() can be executed
before __exit_signal(pid has not been hashed), d_delete returns false, so
this dentry still cannot be deleted.

This dentry will always be cached (although its count is 0 and the
DCACHE_OP_DELETE flag is set), its parent denry will also be cached too, and
these dentries can only be deleted when drop_caches is manually triggered.

This will result in wasted memory. What's more troublesome is that these
dentries reference pid, according to the commit f333c700c610 ("pidns: Add a
limit on the number of pid namespaces"), if the pid cannot be released, it
may result in the inability to create a new pid_ns.

This issue was introduced by 60347f6716aa ("pid namespaces: prepare
proc_flust_task() to flush entries from multiple proc trees"), exposed by
f333c700c610 ("pidns: Add a limit on the number of pid namespaces"), and then
fixed by 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc").


Alexey Dobriyan (1):
  proc: use %u for pid printing and slightly less stack

Andreas Gruenbacher (1):
  proc: Pass file mode to proc_pid_make_inode

Christian Brauner (1):
  clone: add CLONE_PIDFD

Eric W. Biederman (6):
  proc: Better ownership of files for non-dumpable tasks in user
    namespaces
  proc: Rename in proc_inode rename sysctl_inodes sibling_inodes
  proc: Generalize proc_sys_prune_dcache into proc_prune_siblings_dcache
  proc: Clear the pieces of proc_inode that proc_evict_inode cares about
  proc: Use d_invalidate in proc_prune_siblings_dcache
  proc: Use a list of inodes to flush from proc

Joel Fernandes (Google) (1):
  pidfd: add polling support

 fs/proc/base.c             | 242 ++++++++++++++++++++-------------------------
 fs/proc/fd.c               |  20 +---
 fs/proc/inode.c            |  67 ++++++++++++-
 fs/proc/internal.h         |  22 ++---
 fs/proc/namespaces.c       |   3 +-
 fs/proc/proc_sysctl.c      |  45 ++-------
 fs/proc/self.c             |   6 +-
 fs/proc/thread_self.c      |   5 +-
 include/linux/pid.h        |   5 +
 include/linux/proc_fs.h    |   4 +-
 include/uapi/linux/sched.h |   1 +
 kernel/exit.c              |   5 +-
 kernel/fork.c              | 131 +++++++++++++++++++++++-
 kernel/pid.c               |   3 +
 kernel/signal.c            |  11 +++
 security/selinux/hooks.c   |   1 +
 16 files changed, 343 insertions(+), 228 deletions(-)

-- 
1.8.3.1

