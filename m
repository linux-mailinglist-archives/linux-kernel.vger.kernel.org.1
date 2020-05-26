Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ABA1AD500
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 05:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgDQD7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgDQD7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:59:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A1FC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:59:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so469840pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0k9vGiIvKiXc9P8qhjoimtq/rzHlgq7GcXCT6gOUS1s=;
        b=BHFaO2n5DrTV6RefiLLhKEdIPKMNX/w2f8jKMteTQeBgooS9GuBSw/dMeNRUhNUn4v
         8YzuhHGcmA78N6kr5Eg9WIuPwvtl8vY9eaL5gt6dDi37iKDQ+42np2hI73jlCJJsRb2e
         y8SiSz4YtFZRa11gVBgdk29VZ9J6fWNgqCHTK5oHiiQVK2hBsXekVrHAIey1aO+Jqw+q
         sS/oUdS6aii/nBVr43KqseKT2j8cmfFG5lItQ3zo0FmuKjnVoJzgx7eM7v7MvKVdWJYg
         kc1ytCAwEjMjBHTtV7wWF/fSI2uvvSzEmyAwr8ce87MRs1vtBCvhZ3UYkRODyYruOwrY
         qRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0k9vGiIvKiXc9P8qhjoimtq/rzHlgq7GcXCT6gOUS1s=;
        b=g/mv51cgY9aZYr7ejyCFHI3xGAtd6b1xaTwbPdwmSkWExSIJRZRCGjNWvRJC99kwGq
         +cR1tQPZzCFXnorrR3GnaCXJEXNiPil6qW7+kUWCHUoSStIiOgDTly5CbL4P+bGpKtYR
         fegOspuaHvWmsonXgWJfCAFOVkPSxknTpLTIegry+xaRJASuwjCvnrMe2y3lF7JSzNU/
         4I2IyiB90hjqb3pHS3UQ94Hh3orI3ej4sJDf6UTjbbdGScFVyokHNjNEVkQCGbP4rPh2
         bScTf15MykIwB5GCMd8bQw54SY/s2nPMEyrgQe1XeFshUhj9suPpBDKrKVlFmGILis+3
         yELw==
X-Gm-Message-State: AGi0PubuPgm+wsn83UQVV58RFiF7y69A9Mt0PrDwaP9KiIJR1tnCLRP2
        wl6f2uOQZeUxJhBzPsrg9ZQ=
X-Google-Smtp-Source: APiQypKie6udIfoHMo0CGNwi+RAFjUuor82x5gGbFn+tDDFjtM3ReN00uJSiI2JwIiafNp/+gJNS7w==
X-Received: by 2002:a63:da47:: with SMTP id l7mr1106351pgj.315.1587095958125;
        Thu, 16 Apr 2020 20:59:18 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id g12sm3525454pfm.129.2020.04.16.20.59.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 20:59:17 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Baoquan He <bhe@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 2/2] mm/page_alloc: integrate classzone_idx and high_zoneidx
Date:   Fri, 17 Apr 2020 12:58:43 +0900
Message-Id: <1587095923-7515-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587095923-7515-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1587095923-7515-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

classzone_idx is just different name for high_zoneidx now.
So, integrate them and add some comment to struct alloc_context
in order to reduce future confusion about the meaning of this variable.

The accessor, ac_classzone_idx() is also removed since it isn't needed
after integration.

In addition to integration, this patch also renames high_zoneidx
to highest_zoneidx since it represents more precise meaning.

Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/compaction.h        |   9 ++--
 include/linux/mmzone.h            |  12 ++---
 include/trace/events/compaction.h |  22 ++++----
 include/trace/events/vmscan.h     |  14 +++--
 mm/compaction.c                   |  64 +++++++++++------------
 mm/internal.h                     |  21 +++++---
 mm/memory_hotplug.c               |   6 +--
 mm/oom_kill.c                     |   4 +-
 mm/page_alloc.c                   |  60 +++++++++++-----------
 mm/slab.c                         |   4 +-
 mm/slub.c                         |   4 +-
 mm/vmscan.c                       | 105 ++++++++++++++++++++------------------
 12 files changed, 175 insertions(+), 150 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 4b898cd..3ed2f22 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -97,7 +97,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone, int order,
-		unsigned int alloc_flags, int classzone_idx);
+		unsigned int alloc_flags, int highest_zoneidx);
 
 extern void defer_compaction(struct zone *zone, int order);
 extern bool compaction_deferred(struct zone *zone, int order);
@@ -182,7 +182,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 
 extern int kcompactd_run(int nid);
 extern void kcompactd_stop(int nid);
-extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx);
+extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
 
 #else
 static inline void reset_isolation_suitable(pg_data_t *pgdat)
@@ -190,7 +190,7 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 }
 
 static inline enum compact_result compaction_suitable(struct zone *zone, int order,
-					int alloc_flags, int classzone_idx)
+					int alloc_flags, int highest_zoneidx)
 {
 	return COMPACT_SKIPPED;
 }
@@ -232,7 +232,8 @@ static inline void kcompactd_stop(int nid)
 {
 }
 
