Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37AD2047F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 05:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgFWD2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 23:28:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730129AbgFWD2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:28:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E501152C2AF30CD1F7DA;
        Tue, 23 Jun 2020 11:28:12 +0800 (CST)
Received: from localhost (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 23 Jun 2020
 11:28:03 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <christian.brauner@ubuntu.com>, <akpm@linux-foundation.org>,
        <tglx@linutronix.de>, <lizefan@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] kernel/fork.c: annotate data races for copy_process
Date:   Tue, 23 Jun 2020 12:12:40 +0800
Message-ID: <20200623041240.154294-1-chenweilong@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN report there's a data race risk while using nr_threads.
But according to the comment above it:
'
        /*
         * If multiple threads are within copy_process(), then this check
         * triggers too late. This doesn't hurt, the check is only there
         * to stop root fork bombs.
         */
'
The concurrency problem is not care. And we needn't to use READ_ONCE/atomic/etc
to protect it. Meanwhile 'max_threads' is a sysctl variable which can
be modified concurrently while being read, we can use
'data_race(nr_threads >= max_threads)' to mark both of then.

BUG: KCSAN: data-race in copy_process / copy_process

write to 0xffffffff86205cf8 of 4 bytes by task 14779 on cpu 1:
  copy_process+0x2eba/0x3c40 kernel/fork.c:2273
  _do_fork+0xfe/0x7a0 kernel/fork.c:2421
  __do_sys_clone kernel/fork.c:2576 [inline]
  __se_sys_clone kernel/fork.c:2557 [inline]
  __x64_sys_clone+0x130/0x170 kernel/fork.c:2557
  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffffff86205cf8 of 4 bytes by task 6944 on cpu 0:
  copy_process+0x94d/0x3c40 kernel/fork.c:1954
  _do_fork+0xfe/0x7a0 kernel/fork.c:2421
  __do_sys_clone kernel/fork.c:2576 [inline]
  __se_sys_clone kernel/fork.c:2557 [inline]
  __x64_sys_clone+0x130/0x170 kernel/fork.c:2557
  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Link: https://groups.google.com/forum/#!msg/syzkaller-upstream-mo
deration/thvp7AHs5Ew/aPdYLXfYBQAJ

Reported-by: syzbot+52fced2d288f8ecd2b20@syzkaller.appspotmail.com
Cc: Qian Cai <cai@lca.pw>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Zefan Li <lizefan@huawei.com>
Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 63c8fb2f5ca7..caa9c1f27444 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1976,7 +1976,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 * to stop root fork bombs.
 	 */
 	retval = -EAGAIN;
-	if (nr_threads >= max_threads)
+	if (data_race(nr_threads >= max_threads))
 		goto bad_fork_cleanup_count;
 
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
-- 
2.17.1

