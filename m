Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A50267EEC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgIMJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 05:25:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbgIMJZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 05:25:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B259FE527167674B4E2;
        Sun, 13 Sep 2020 17:25:41 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sun, 13 Sep 2020
 17:25:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <christian.brauner@ubuntu.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>, <mingo@kernel.org>,
        <ebiederm@xmission.com>, <christian@kellner.me>,
        <surenb@google.com>, <areber@redhat.com>, <shakeelb@google.com>,
        <cyphar@cyphar.com>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] fork: Use helper function mapping_allow_writable() in dup_mmap()
Date:   Sun, 13 Sep 2020 05:24:15 -0400
Message-ID: <20200913092415.24408-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper function mapping_allow_writable() to atomic_inc i_mmap_writable.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4b328aecabb2..a0586716e327 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -558,7 +558,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 				atomic_dec(&inode->i_writecount);
 			i_mmap_lock_write(mapping);
 			if (tmp->vm_flags & VM_SHARED)
-				atomic_inc(&mapping->i_mmap_writable);
+				mapping_allow_writable(mapping);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
 			vma_interval_tree_insert_after(tmp, mpnt,
-- 
2.19.1

