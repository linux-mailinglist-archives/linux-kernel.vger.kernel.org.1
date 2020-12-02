Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303C92CB482
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgLBFYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgLBFYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:24:38 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB0C061A47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:23:45 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id v3so449260ilo.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pyAQwS4Co7I2R95ag+5lXrPe/9p6neLUf3n9lgyrkG0=;
        b=kRknJsSQGtDUohS7hN3L95LW6SIb5DalNHHH0d5LSFjWcttO34k/TSUtL0SfKRRaIL
         +adzzZ0P//8mfJ5hh7Lo8vss3XDPG9mh0MbXEluUFMMezkGfg00sb5ZqM4B+BzBbTKfT
         LHeGZLAlYWA+YO9yBEIdiIEeaYa9QIp9AjT+NSTBaM8V+GpFhuQMghQ2k7mmVhTS4JxH
         wKiDJYMXgzDASGPKAOmxSq/zDsxk6rhnu5b9wFZn9ACVOqWTj0agFa72tzERrDhIl/Qc
         7LwsnYuOmJ5miF6Z48UyA9E55Ftc4dn73D1FotjYKNc2gLS0jdNS0EUHX91BN9CbKE8p
         Gcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyAQwS4Co7I2R95ag+5lXrPe/9p6neLUf3n9lgyrkG0=;
        b=lEX8onI5oX/3EH2wEKDsdG1PZCjKB/2DwgQBM4loKksAkzLiAVD1Qy/hprapJWfv61
         E7GmB3YkU/i/RU1R9V+ssTm4UsYqo5Yj/XpGU1HHSmn3aqGPML1o2A+wF3bwBYL5n7S1
         BhzXfjcBi2Ss1UlwB4MIZ39QICgFbg8cSJz6S320kwMPtp3Rs4kCDnid7dfxmpzY1aj9
         04MwNG0SJYfqaMCyLI9casheg/bEtmkzMHFV2DJtUMLMOME0r7y7Lz6eESWnZwbIf9qS
         Lrsv/7Qjo1kJYzjvmuS7t0KkVAxGL3NEr8/1MPBJhYV8h/jwDX4PSHywO6Auf/Q7sAlq
         Fi+w==
X-Gm-Message-State: AOAM532INJ3ozRrb0XeM2TJtqd39kFTklxeqy47Kil1TYsqSfepQ4/vW
        htip7D7i6ByW5c5N3LlYiwLfzA==
X-Google-Smtp-Source: ABdhPJz0k5IzB0S69VOwNzsfUHyaCVWqenfV/i20fxRSf01ht5jDP/pDg/VPs9BmYrKW9bm90bbjOQ==
X-Received: by 2002:a92:850f:: with SMTP id f15mr991400ilh.286.1606886624807;
        Tue, 01 Dec 2020 21:23:44 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m19sm295938ila.81.2020.12.01.21.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:23:44 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
Date:   Wed,  2 Dec 2020 00:23:29 -0500
Message-Id: <20201202052330.474592-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202052330.474592-1-pasha.tatashin@soleen.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PF_MEMALLOC_NOMOVABLE is only honored for CMA allocations, extend
this flag to work for any allocations by removing __GFP_MOVABLE from
gfp_mask when this flag is passed in the current context, thus
prohibiting allocations from ZONE_MOVABLE.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/hugetlb.c    |  2 +-
 mm/page_alloc.c | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 02213c74ed6b..00e786201d8b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1036,7 +1036,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 	bool nomovable = !!(current->flags & PF_MEMALLOC_NOMOVABLE);
 
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (nomovable && is_migrate_cma_page(page))
+		if (nomovable && is_migrate_movable(get_pageblock_migratetype(page)))
 			continue;
 
 		if (PageHWPoison(page))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 611799c72da5..7a6d86d0bc5f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3766,20 +3766,25 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 	return alloc_flags;
 }
 
-static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
-					unsigned int alloc_flags)
+static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
+					   unsigned int alloc_flags)
 {
 #ifdef CONFIG_CMA
-	unsigned int pflags = current->flags;
-
-	if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
-	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
-
 #endif
 	return alloc_flags;
 }
 
+static inline gfp_t current_gfp_checkmovable(gfp_t gfp_mask)
+{
+	unsigned int pflags = current->flags;
+
+	if ((pflags & PF_MEMALLOC_NOMOVABLE))
+		return gfp_mask & ~__GFP_MOVABLE;
+	return gfp_mask;
+}
+
 /*
  * get_page_from_freelist goes through the zonelist trying to allocate
  * a page.
@@ -4423,7 +4428,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	} else if (unlikely(rt_task(current)) && !in_interrupt())
 		alloc_flags |= ALLOC_HARDER;
 
-	alloc_flags = current_alloc_flags(gfp_mask, alloc_flags);
+	alloc_flags = cma_alloc_flags(gfp_mask, alloc_flags);
 
 	return alloc_flags;
 }
@@ -4725,7 +4730,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
+		alloc_flags = cma_alloc_flags(gfp_mask, reserve_flags);
 
 	/*
 	 * Reset the nodemask and zonelist iterators if memory policies can be
@@ -4894,7 +4899,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	if (should_fail_alloc_page(gfp_mask, order))
 		return false;
 
-	*alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
+	*alloc_flags = cma_alloc_flags(gfp_mask, *alloc_flags);
 
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
@@ -4932,6 +4937,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	}
 
 	gfp_mask &= gfp_allowed_mask;
+	gfp_mask = current_gfp_checkmovable(gfp_mask);
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
-- 
2.25.1

