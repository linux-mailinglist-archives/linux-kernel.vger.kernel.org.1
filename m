Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0BD1ACF89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 20:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgDPSWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 14:22:49 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35428 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729376AbgDPSWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:22:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TvjuKCW_1587061357;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TvjuKCW_1587061357)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Apr 2020 02:22:45 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shmem: disable interrupt when acquiring info->lock in userfaultfd_copy path
Date:   Fri, 17 Apr 2020 02:22:37 +0800
Message-Id: <1587061357-122619-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported the below lockdep splat:

WARNING: possible irq lock inversion dependency detected
5.6.0-rc7-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor.0/10317 just changed the state of lock:
ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at: spin_lock
include/linux/spinlock.h:338 [inline]
ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at:
shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&(&xa->xa_lock)->rlock#5){..-.}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&info->lock)->rlock);
                               local_irq_disable();
                               lock(&(&xa->xa_lock)->rlock#5);
                               lock(&(&info->lock)->rlock);
  <Interrupt>
    lock(&(&xa->xa_lock)->rlock#5);

 *** DEADLOCK ***

The full report is quite lengthy, please see:
https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2004152007370.13597@eggly.anvils/T/#m813b412c5f78e25ca8c6c7734886ed4de43f241d

It is because CPU 0 held info->lock with IRQ enabled in userfaultfd_copy
path, then CPU 1 is splitting a THP which held xa_lock and info->lock in
IRQ disabled context at the same time.  If softirq comes in to acquire
xa_lock, the deadlock would be triggered.

The fix is to acquire/release info->lock with *_irq version instead of
plain spin_{lock,unlock} to make it softirq safe.

Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Reported-and-tested-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d722eb8..762da6a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2399,11 +2399,11 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 	lru_cache_add_anon(page);
 
-	spin_lock(&info->lock);
+	spin_lock_irq(&info->lock);
 	info->alloced++;
 	inode->i_blocks += BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
-	spin_unlock(&info->lock);
+	spin_unlock_irq(&info->lock);
 
 	inc_mm_counter(dst_mm, mm_counter_file(page));
 	page_add_file_rmap(page, false);
-- 
1.8.3.1

