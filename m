Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883B2FF1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbhAURXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:23:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:44254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbhAURWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:22:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 054CCAAAE;
        Thu, 21 Jan 2021 17:22:05 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     vbabka@suse.cz
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de, cl@linux.com,
        guro@fb.com, hannes@cmpxchg.org, iamjoonsoo.kim@lge.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, minchan@kernel.org, penberg@kernel.org,
        rientjes@google.com, shakeelb@google.com, surenb@google.com,
        tglx@linutronix.de
Subject: [RFC 1/2] mm, vmscan: add priority field to struct shrink_control
Date:   Thu, 21 Jan 2021 18:21:53 +0100
Message-Id: <20210121172154.27580-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <aa02cf86-3a83-2e55-3bb6-3ec1c0f71b11@suse.cz>
References: <aa02cf86-3a83-2e55-3bb6-3ec1c0f71b11@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slab reclaim works with reclaim priority, which influences how much to reclaim,
but is not directly passed to individual shrinkers. The next patch introduces a
slab shrinker that uses the priority, so add it to shrink_control and
initialize appropriately. We can then also remove the parameter from
shrink_slab() and trace_mm_shrink_slab_start().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/shrinker.h      |  3 +++
 include/trace/events/vmscan.h |  8 +++-----
 mm/vmscan.c                   | 14 ++++++++------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123650e2..1066f052be4f 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -29,6 +29,9 @@ struct shrink_control {
 	 */
 	unsigned long nr_scanned;
 
+	/* current reclaim priority */
+	int priority;
+
 	/* current memcg being shrunk (for memcg aware shrinkers) */
 	struct mem_cgroup *memcg;
 };
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 2070df64958e..d42e480977c6 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -185,11 +185,9 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_re
 TRACE_EVENT(mm_shrink_slab_start,
 	TP_PROTO(struct shrinker *shr, struct shrink_control *sc,
 		long nr_objects_to_shrink, unsigned long cache_items,
-		unsigned long long delta, unsigned long total_scan,
-		int priority),
+		unsigned long long delta, unsigned long total_scan),
 
-	TP_ARGS(shr, sc, nr_objects_to_shrink, cache_items, delta, total_scan,
-		priority),
+	TP_ARGS(shr, sc, nr_objects_to_shrink, cache_items, delta, total_scan),
 
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
@@ -212,7 +210,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->cache_items = cache_items;
 		__entry->delta = delta;
 		__entry->total_scan = total_scan;
-		__entry->priority = priority;
+		__entry->priority = sc->priority;
 	),
 
 	TP_printk("%pS %p: nid: %d objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 469016222cdb..bc5157625cec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -410,7 +410,7 @@ EXPORT_SYMBOL(unregister_shrinker);
 #define SHRINK_BATCH 128
 
 static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
-				    struct shrinker *shrinker, int priority)
+				    struct shrinker *shrinker)
 {
 	unsigned long freed = 0;
 	unsigned long long delta;
@@ -439,7 +439,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 
 	total_scan = nr;
 	if (shrinker->seeks) {
-		delta = freeable >> priority;
+		delta = freeable >> shrinkctl->priority;
 		delta *= 4;
 		do_div(delta, shrinker->seeks);
 	} else {
@@ -484,7 +484,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		total_scan = freeable * 2;
 
 	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
-				   freeable, delta, total_scan, priority);
+				   freeable, delta, total_scan);
 
 	/*
 	 * Normally, we should not scan less than batch_size objects in one
@@ -562,6 +562,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
+			.priority = priority,
 			.memcg = memcg,
 		};
 		struct shrinker *shrinker;
@@ -578,7 +579,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		    !(shrinker->flags & SHRINKER_NONSLAB))
 			continue;
 
-		ret = do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker);
 		if (ret == SHRINK_EMPTY) {
 			clear_bit(i, map->map);
 			/*
@@ -597,7 +598,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			 *   set_bit()          do_shrink_slab()
 			 */
 			smp_mb__after_atomic();
-			ret = do_shrink_slab(&sc, shrinker, priority);
+			ret = do_shrink_slab(&sc, shrinker);
 			if (ret == SHRINK_EMPTY)
 				ret = 0;
 			else
@@ -666,10 +667,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
+			.priority = priority,
 			.memcg = memcg,
 		};
 
-		ret = do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker);
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-- 
2.30.0

