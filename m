Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9B2F6076
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbhANLp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:45:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10656 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbhANLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:45:55 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DGjBv6mwtz15sjL;
        Thu, 14 Jan 2021 19:44:07 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Jan 2021
 19:45:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: Use helper huge_page_order and pages_per_huge_page
Date:   Thu, 14 Jan 2021 06:44:35 -0500
Message-ID: <20210114114435.40075-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a5516438959d ("hugetlb: modular state for hugetlb page size"),
we can use huge_page_order to access hstate->order and pages_per_huge_page
to fetch the pages per huge page. But gather_bootmem_prealloc() forgot to
use it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fe2da9ad6233..c04d922757c7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2476,7 +2476,7 @@ static void __init gather_bootmem_prealloc(void)
 		struct hstate *h = m->hstate;
 
 		WARN_ON(page_count(page) != 1);
-		prep_compound_huge_page(page, h->order);
+		prep_compound_huge_page(page, huge_page_order(h));
 		WARN_ON(PageReserved(page));
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
@@ -2488,7 +2488,7 @@ static void __init gather_bootmem_prealloc(void)
 		 * side-effects, like CommitLimit going negative.
 		 */
 		if (hstate_is_gigantic(h))
-			adjust_managed_page_count(page, 1 << h->order);
+			adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
 }
-- 
2.19.1