-static inline void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx)
+static inline void wakeup_kcompactd(pg_data_t *pgdat,
+				int order, int highest_zoneidx)
 {
 }
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1b9de7d..7c9b718 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -697,13 +697,13 @@ typedef struct pglist_data {
 	struct task_struct *kswapd;	/* Protected by
 					   mem_hotplug_begin/end() */
 	int kswapd_order;
-	enum zone_type kswapd_classzone_idx;
+	enum zone_type kswapd_highest_zoneidx;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
 
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
-	enum zone_type kcompactd_classzone_idx;
+	enum zone_type kcompactd_highest_zoneidx;
 	wait_queue_head_t kcompactd_wait;
 	struct task_struct *kcompactd;
 #endif
@@ -781,15 +781,15 @@ static inline bool pgdat_is_empty(pg_data_t *pgdat)
 
 void build_all_zonelists(pg_data_t *pgdat);
 void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
-		   enum zone_type classzone_idx);
+		   enum zone_type highest_zoneidx);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
-			 int classzone_idx, unsigned int alloc_flags,
+			 int highest_zoneidx, unsigned int alloc_flags,
 			 long free_pages);
 bool zone_watermark_ok(struct zone *z, unsigned int order,
-		unsigned long mark, int classzone_idx,
+		unsigned long mark, int highest_zoneidx,
 		unsigned int alloc_flags);
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
-		unsigned long mark, int classzone_idx);
+		unsigned long mark, int highest_zoneidx);
 enum memmap_context {
 	MEMMAP_EARLY,
 	MEMMAP_HOTPLUG,
diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index e5bf6ee..54e5bf0 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -314,40 +314,44 @@ TRACE_EVENT(mm_compaction_kcompactd_sleep,
 
 DECLARE_EVENT_CLASS(kcompactd_wake_template,
 
-	TP_PROTO(int nid, int order, enum zone_type classzone_idx),
+	TP_PROTO(int nid, int order, enum zone_type highest_zoneidx),
 
-	TP_ARGS(nid, order, classzone_idx),
+	TP_ARGS(nid, order, highest_zoneidx),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
 		__field(int, order)
-		__field(enum zone_type, classzone_idx)
+		__field(enum zone_type, highest_zoneidx)
 	),
 
 	TP_fast_assign(
 		__entry->nid = nid;
 		__entry->order = order;
-		__entry->classzone_idx = classzone_idx;
+		__entry->highest_zoneidx = highest_zoneidx;
 	),
 
+	/*
+	 * classzone_idx is previous name of the highest_zoneidx.
+	 * Reason not to change it is the ABI requirement of the tracepoint.
+	 */
 	TP_printk("nid=%d order=%d classzone_idx=%-8s",
 		__entry->nid,
 		__entry->order,
-		__print_symbolic(__entry->classzone_idx, ZONE_TYPE))
+		__print_symbolic(__entry->highest_zoneidx, ZONE_TYPE))
 );
 
 DEFINE_EVENT(kcompactd_wake_template, mm_compaction_wakeup_kcompactd,
 
-	TP_PROTO(int nid, int order, enum zone_type classzone_idx),
+	TP_PROTO(int nid, int order, enum zone_type highest_zoneidx),
 
-	TP_ARGS(nid, order, classzone_idx)
+	TP_ARGS(nid, order, highest_zoneidx)
 );
 
 DEFINE_EVENT(kcompactd_wake_template, mm_compaction_kcompactd_wake,
 
-	TP_PROTO(int nid, int order, enum zone_type classzone_idx),
+	TP_PROTO(int nid, int order, enum zone_type highest_zoneidx),
 
-	TP_ARGS(nid, order, classzone_idx)
+	TP_ARGS(nid, order, highest_zoneidx)
 );
 #endif
 
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 74bb594..2070df6 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -265,7 +265,7 @@ TRACE_EVENT(mm_shrink_slab_end,
 );
 
 TRACE_EVENT(mm_vmscan_lru_isolate,
-	TP_PROTO(int classzone_idx,
+	TP_PROTO(int highest_zoneidx,
 		int order,
 		unsigned long nr_requested,
 		unsigned long nr_scanned,
@@ -274,10 +274,10 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		isolate_mode_t isolate_mode,
 		int lru),
 
-	TP_ARGS(classzone_idx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
+	TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
 
 	TP_STRUCT__entry(
-		__field(int, classzone_idx)
+		__field(int, highest_zoneidx)
 		__field(int, order)
 		__field(unsigned long, nr_requested)
 		__field(unsigned long, nr_scanned)
@@ -288,7 +288,7 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 	),
 
 	TP_fast_assign(
-		__entry->classzone_idx = classzone_idx;
+		__entry->highest_zoneidx = highest_zoneidx;
 		__entry->order = order;
 		__entry->nr_requested = nr_requested;
 		__entry->nr_scanned = nr_scanned;
@@ -298,9 +298,13 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__entry->lru = lru;
 	),
 
+	/*
+	 * classzone is previous name of the highest_zoneidx.
+	 * Reason not to change it is the ABI requirement of the tracepoint.
+	 */
 	TP_printk("isolate_mode=%d classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
 		__entry->isolate_mode,
-		__entry->classzone_idx,
+		__entry->highest_zoneidx,
 		__entry->order,
 		__entry->nr_requested,
 		__entry->nr_scanned,
diff --git a/mm/compaction.c b/mm/compaction.c
index 46f0fcc..18079fd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1966,7 +1966,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
  */
 static enum compact_result __compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
-					int classzone_idx,
+					int highest_zoneidx,
 					unsigned long wmark_target)
 {
 	unsigned long watermark;
@@ -1979,7 +1979,7 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	 * If watermarks for high-order allocation are already met, there
 	 * should be no need for compaction at all.
 	 */
-	if (zone_watermark_ok(zone, order, watermark, classzone_idx,
+	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
 								alloc_flags))
 		return COMPACT_SUCCESS;
 
@@ -1989,9 +1989,9 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	 * watermark and alloc_flags have to match, or be more pessimistic than
 	 * the check in __isolate_free_page(). We don't use the direct
 	 * compactor's alloc_flags, as they are not relevant for freepage
-	 * isolation. We however do use the direct compactor's classzone_idx to
-	 * skip over zones where lowmem reserves would prevent allocation even
-	 * if compaction succeeds.
+	 * isolation. We however do use the direct compactor's highest_zoneidx
+	 * to skip over zones where lowmem reserves would prevent allocation
+	 * even if compaction succeeds.
 	 * For costly orders, we require low watermark instead of min for
 	 * compaction to proceed to increase its chances.
 	 * ALLOC_CMA is used, as pages in CMA pageblocks are considered
@@ -2000,7 +2000,7 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
 				low_wmark_pages(zone) : min_wmark_pages(zone);
 	watermark += compact_gap(order);
-	if (!__zone_watermark_ok(zone, 0, watermark, classzone_idx,
+	if (!__zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
 						ALLOC_CMA, wmark_target))
 		return COMPACT_SKIPPED;
 
@@ -2009,12 +2009,12 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 
 enum compact_result compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
-					int classzone_idx)
+					int highest_zoneidx)
 {
 	enum compact_result ret;
 	int fragindex;
 
-	ret = __compaction_suitable(zone, order, alloc_flags, classzone_idx,
+	ret = __compaction_suitable(zone, order, alloc_flags, highest_zoneidx,
 				    zone_page_state(zone, NR_FREE_PAGES));
 	/*
 	 * fragmentation index determines if allocation failures are due to
@@ -2055,8 +2055,8 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	 * Make sure at least one zone would pass __compaction_suitable if we continue
 	 * retrying the reclaim.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-					ac->nodemask) {
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
+				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
 		enum compact_result compact_result;
 
@@ -2069,7 +2069,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		compact_result = __compaction_suitable(zone, order, alloc_flags,
-				ac_classzone_idx(ac), available);
+				ac->highest_zoneidx, available);
 		if (compact_result != COMPACT_SKIPPED)
 			return true;
 	}
@@ -2100,7 +2100,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
-							cc->classzone_idx);
+							cc->highest_zoneidx);
 	/* Compaction is likely to fail */
 	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
 		return ret;
@@ -2295,7 +2295,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 static enum compact_result compact_zone_order(struct zone *zone, int order,
 		gfp_t gfp_mask, enum compact_priority prio,
-		unsigned int alloc_flags, int classzone_idx,
+		unsigned int alloc_flags, int highest_zoneidx,
 		struct page **capture)
 {
 	enum compact_result ret;
@@ -2307,7 +2307,7 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 		.mode = (prio == COMPACT_PRIO_ASYNC) ?
 					MIGRATE_ASYNC :	MIGRATE_SYNC_LIGHT,
 		.alloc_flags = alloc_flags,
-		.classzone_idx = classzone_idx,
+		.highest_zoneidx = highest_zoneidx,
 		.direct_compaction = true,
 		.whole_zone = (prio == MIN_COMPACT_PRIORITY),
 		.ignore_skip_hint = (prio == MIN_COMPACT_PRIORITY),
@@ -2363,8 +2363,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 	trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
 
 	/* Compact each zone in the list */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-								ac->nodemask) {
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
+					ac->highest_zoneidx, ac->nodemask) {
 		enum compact_result status;
 
 		if (prio > MIN_COMPACT_PRIORITY
@@ -2374,7 +2374,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		}
 
 		status = compact_zone_order(zone, order, gfp_mask, prio,
-				alloc_flags, ac_classzone_idx(ac), capture);
+				alloc_flags, ac->highest_zoneidx, capture);
 		rc = max(status, rc);
 
 		/* The allocation should succeed, stop compacting */
@@ -2509,16 +2509,16 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 {
 	int zoneid;
 	struct zone *zone;
-	enum zone_type classzone_idx = pgdat->kcompactd_classzone_idx;
+	enum zone_type highest_zoneidx = pgdat->kcompactd_highest_zoneidx;
 
-	for (zoneid = 0; zoneid <= classzone_idx; zoneid++) {
+	for (zoneid = 0; zoneid <= highest_zoneidx; zoneid++) {
 		zone = &pgdat->node_zones[zoneid];
 
 		if (!populated_zone(zone))
 			continue;
 
 		if (compaction_suitable(zone, pgdat->kcompactd_max_order, 0,
-					classzone_idx) == COMPACT_CONTINUE)
+					highest_zoneidx) == COMPACT_CONTINUE)
 			return true;
 	}
 
@@ -2536,16 +2536,16 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 	struct compact_control cc = {
 		.order = pgdat->kcompactd_max_order,
 		.search_order = pgdat->kcompactd_max_order,
-		.classzone_idx = pgdat->kcompactd_classzone_idx,
+		.highest_zoneidx = pgdat->kcompactd_highest_zoneidx,
 		.mode = MIGRATE_SYNC_LIGHT,
 		.ignore_skip_hint = false,
 		.gfp_mask = GFP_KERNEL,
 	};
 	trace_mm_compaction_kcompactd_wake(pgdat->node_id, cc.order,
-							cc.classzone_idx);
+							cc.highest_zoneidx);
 	count_compact_event(KCOMPACTD_WAKE);
 
-	for (zoneid = 0; zoneid <= cc.classzone_idx; zoneid++) {
+	for (zoneid = 0; zoneid <= cc.highest_zoneidx; zoneid++) {
 		int status;
 
 		zone = &pgdat->node_zones[zoneid];
@@ -2594,16 +2594,16 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 
 	/*
 	 * Regardless of success, we are done until woken up next. But remember
-	 * the requested order/classzone_idx in case it was higher/tighter than
-	 * our current ones
+	 * the requested order/highest_zoneidx in case it was higher/tighter
+	 * than our current ones
 	 */
 	if (pgdat->kcompactd_max_order <= cc.order)
 		pgdat->kcompactd_max_order = 0;
-	if (pgdat->kcompactd_classzone_idx >= cc.classzone_idx)
-		pgdat->kcompactd_classzone_idx = pgdat->nr_zones - 1;
+	if (pgdat->kcompactd_highest_zoneidx >= cc.highest_zoneidx)
+		pgdat->kcompactd_highest_zoneidx = pgdat->nr_zones - 1;
 }
 
-void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx)
+void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
 {
 	if (!order)
 		return;
@@ -2611,8 +2611,8 @@ void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx)
 	if (pgdat->kcompactd_max_order < order)
 		pgdat->kcompactd_max_order = order;
 
-	if (pgdat->kcompactd_classzone_idx > classzone_idx)
-		pgdat->kcompactd_classzone_idx = classzone_idx;
+	if (pgdat->kcompactd_highest_zoneidx > highest_zoneidx)
+		pgdat->kcompactd_highest_zoneidx = highest_zoneidx;
 
 	/*
 	 * Pairs with implicit barrier in wait_event_freezable()
@@ -2625,7 +2625,7 @@ void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx)
 		return;
 
 	trace_mm_compaction_wakeup_kcompactd(pgdat->node_id, order,
-							classzone_idx);
+							highest_zoneidx);
 	wake_up_interruptible(&pgdat->kcompactd_wait);
 }
 
@@ -2646,7 +2646,7 @@ static int kcompactd(void *p)
 	set_freezable();
 
 	pgdat->kcompactd_max_order = 0;
-	pgdat->kcompactd_classzone_idx = pgdat->nr_zones - 1;
+	pgdat->kcompactd_highest_zoneidx = pgdat->nr_zones - 1;
 
 	while (!kthread_should_stop()) {
 		unsigned long pflags;
diff --git a/mm/internal.h b/mm/internal.h
index 0ab58df..ee63051 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -125,10 +125,10 @@ extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
  * between functions involved in allocations, including the alloc_pages*
  * family of functions.
  *
- * nodemask, migratetype and high_zoneidx are initialized only once in
+ * nodemask, migratetype and highest_zoneidx are initialized only once in
  * __alloc_pages_nodemask() and then never change.
  *
- * zonelist, preferred_zone and classzone_idx are set first in
+ * zonelist, preferred_zone and highest_zoneidx are set first in
  * __alloc_pages_nodemask() for the fast path, and might be later changed
  * in __alloc_pages_slowpath(). All other functions pass the whole strucure
  * by a const pointer.
@@ -138,12 +138,21 @@ struct alloc_context {
 	nodemask_t *nodemask;
 	struct zoneref *preferred_zoneref;
 	int migratetype;
-	enum zone_type high_zoneidx;
+
+	/*
+	 * highest_zoneidx represents highest usable zone index of
+	 * the allocation request. Due to the nature of the zone,
+	 * memory on lower zone than the highest_zoneidx will be
+	 * protected by lowmem_reserve[highest_zoneidx].
+	 *
+	 * highest_zoneidx is also used by reclaim/compaction to limit
+	 * the target zone since higher zone than this index cannot be
+	 * usable for this allocation request.
+	 */
+	enum zone_type highest_zoneidx;
 	bool spread_dirty_pages;
 };
 
-#define ac_classzone_idx(ac) (ac->high_zoneidx)
-
 /*
  * Locate the struct page for both the matching buddy in our
  * pair (buddy1) and the combined O(n+1) page they form (page).
@@ -222,7 +231,7 @@ struct compact_control {
 	int order;			/* order a direct compactor needs */
 	int migratetype;		/* migratetype of direct compactor */
 	const unsigned int alloc_flags;	/* alloc flags of a direct compactor */
-	const int classzone_idx;	/* zone index of a direct compactor */
+	const int highest_zoneidx;	/* zone index of a direct compactor */
 	enum migrate_mode mode;		/* Async or sync migration mode */
 	bool ignore_skip_hint;		/* Scan blocks even if marked skip */
 	bool no_set_skip_hint;		/* Don't mark blocks for skipping */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 47cf603..c550b5c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -883,13 +883,13 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 	} else {
 		int cpu;
 		/*
-		 * Reset the nr_zones, order and classzone_idx before reuse.
-		 * Note that kswapd will init kswapd_classzone_idx properly
+		 * Reset the nr_zones, order and highest_zoneidx before reuse.
+		 * Note that kswapd will init kswapd_highest_zoneidx properly
 		 * when it starts in the near future.
 		 */
 		pgdat->nr_zones = 0;
 		pgdat->kswapd_order = 0;
-		pgdat->kswapd_classzone_idx = 0;
+		pgdat->kswapd_highest_zoneidx = 0;
 		for_each_online_cpu(cpu) {
 			struct per_cpu_nodestat *p;
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index dfc3576..4daedf7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -254,7 +254,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 {
 	struct zone *zone;
 	struct zoneref *z;
-	enum zone_type high_zoneidx = gfp_zone(oc->gfp_mask);
+	enum zone_type highest_zoneidx = gfp_zone(oc->gfp_mask);
 	bool cpuset_limited = false;
 	int nid;
 
@@ -294,7 +294,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	/* Check this allocation failure is caused by cpuset's wall function */
 	for_each_zone_zonelist_nodemask(zone, z, oc->zonelist,
-			high_zoneidx, oc->nodemask)
+			highest_zoneidx, oc->nodemask)
 		if (!cpuset_zone_allowed(zone, oc->gfp_mask))
 			cpuset_limited = true;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1385d78..fcf134e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2600,7 +2600,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	int order;
 	bool ret;
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->high_zoneidx,
+	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
 								ac->nodemask) {
 		/*
 		 * Preserve at least one pageblock unless memory pressure
@@ -3469,7 +3469,7 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
  * to check in the allocation paths if no pages are free.
  */
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
-			 int classzone_idx, unsigned int alloc_flags,
+			 int highest_zoneidx, unsigned int alloc_flags,
 			 long free_pages)
 {
 	long min = mark;
@@ -3514,7 +3514,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	 * are not met, then a high-order request also cannot go ahead
 	 * even if a suitable page happened to be free.
 	 */
-	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
+	if (free_pages <= min + z->lowmem_reserve[highest_zoneidx])
 		return false;
 
 	/* If this is an order-0 request then the watermark is fine */
@@ -3547,14 +3547,15 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 }
 
 bool zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
-		      int classzone_idx, unsigned int alloc_flags)
+		      int highest_zoneidx, unsigned int alloc_flags)
 {
-	return __zone_watermark_ok(z, order, mark, classzone_idx, alloc_flags,
+	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
 					zone_page_state(z, NR_FREE_PAGES));
 }
 
 static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
-		unsigned long mark, int classzone_idx, unsigned int alloc_flags)
+				unsigned long mark, int highest_zoneidx,
+				unsigned int alloc_flags)
 {
 	long free_pages = zone_page_state(z, NR_FREE_PAGES);
 	long cma_pages = 0;
@@ -3572,22 +3573,23 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	 * the caller is !atomic then it'll uselessly search the free
 	 * list. That corner case is then slower but it is harmless.
 	 */
-	if (!order && (free_pages - cma_pages) > mark + z->lowmem_reserve[classzone_idx])
+	if (!order && (free_pages - cma_pages) >
+				mark + z->lowmem_reserve[highest_zoneidx])
 		return true;
 
-	return __zone_watermark_ok(z, order, mark, classzone_idx, alloc_flags,
+	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
 					free_pages);
 }
 
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
-			unsigned long mark, int classzone_idx)
+			unsigned long mark, int highest_zoneidx)
 {
 	long free_pages = zone_page_state(z, NR_FREE_PAGES);
 
 	if (z->percpu_drift_mark && free_pages < z->percpu_drift_mark)
 		free_pages = zone_page_state_snapshot(z, NR_FREE_PAGES);
 
-	return __zone_watermark_ok(z, order, mark, classzone_idx, 0,
+	return __zone_watermark_ok(z, order, mark, highest_zoneidx, 0,
 								free_pages);
 }
 
@@ -3664,8 +3666,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
 	z = ac->preferred_zoneref;
-	for_next_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-								ac->nodemask) {
+	for_next_zone_zonelist_nodemask(zone, z, ac->zonelist,
+					ac->highest_zoneidx, ac->nodemask) {
 		struct page *page;
 		unsigned long mark;
 
@@ -3720,7 +3722,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (!zone_watermark_fast(zone, order, mark,
-				       ac_classzone_idx(ac), alloc_flags)) {
+				       ac->highest_zoneidx, alloc_flags)) {
 			int ret;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -3753,7 +3755,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			default:
 				/* did we reclaim enough */
 				if (zone_watermark_ok(zone, order, mark,
-						ac_classzone_idx(ac), alloc_flags))
+					ac->highest_zoneidx, alloc_flags))
 					goto try_this_zone;
 
 				continue;
