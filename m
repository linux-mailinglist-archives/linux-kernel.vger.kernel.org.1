Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575EC26DA75
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIQLjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:39:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726823AbgIQL3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:29:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 36996BE1C8DBDD309115;
        Thu, 17 Sep 2020 19:29:01 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 19:28:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <mingo@kernel.org>, <peterz@infradead.org>,
        <ebiederm@xmission.com>, <christian@kellner.me>,
        <surenb@google.com>, <areber@redhat.com>, <shakeelb@google.com>,
        <cyphar@cyphar.com>, <tglx@linutronix.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: Use helper function mapping_allow_writable()
Date:   Thu, 17 Sep 2020 07:27:36 -0400
Message-ID: <20200917112736.7789-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4bb5f5d9395b ("mm: allow drivers to prevent new writable mappings")
changed i_mmap_writable from unsigned int to atomic_t and add the helper
function mapping_allow_writable() to atomic_inc i_mmap_writable. But it
forgot to use this helper function in dup_mmap() and __vma_link_file().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/fork.c | 2 +-
 mm/mmap.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 11ed5ac35caf..b9164b75b20c 100644
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
diff --git a/mm/mmap.c b/mm/mmap.c
index e3a1c1b48909..ae9ef433f830 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -665,7 +665,7 @@ static void __vma_link_file(struct vm_area_struct *vma)
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file_inode(file)->i_writecount);
 		if (vma->vm_flags & VM_SHARED)
-			atomic_inc(&mapping->i_mmap_writable);
+			mapping_allow_writable(mapping);
 
 		flush_dcache_mmap_lock(mapping);
 		vma_interval_tree_insert(vma, &mapping->i_mmap);
-- 
2.19.1

