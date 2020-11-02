Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE42A2D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKBOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:40:23 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:10189 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKBOkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:40:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604328021; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=BAmD8TtrxrmTztZhyNakoE+6qpeDFNkhSNT5JSZJ3Mg=; b=ei/y2sdT2qbdWeKwwwqXb5mzE31cYJaIq9DAX3j7bLdhqvkRMdK4FVw+bVuSpE4yy2pB7o04
 opdZKur1QKglTFZMuirUt1kjE8XPBqPH31E/aByJdOU11y9CYgI4hPuhKpBTdYXy4eLGkyC2
 HtVsGpnC7cwFWeC6JYBJd4zFRV4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa01a55d8a9d167f3025a7b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 14:40:21
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4151EC433F0; Mon,  2 Nov 2020 14:40:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01292C433C8;
        Mon,  2 Nov 2020 14:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01292C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Heesub Shin <heesub.shin@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH 1/2] cma: redirect page allocation to CMA
Date:   Mon,  2 Nov 2020 06:39:21 -0800
Message-Id: <3f99bcf028ea80a0de785f99f60a1c3a7bd89a9e.1604282969.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1604282969.git.cgoldswo@codeaurora.org>
References: <cover.1604282969.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1604282969.git.cgoldswo@codeaurora.org>
References: <cover.1604282969.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heesub Shin <heesub.shin@samsung.com>

CMA pages are designed to be used as fallback for movable allocations
and cannot be used for non-movable allocations. If CMA pages are
utilized poorly, non-movable allocations may end up getting starved if
all regular movable pages are allocated and the only pages left are
CMA. Always using CMA pages first creates unacceptable performance
problems. As a midway alternative, use CMA pages for certain
userspace allocations. The userspace pages can be migrated or dropped
quickly which giving decent utilization.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Heesub Shin <heesub.shin@samsung.com>
Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
[cgoldswo@codeaurora.org: Place in bugfixes]
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
---
 include/linux/gfp.h     | 15 +++++++++
 include/linux/highmem.h |  4 ++-
 include/linux/mmzone.h  |  4 +++
 mm/page_alloc.c         | 83 +++++++++++++++++++++++++++++++------------------
 4 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c603237..e80b7d2 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,11 +39,21 @@ struct vm_area_struct;
 #define ___GFP_HARDWALL		0x100000u
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
+#ifdef CONFIG_CMA
+#define ___GFP_CMA		0x800000u
+#else
+#define ___GFP_CMA		0
+#endif
 #ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_CMA
+#define ___GFP_NOLOCKDEP	0x1000000u
+#else
 #define ___GFP_NOLOCKDEP	0x800000u
+#endif
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+
 /* If the above are modified, __GFP_BITS_SHIFT may need updating */
 
 /*
@@ -57,6 +67,7 @@ struct vm_area_struct;
 #define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
 #define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
 #define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
+#define __GFP_CMA	((__force gfp_t)___GFP_CMA)
 #define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
 
 /**
@@ -224,7 +235,11 @@ struct vm_area_struct;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
+#ifdef CONFIG_CMA
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
+#else
 #define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#endif
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 14e6202..35f052b 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -274,7 +274,9 @@ static inline struct page *
 alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 					unsigned long vaddr)
 {
-	return __alloc_zeroed_user_highpage(__GFP_MOVABLE, vma, vaddr);
+	return __alloc_zeroed_user_highpage(
+			__GFP_MOVABLE|__GFP_CMA, vma,
+			vaddr);
 }
 
 static inline void clear_highpage(struct page *page)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf69..3f913be 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -471,6 +471,10 @@ struct zone {
 	struct pglist_data	*zone_pgdat;
 	struct per_cpu_pageset __percpu *pageset;
 
+#ifdef CONFIG_CMA
+	bool			cma_alloc;
+#endif
+
 #ifndef CONFIG_SPARSEMEM
 	/*
 	 * Flags for a pageblock_nr_pages block. See pageblock-flags.h.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d772206..f938de7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2860,35 +2860,34 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 {
 	struct page *page;
 
-#ifdef CONFIG_CMA
-	/*
-	 * Balance movable allocations between regular and CMA areas by
-	 * allocating from CMA when over half of the zone's free memory
-	 * is in the CMA area.
-	 */
-	if (alloc_flags & ALLOC_CMA &&
-	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
-		page = __rmqueue_cma_fallback(zone, order);
-		if (page)
-			return page;
-	}
-#endif
 retry:
 	page = __rmqueue_smallest(zone, order, migratetype);
