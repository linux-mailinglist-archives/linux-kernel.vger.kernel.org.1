Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31C9277054
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgIXLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:54:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727458AbgIXLyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:54:08 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3A9371F070D91D23B54A;
        Thu, 24 Sep 2020 19:54:04 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 19:53:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <mingo@kernel.org>, <peterz@infradead.org>,
        <ebiederm@xmission.com>, <christian@kellner.me>,
        <surenb@google.com>, <areber@redhat.com>, <shakeelb@google.com>,
        <cyphar@cyphar.com>, <tglx@linutronix.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: Use helper function put_write_access()
Date:   Thu, 24 Sep 2020 07:52:35 -0400
Message-ID: <20200924115235.5111-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 1da177e4c3f4 ("Linux-2.6.12-rc2"), the helper put_write_access()
came with the atomic_dec operation of the i_writecount field. But it forgot
to use this helper in __vma_link_file() and dup_mmap().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/fork.c | 2 +-
 mm/mmap.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index b9164b75b20c..c92bbbdcc6ad 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -555,7 +555,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 			get_file(file);
 			if (tmp->vm_flags & VM_DENYWRITE)
-				atomic_dec(&inode->i_writecount);
+				put_write_access(inode);
 			i_mmap_lock_write(mapping);
 			if (tmp->vm_flags & VM_SHARED)
 				mapping_allow_writable(mapping);
diff --git a/mm/mmap.c b/mm/mmap.c
index fc1bd8264407..9b211e8b267d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -663,7 +663,7 @@ static void __vma_link_file(struct vm_area_struct *vma)
 		struct address_space *mapping = file->f_mapping;
 
 		if (vma->vm_flags & VM_DENYWRITE)
-			atomic_dec(&file_inode(file)->i_writecount);
+			put_write_access(file_inode(file));
 		if (vma->vm_flags & VM_SHARED)
 			mapping_allow_writable(mapping);
 
-- 
2.19.1