@@ -3912,7 +3914,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto out;
 	/* The OOM killer does not needlessly kill tasks for lowmem */
-	if (ac->high_zoneidx < ZONE_NORMAL)
+	if (ac->highest_zoneidx < ZONE_NORMAL)
 		goto out;
 	if (pm_suspended_storage())
 		goto out;
@@ -4115,10 +4117,10 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
 	 * Let's give them a good hope and keep retrying while the order-0
 	 * watermarks are OK.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-					ac->nodemask) {
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
+				ac->highest_zoneidx, ac->nodemask) {
 		if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
-					ac_classzone_idx(ac), alloc_flags))
+					ac->highest_zoneidx, alloc_flags))
 			return true;
 	}
 	return false;
@@ -4242,12 +4244,12 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 	struct zoneref *z;
 	struct zone *zone;
 	pg_data_t *last_pgdat = NULL;
-	enum zone_type high_zoneidx = ac->high_zoneidx;
+	enum zone_type highest_zoneidx = ac->highest_zoneidx;
 
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, high_zoneidx,
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
 					ac->nodemask) {
 		if (last_pgdat != zone->zone_pgdat)
-			wakeup_kswapd(zone, gfp_mask, order, high_zoneidx);
+			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
 		last_pgdat = zone->zone_pgdat;
 	}
 }