-	if (unlikely(!page)) {
-		if (alloc_flags & ALLOC_CMA)
-			page = __rmqueue_cma_fallback(zone, order);
 
-		if (!page && __rmqueue_fallback(zone, order, migratetype,
-								alloc_flags))
-			goto retry;
-	}
+	if (unlikely(!page) && __rmqueue_fallback(zone, order, migratetype,
+						  alloc_flags))
+		goto retry;
 
 	trace_mm_page_alloc_zone_locked(page, order, migratetype);
 	return page;
 }
 
+static struct page *__rmqueue_cma(struct zone *zone, unsigned int order,
+				  int migratetype,
+				  unsigned int alloc_flags)
+{
+	struct page *page = 0;
+
+#ifdef CONFIG_CMA
+	if (migratetype == MIGRATE_MOVABLE && !zone->cma_alloc)
+		page = __rmqueue_cma_fallback(zone, order);
+	else
+#endif
+		page = __rmqueue_smallest(zone, order, migratetype);
+
+	trace_mm_page_alloc_zone_locked(page, order, MIGRATE_CMA);
+	return page;
+}
+
 /*
  * Obtain a specified number of elements from the buddy allocator, all under
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
@@ -2896,14 +2895,20 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
-			int migratetype, unsigned int alloc_flags)
+			int migratetype, unsigned int alloc_flags, int cma)
 {
 	int i, alloced = 0;
 
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
-		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+		struct page *page;
+
+		if (cma)
+			page = __rmqueue_cma(zone, order, migratetype,
+					     alloc_flags);
+		else
+			page = __rmqueue(zone, order, migratetype, alloc_flags);
+
 		if (unlikely(page == NULL))
 			break;
 
@@ -3388,7 +3393,8 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
 static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 			unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
-			struct list_head *list)
+			struct list_head *list,
+			gfp_t gfp_flags)
 {
 	struct page *page;
 
@@ -3396,7 +3402,8 @@ static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 		if (list_empty(list)) {
 			pcp->count += rmqueue_bulk(zone, 0,
 					pcp->batch, list,
-					migratetype, alloc_flags);
+					migratetype, alloc_flags,
+					gfp_flags && __GFP_CMA);
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
@@ -3422,7 +3429,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	local_irq_save(flags);
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
 	list = &pcp->lists[migratetype];
-	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list,
+				 gfp_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone);
@@ -3448,7 +3456,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
 		 * we need to skip it when CMA area isn't allowed.
 		 */
-		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
+		if (!IS_ENABLED(CONFIG_CMA) || gfp_flags & __GFP_CMA ||
 				migratetype != MIGRATE_MOVABLE) {
 			page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
 					migratetype, alloc_flags);
@@ -3476,8 +3484,14 @@ struct page *rmqueue(struct zone *preferred_zone,
 			if (page)
 				trace_mm_page_alloc_zone_locked(page, order, migratetype);
 		}
-		if (!page)
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
+		if (!page) {
+			if (gfp_flags & __GFP_CMA)
+				page = __rmqueue_cma(zone, order, migratetype,
+						     alloc_flags);
+			else
+				page = __rmqueue(zone, order, migratetype,
+						 alloc_flags);
+		}
 	} while (page && check_new_pages(page, order));
 	spin_unlock(&zone->lock);
 	if (!page)
@@ -3790,7 +3804,8 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
 	unsigned int pflags = current->flags;
 
 	if (!(pflags & PF_MEMALLOC_NOCMA) &&
-			gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+			gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE &&
+			gfp_mask & __GFP_CMA)
 		alloc_flags |= ALLOC_CMA;
 
 #endif
@@ -8529,6 +8544,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_CMA
+	cc.zone->cma_alloc = 1;
+#endif
 	/*
 	 * In case of -EBUSY, we'd like to know which page causes problem.
 	 * So, just fall through. test_pages_isolated() has a tracepoint
@@ -8610,6 +8628,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 done:
 	undo_isolate_page_range(pfn_max_align_down(start),
 				pfn_max_align_up(end), migratetype);
+#ifdef CONFIG_CMA
+	cc.zone->cma_alloc = 0;
+#endif
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

