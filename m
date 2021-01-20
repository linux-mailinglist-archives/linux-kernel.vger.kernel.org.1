Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54B2FCB61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbhATHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:16:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11034 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbhATHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:16:20 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DLGx268hwzj9mH;
        Wed, 20 Jan 2021 15:14:30 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Jan 2021
 15:15:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] hugetlbfs: remove meaningless variable avoid_reserve
Date:   Wed, 20 Jan 2021 02:15:08 -0500
Message-ID: <20210120071508.9078-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable avoid_reserve is meaningless because we never changed its
value and just passed it to alloc_huge_page(). So remove it to make code
more clear that in hugetlbfs_fallocate, we never avoid reserve when alloc
hugepage yet. Also add a comment offered by Mike Kravetz to explain this.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4bbfd78a7ccb..14df2f73b8ef 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -680,7 +680,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct page *page;
 		unsigned long addr;
-		int avoid_reserve = 0;
 
 		cond_resched();
 
@@ -716,8 +715,15 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 			continue;
 		}
 
-		/* Allocate page and add to page cache */
-		page = alloc_huge_page(&pseudo_vma, addr, avoid_reserve);
+		/*
+		 * Allocate page without setting the avoid_reserve argument.
+		 * There certainly are no reserves associated with the
+		 * pseudo_vma.  However, there could be shared mappings with
+		 * reserves for the file at the inode level.  If we fallocate
+		 * pages in these areas, we need to consume the reserves
+		 * to keep reservation accounting consistent.
+		 */
+		page = alloc_huge_page(&pseudo_vma, addr, 0);
 		hugetlb_drop_vma_policy(&pseudo_vma);
 		if (IS_ERR(page)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-- 
2.19.1

