Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BA2EFE92
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbhAIICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:02:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10124 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbhAIICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:02:51 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DCXTy6Dv0z15pfS;
        Sat,  9 Jan 2021 16:01:10 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Sat, 9 Jan 2021
 16:02:00 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <tglx@linutronix.de>, <dave.hansen@intel.com>,
        <ak@linux.intel.com>, <jpoimboe@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm: Fix potential pte_unmap_unlock pte error
Date:   Sat, 9 Jan 2021 03:01:18 -0500
Message-ID: <20210109080118.20885-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 42e4089c7890 ("x86/speculation/l1tf: Disallow non privileged
high MMIO PROT_NONE mappings"), when the first pfn modify is not allowed,
we would break the loop with pte unchanged. Then the wrong pte - 1 would
be passed to pte_unmap_unlock.

Fixes: 42e4089c789 ("x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings")
Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@kernel.org
---
 mm/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..351b78ebd5a4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2165,11 +2165,11 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
-	pte_t *pte;
+	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 	int err = 0;
 
-	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
+	mapped_pte = pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
 	arch_enter_lazy_mmu_mode();
@@ -2183,7 +2183,7 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
-	pte_unmap_unlock(pte - 1, ptl);
+	pte_unmap_unlock(mapped_pte, ptl);
 	return err;
 }
 
-- 
2.19.1