@@ -4382,8 +4384,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * request even if all reclaimable pages are considered then we are
 	 * screwed and have to go OOM.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-					ac->nodemask) {
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
+				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
 		unsigned long reclaimable;
 		unsigned long min_wmark = min_wmark_pages(zone);
@@ -4397,7 +4399,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 * reclaimable pages?
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
-				ac_classzone_idx(ac), alloc_flags, available);
+				ac->highest_zoneidx, alloc_flags, available);
 		trace_reclaim_retry_zone(z, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
@@ -4516,7 +4518,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * could end up iterating over non-eligible zones endlessly.
 	 */
 	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->high_zoneidx, ac->nodemask);
+					ac->highest_zoneidx, ac->nodemask);
 	if (!ac->preferred_zoneref->zone)
 		goto nopage;
 
@@ -4603,7 +4605,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
 		ac->nodemask = NULL;
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->high_zoneidx, ac->nodemask);
+					ac->highest_zoneidx, ac->nodemask);
 	}
 
 	/* Attempt with potentially adjusted zonelist and alloc_flags */
@@ -4737,7 +4739,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		struct alloc_context *ac, gfp_t *alloc_mask,
 		unsigned int *alloc_flags)
 {
-	ac->high_zoneidx = gfp_zone(gfp_mask);
+	ac->highest_zoneidx = gfp_zone(gfp_mask);
 	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
 	ac->nodemask = nodemask;
 	ac->migratetype = gfpflags_to_migratetype(gfp_mask);
@@ -4776,7 +4778,7 @@ static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
 	 * may get reset for allocations that ignore memory policies.
 	 */
 	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->high_zoneidx, ac->nodemask);
