Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B82D4FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgLJAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgLJAoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:44:15 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46573C0611CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:43:47 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id m185so2215805qkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sUpjC2JGVFFWHT2eOX4v5Pd/VbxmqCdGzRg2mz4PxH0=;
        b=cZikR+BeHtWn6M7s+IlCMr3/UuAQ5Ar0APOR0SvjzWfOTd5DE7tvyvarLLSgwkqSis
         XbrAoIWDR3Fac/+0JXDiXLCy/u95KDigXA3b1hdYsBMGjeokv5Qyw/h9fa+CoWJKfG43
         WnF5pg8pyyJzwJLzfwD2HMuKz5i0JvcZnMhyDndY81imB9SVwQR5xQyN02diPodndXsY
         S/CXCR9ezkPpyFFpMRxlr1DMUKt2qrw1tM4Z0lAtiNR8lLorsKDZF3zx94i2YJtL+LXm
         LAkbOfFiz5A/XiffhzSLpvBTddVDN+cv2HALO5EazslsZiJ/W3+omgm76d+odBso4xKN
         J2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUpjC2JGVFFWHT2eOX4v5Pd/VbxmqCdGzRg2mz4PxH0=;
        b=jMBe5/wFjsMU7fGd+3R3Jeb90FWtgVb8TZ/fC6lMFNs1ED25aEOILaoFzfvpbcxDPt
         92IDo9FBTiiqiHNU11k0bAbvg5zRAJMgxzFqVVjzuueADPShrhJSvy8Rdkfl9+8majc1
         Ftp+Kh/qEcmNfIJrggxIayU/nHRU8JEMxNZevw6WJyAHwXj5vAbOT2RYnrllqiYd5cms
         mgYSuLcH4+ZglAqhazRuc8MAKvpVq7J+AQiNqH6CVs1/y3d6ldeXEdZQjYv9zTht0veF
         0B8QyfIs1yfzeMhYkRXk0AmqdtgroCAj74UH50FTZ07/+AAOeX6FRcXtK+fv/l9wACn/
         Q4og==
X-Gm-Message-State: AOAM532xNwT5xiZG2tCrOGEvW7dcCq9MjH8jAg8xcHKZGXVTjYPkkyg8
        ouKaeEwjbVaT6lo0kdwiJDVQzw==
X-Google-Smtp-Source: ABdhPJxpG6COXfUw6XI/ibVZKCss5u6FLno1P2o5X8L0HXLNfwnptSeK3jVyPLbr4+90apRx6fDu0A==
X-Received: by 2002:a37:4d58:: with SMTP id a85mr6051943qkb.324.1607561026529;
        Wed, 09 Dec 2020 16:43:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y1sm2538745qky.63.2020.12.09.16.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:43:45 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 5/8] mm: apply per-task gfp constraints in fast path
Date:   Wed,  9 Dec 2020 19:43:32 -0500
Message-Id: <20201210004335.64634-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210004335.64634-1-pasha.tatashin@soleen.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function current_gfp_context() is called after fast path. However, soon we
will add more constraints which will also limit zones based on context.
Move this call into fast path, and apply the correct constraints for all
allocations.

Also update .reclaim_idx based on value returned by current_gfp_context()
because it soon will modify the allowed zones.

Note:
With this patch we will do one extra current->flags load during fast path,
but we already load current->flags in fast-path:

__alloc_pages_nodemask()
 prepare_alloc_pages()
  current_alloc_flags(gfp_mask, *alloc_flags);

Later, when we add the zone constrain logic to current_gfp_context() we
will be able to remove current->flags load from current_alloc_flags, and
therefore return fast-path to the current performance level.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_alloc.c | 15 ++++++++-------
 mm/vmscan.c     | 10 ++++++----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2dea5600f308..24c99b3b12af 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4932,6 +4932,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	}
 
 	gfp_mask &= gfp_allowed_mask;
+	/*
+	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
+	 * resp. GFP_NOIO which has to be inherited for all allocation requests
+	 * from a particular context which has been marked by
+	 * memalloc_no{fs,io}_{save,restore}.
+	 */
+	gfp_mask = current_gfp_context(gfp_mask);
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
@@ -4947,13 +4954,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	if (likely(page))
 		goto out;
 
-	/*
-	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
-	 * resp. GFP_NOIO which has to be inherited for all allocation requests
-	 * from a particular context which has been marked by
-	 * memalloc_no{fs,io}_{save,restore}.
-	 */
-	alloc_mask = current_gfp_context(gfp_mask);
+	alloc_mask = gfp_mask;
 	ac.spread_dirty_pages = false;
 
 	/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b4e31eac2cf..f51581e33fe6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3233,11 +3233,12 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 				gfp_t gfp_mask, nodemask_t *nodemask)
 {
+	gfp_t current_gfp_mask = current_gfp_context(gfp_mask);
 	unsigned long nr_reclaimed;
 	struct scan_control sc = {
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
-		.gfp_mask = current_gfp_context(gfp_mask),
-		.reclaim_idx = gfp_zone(gfp_mask),
+		.gfp_mask = current_gfp_mask,
+		.reclaim_idx = gfp_zone(current_gfp_mask),
 		.order = order,
 		.nodemask = nodemask,
 		.priority = DEF_PRIORITY,
@@ -4157,17 +4158,18 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 {
 	/* Minimum pages needed in order to stay on node */
 	const unsigned long nr_pages = 1 << order;
+	gfp_t current_gfp_mask = current_gfp_context(gfp_mask);
 	struct task_struct *p = current;
 	unsigned int noreclaim_flag;
 	struct scan_control sc = {
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
-		.gfp_mask = current_gfp_context(gfp_mask),
+		.gfp_mask = current_gfp_mask,
 		.order = order,
 		.priority = NODE_RECLAIM_PRIORITY,
 		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
 		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
 		.may_swap = 1,
-		.reclaim_idx = gfp_zone(gfp_mask),
+		.reclaim_idx = gfp_zone(current_gfp_mask),
 	};
 
 	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
-- 
2.25.1

