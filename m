Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B9129231A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgJSHtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:49:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727612AbgJSHtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:49:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A5084D8C6022345DAAD2;
        Mon, 19 Oct 2020 15:49:13 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 19 Oct 2020
 15:49:07 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <osalvador@suse.de>, <mhocko@suse.com>, <linmiaohe@huawei.com>,
        <linfeilong@huawei.com>, <luoshijie1@huawei.com>
Subject: [PATCH] mm: mempolicy: fix potential pte_unmap_unlock pte error
Date:   Mon, 19 Oct 2020 03:48:53 -0400
Message-ID: <20201019074853.50856-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flags in queue_pages_pte_range don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL
 bits, code breaks and passing origin pte - 1 to pte_unmap_unlock seems like
not a good idea.

queue_pages_pte_range can run in MPOL_MF_MOVE_ALL mode which doesn't migrate
misplaced pages but returns with EIO when encountering such a page. Since
commit a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT
 is specified") and early break on the first pte in the range results in
pte_unmap_unlock on an underflow pte. This can lead to lockups later on when
 somebody  tries to lock the pte resp. page_table_lock again..

Fixes: a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when
MPOL_MF_STRICT is specified")

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mempolicy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3fde772ef5ef..3ca4898f3f24 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -525,7 +525,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long flags = qp->flags;
 	int ret;
 	bool has_unmovable = false;
-	pte_t *pte;
+	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -539,7 +539,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
@@ -571,7 +571,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		} else
 			break;
 	}
-	pte_unmap_unlock(pte - 1, ptl);
+	pte_unmap_unlock(mapped_pte, ptl);
 	cond_resched();
 
 	if (has_unmovable)
-- 
2.19.1