+					ac->highest_zoneidx, ac->nodemask);
 }
 
 /*
@@ -6973,7 +6975,7 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
 	unsigned long end_pfn = 0;
 
 	/* pg_data_t should be reset to zero when it's allocated */
-	WARN_ON(pgdat->nr_zones || pgdat->kswapd_classzone_idx);
+	WARN_ON(pgdat->nr_zones || pgdat->kswapd_highest_zoneidx);
 
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = node_start_pfn;
diff --git a/mm/slab.c b/mm/slab.c
index a896336..9350062 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3106,7 +3106,7 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
-	enum zone_type high_zoneidx = gfp_zone(flags);
+	enum zone_type highest_zoneidx = gfp_zone(flags);
 	void *obj = NULL;
 	struct page *page;
 	int nid;
@@ -3124,7 +3124,7 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 	 * Look through allowed nodes for objects available
 	 * from existing per node queues.
 	 */
-	for_each_zone_zonelist(zone, z, zonelist, high_zoneidx) {
+	for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 		nid = zone_to_nid(zone);
 
 		if (cpuset_zone_allowed(zone, flags) &&
diff --git a/mm/slub.c b/mm/slub.c
index 7002af0..e1321ac 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1909,7 +1909,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
-	enum zone_type high_zoneidx = gfp_zone(flags);
+	enum zone_type highest_zoneidx = gfp_zone(flags);
 	void *object;
 	unsigned int cpuset_mems_cookie;
 
@@ -1938,7 +1938,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		zonelist = node_zonelist(mempolicy_slab_node(), flags);
-		for_each_zone_zonelist(zone, z, zonelist, high_zoneidx) {
+		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868f..5fd58b9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3132,8 +3132,8 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 
 	/* kswapd must be awake if processes are being throttled */
 	if (!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) {
-		if (READ_ONCE(pgdat->kswapd_classzone_idx) > ZONE_NORMAL)
-			WRITE_ONCE(pgdat->kswapd_classzone_idx, ZONE_NORMAL);
+		if (READ_ONCE(pgdat->kswapd_highest_zoneidx) > ZONE_NORMAL)
+			WRITE_ONCE(pgdat->kswapd_highest_zoneidx, ZONE_NORMAL);
 
 		wake_up_interruptible(&pgdat->kswapd_wait);
 	}
@@ -3386,7 +3386,7 @@ static void age_active_anon(struct pglist_data *pgdat,
 	} while (memcg);
 }
 
-static bool pgdat_watermark_boosted(pg_data_t *pgdat, int classzone_idx)
+static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
 {
 	int i;
 	struct zone *zone;
@@ -3398,7 +3398,7 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int classzone_idx)
 	 * start prematurely when there is no boosting and a lower
 	 * zone is balanced.
 	 */
-	for (i = classzone_idx; i >= 0; i--) {
+	for (i = highest_zoneidx; i >= 0; i--) {
 		zone = pgdat->node_zones + i;
 		if (!managed_zone(zone))
 			continue;
@@ -3412,9 +3412,9 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int classzone_idx)
 
 /*
  * Returns true if there is an eligible zone balanced for the request order
- * and classzone_idx
+ * and highest_zoneidx
  */
-static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
+static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 {
 	int i;
 	unsigned long mark = -1;
@@ -3424,19 +3424,19 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
 	 * Check watermarks bottom-up as lower zones are more likely to
 	 * meet watermarks.
 	 */
-	for (i = 0; i <= classzone_idx; i++) {
+	for (i = 0; i <= highest_zoneidx; i++) {
 		zone = pgdat->node_zones + i;
 
 		if (!managed_zone(zone))
 			continue;
 
 		mark = high_wmark_pages(zone);
-		if (zone_watermark_ok_safe(zone, order, mark, classzone_idx))
+		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
 			return true;
 	}
 
 	/*
-	 * If a node has no populated zone within classzone_idx, it does not
+	 * If a node has no populated zone within highest_zoneidx, it does not
 	 * need balancing by definition. This can happen if a zone-restricted
 	 * allocation tries to wake a remote kswapd.
 	 */
@@ -3462,7 +3462,8 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
  *
  * Returns true if kswapd is ready to sleep
  */
-static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order, int classzone_idx)
+static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
+				int highest_zoneidx)
 {
 	/*
 	 * The throttled processes are normally woken up in balance_pgdat() as
@@ -3484,7 +3485,7 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order, int classzone_idx)
 	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
 		return true;
 
-	if (pgdat_balanced(pgdat, order, classzone_idx)) {
+	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
 		clear_pgdat_congested(pgdat);
 		return true;
 	}
@@ -3548,7 +3549,7 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
  * or lower is eligible for reclaim until at least one usable zone is
  * balanced.
  */
-static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
+static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 {
 	int i;
 	unsigned long nr_soft_reclaimed;
@@ -3576,7 +3577,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 	 * stall or direct reclaim until kswapd is finished.
 	 */
 	nr_boost_reclaim = 0;
-	for (i = 0; i <= classzone_idx; i++) {
+	for (i = 0; i <= highest_zoneidx; i++) {
 		zone = pgdat->node_zones + i;
 		if (!managed_zone(zone))
 			continue;
@@ -3594,7 +3595,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 		bool balanced;
 		bool ret;
 
-		sc.reclaim_idx = classzone_idx;
+		sc.reclaim_idx = highest_zoneidx;
 
 		/*
 		 * If the number of buffer_heads exceeds the maximum allowed
@@ -3624,7 +3625,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 		 * on the grounds that the normal reclaim should be enough to
 		 * re-evaluate if boosting is required when kswapd next wakes.
 		 */
-		balanced = pgdat_balanced(pgdat, sc.order, classzone_idx);
+		balanced = pgdat_balanced(pgdat, sc.order, highest_zoneidx);
 		if (!balanced && nr_boost_reclaim) {
 			nr_boost_reclaim = 0;
 			goto restart;
@@ -3724,7 +3725,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 	if (boosted) {
 		unsigned long flags;
 
-		for (i = 0; i <= classzone_idx; i++) {
+		for (i = 0; i <= highest_zoneidx; i++) {
 			if (!zone_boosts[i])
 				continue;
 
@@ -3739,7 +3740,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 		 * As there is now likely space, wakeup kcompact to defragment
 		 * pageblocks.
 		 */
-		wakeup_kcompactd(pgdat, pageblock_order, classzone_idx);
+		wakeup_kcompactd(pgdat, pageblock_order, highest_zoneidx);
 	}
 
 	snapshot_refaults(NULL, pgdat);
@@ -3757,22 +3758,22 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 }
 
 /*
- * The pgdat->kswapd_classzone_idx is used to pass the highest zone index to be
- * reclaimed by kswapd from the waker. If the value is MAX_NR_ZONES which is not
- * a valid index then either kswapd runs for first time or kswapd couldn't sleep
- * after previous reclaim attempt (node is still unbalanced). In that case
- * return the zone index of the previous kswapd reclaim cycle.
+ * The pgdat->kswapd_highest_zoneidx is used to pass the highest zone index to
+ * be reclaimed by kswapd from the waker. If the value is MAX_NR_ZONES which is
+ * not a valid index then either kswapd runs for first time or kswapd couldn't
+ * sleep after previous reclaim attempt (node is still unbalanced). In that
+ * case return the zone index of the previous kswapd reclaim cycle.
  */
-static enum zone_type kswapd_classzone_idx(pg_data_t *pgdat,
-					   enum zone_type prev_classzone_idx)
+static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
+					   enum zone_type prev_highest_zoneidx)
 {
-	enum zone_type curr_idx = READ_ONCE(pgdat->kswapd_classzone_idx);
+	enum zone_type curr_idx = READ_ONCE(pgdat->kswapd_highest_zoneidx);
 
-	return curr_idx == MAX_NR_ZONES ? prev_classzone_idx : curr_idx;
+	return curr_idx == MAX_NR_ZONES ? prev_highest_zoneidx : curr_idx;
 }
 
 static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
-				unsigned int classzone_idx)
+				unsigned int highest_zoneidx)
 {
 	long remaining = 0;
 	DEFINE_WAIT(wait);
@@ -3789,7 +3790,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * eligible zone balanced that it's also unlikely that compaction will
 	 * succeed.
 	 */
-	if (prepare_kswapd_sleep(pgdat, reclaim_order, classzone_idx)) {
+	if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
 		/*
 		 * Compaction records what page blocks it recently failed to
 		 * isolate pages from and skips them in the future scanning.
@@ -3802,18 +3803,19 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		 * We have freed the memory, now we should compact it to make
 		 * allocation of the requested order possible.
 		 */
-		wakeup_kcompactd(pgdat, alloc_order, classzone_idx);
+		wakeup_kcompactd(pgdat, alloc_order, highest_zoneidx);
 
 		remaining = schedule_timeout(HZ/10);
 
 		/*
-		 * If woken prematurely then reset kswapd_classzone_idx and
+		 * If woken prematurely then reset kswapd_highest_zoneidx and
 		 * order. The values will either be from a wakeup request or
 		 * the previous request that slept prematurely.
 		 */
 		if (remaining) {
-			WRITE_ONCE(pgdat->kswapd_classzone_idx,
-				   kswapd_classzone_idx(pgdat, classzone_idx));
+			WRITE_ONCE(pgdat->kswapd_highest_zoneidx,
+					kswapd_highest_zoneidx(pgdat,
+							highest_zoneidx));
 
 			if (READ_ONCE(pgdat->kswapd_order) < reclaim_order)
 				WRITE_ONCE(pgdat->kswapd_order, reclaim_order);
@@ -3828,7 +3830,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * go fully to sleep until explicitly woken up.
 	 */
 	if (!remaining &&
-	    prepare_kswapd_sleep(pgdat, reclaim_order, classzone_idx)) {
+	    prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
 		trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
 
 		/*
@@ -3870,7 +3872,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 static int kswapd(void *p)
 {
 	unsigned int alloc_order, reclaim_order;
-	unsigned int classzone_idx = MAX_NR_ZONES - 1;
+	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t*)p;
 	struct task_struct *tsk = current;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
@@ -3894,22 +3896,24 @@ static int kswapd(void *p)
 	set_freezable();
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
-	WRITE_ONCE(pgdat->kswapd_classzone_idx, MAX_NR_ZONES);
+	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
 	for ( ; ; ) {
 		bool ret;
 
 		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
-		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
+		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
+							highest_zoneidx);
 
 kswapd_try_sleep:
 		kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
-					classzone_idx);
+					highest_zoneidx);
 
-		/* Read the new order and classzone_idx */
+		/* Read the new order and highest_zoneidx */
 		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
-		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
+		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
+							highest_zoneidx);
 		WRITE_ONCE(pgdat->kswapd_order, 0);
-		WRITE_ONCE(pgdat->kswapd_classzone_idx, MAX_NR_ZONES);
+		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
 
 		ret = try_to_freeze();
 		if (kthread_should_stop())
@@ -3930,9 +3934,10 @@ static int kswapd(void *p)
 		 * but kcompactd is woken to compact for the original
 		 * request (alloc_order).
 		 */
-		trace_mm_vmscan_kswapd_wake(pgdat->node_id, classzone_idx,
+		trace_mm_vmscan_kswapd_wake(pgdat->node_id, highest_zoneidx,
 						alloc_order);
-		reclaim_order = balance_pgdat(pgdat, alloc_order, classzone_idx);
+		reclaim_order = balance_pgdat(pgdat, alloc_order,
+						highest_zoneidx);
 		if (reclaim_order < alloc_order)
 			goto kswapd_try_sleep;
 	}
@@ -3950,7 +3955,7 @@ static int kswapd(void *p)
  * needed.
  */
 void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
-		   enum zone_type classzone_idx)
+		   enum zone_type highest_zoneidx)
 {
 	pg_data_t *pgdat;
 	enum zone_type curr_idx;
@@ -3962,10 +3967,10 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		return;
 
 	pgdat = zone->zone_pgdat;
-	curr_idx = READ_ONCE(pgdat->kswapd_classzone_idx);
+	curr_idx = READ_ONCE(pgdat->kswapd_highest_zoneidx);
 
-	if (curr_idx == MAX_NR_ZONES || curr_idx < classzone_idx)
-		WRITE_ONCE(pgdat->kswapd_classzone_idx, classzone_idx);
+	if (curr_idx == MAX_NR_ZONES || curr_idx < highest_zoneidx)
+		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, highest_zoneidx);
 
 	if (READ_ONCE(pgdat->kswapd_order) < order)
 		WRITE_ONCE(pgdat->kswapd_order, order);
@@ -3975,8 +3980,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 
 	/* Hopeless node, leave it to direct reclaim if possible */
 	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
-	    (pgdat_balanced(pgdat, order, classzone_idx) &&
-	     !pgdat_watermark_boosted(pgdat, classzone_idx))) {
+	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
+	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
 		/*
 		 * There may be plenty of free memory available, but it's too
 		 * fragmented for high-order allocations.  Wake up kcompactd
@@ -3985,11 +3990,11 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		 * ratelimit its work.
 		 */
 		if (!(gfp_flags & __GFP_DIRECT_RECLAIM))
-			wakeup_kcompactd(pgdat, order, classzone_idx);
+			wakeup_kcompactd(pgdat, order, highest_zoneidx);
 		return;
 	}
 
-	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, classzone_idx, order,
+	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, highest_zoneidx, order,
 				      gfp_flags);
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
-- 
2.7.4

