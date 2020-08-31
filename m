Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA92571D3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 04:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHaCY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 22:24:29 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55550 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgHaCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:24:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7IrQYV_1598840641;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7IrQYV_1598840641)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 10:24:01 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v3 7/7] mm/hugetlb: take the free hpage during the iteration directly
Date:   Mon, 31 Aug 2020 10:23:51 +0800
Message-Id: <20200831022351.20916-8-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
References: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function dequeue_huge_page_node_exact() iterates the free list and
return the first valid free hpage.

Instead of break and check the loop variant, we could return in the loop
directly. This could reduce some redundant check.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/hugetlb.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7b3357c1dcec..709be7ab65af 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1040,21 +1040,17 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (nocma && is_migrate_cma_page(page))
 			continue;
 
-		if (!PageHWPoison(page))
+		if (PageHWPoison(page))
 			break;
+
+		list_move(&page->lru, &h->hugepage_activelist);
+		set_page_refcounted(page);
+		h->free_huge_pages--;
+		h->free_huge_pages_node[nid]--;
+		return page;
 	}
 
-	/*
-	 * if 'non-isolated free hugepage' not found on the list,
-	 * the allocation fails.
-	 */
-	if (&h->hugepage_freelists[nid] == &page->lru)
-		return NULL;
-	list_move(&page->lru, &h->hugepage_activelist);
-	set_page_refcounted(page);
-	h->free_huge_pages--;
-	h->free_huge_pages_node[nid]--;
-	return page;
+	return NULL;
 }
 
 static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-- 
2.20.1 (Apple Git-117)

