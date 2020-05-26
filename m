Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A619B19DFB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgDCUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 16:41:44 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33386 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727842AbgDCUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:41:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TuXBChy_1585946493;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TuXBChy_1585946493)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Apr 2020 04:41:40 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     daniel.m.jordan@oracle.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: thp: don't need drain lru cache when splitting and mlocking THP
Date:   Sat,  4 Apr 2020 04:41:33 +0800
Message-Id: <1585946493-7531-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 8f182270dfec ("mm/swap.c: flush lru pvecs on compound
page arrival") THP would not stay in pagevec anymore.  So the
optimization made by commit d965432234db ("thp: increase
split_huge_page() success rate") doesn't make sense anymore, which tries
to unpin munlocked THPs from pagevec by draining pagevec.

Draining lru cache before isolating THP in mlock path is also unnecessary.
b676b293fb48 ("mm, thp: fix mapped pages avoiding unevictable list on mlock")
added it and 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge
pages") accidentally carried it over after the above optimization went in.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: * Adopted comment from Daniel about the commit log.
    * Collected Review and Ack from Daniel and Kirill.

 mm/huge_memory.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199..1af2e7d6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1527,7 +1527,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 			goto skip_mlock;
 		if (!trylock_page(page))
 			goto skip_mlock;
-		lru_add_drain();
 		if (page->mapping && !PageDoubleMap(page))
 			mlock_vma_page(page);
 		unlock_page(page);
@@ -2711,7 +2710,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
-	bool mlocked;
 	unsigned long flags;
 	pgoff_t end;
 
@@ -2770,14 +2768,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		goto out_unlock;
 	}
 
-	mlocked = PageMlocked(head);
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
-	/* Make sure the page is not on per-CPU pagevec as it takes pin */
-	if (mlocked)
-		lru_add_drain();
-
 	/* prevent PageLRU to go away from under us, and freeze lru stats */
 	spin_lock_irqsave(&pgdata->lru_lock, flags);
 
-- 
1.8.3.1

