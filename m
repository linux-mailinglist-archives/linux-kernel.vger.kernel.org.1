Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379C62B2FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKNSuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:50:46 -0500
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:35302 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgKNSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:50:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 79299180A7FE1;
        Sat, 14 Nov 2020 18:50:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:1:41:69:355:379:541:800:960:966:973:988:989:1260:1311:1314:1345:1359:1437:1515:1605:1730:1747:1777:1792:2194:2196:2198:2199:2200:2201:2393:2553:2559:2562:2637:2731:3138:3139:3140:3141:3142:3165:3865:3866:3867:3870:3871:4321:4385:5007:6261:7875:7904:8603:9592:10004:11026:11473:11658:11914:12043:12048:12291:12296:12297:12438:12555:12683:12895:13255:13894:14110:14394:21080:21433:21450:21451:21627:21990:30004:30025:30054:30056:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: line98_241145d27319
X-Filterd-Recvd-Size: 12639
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Nov 2020 18:50:38 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] mm: slub: Convert sysfs sprintf family to sysfs_emit/sysfs_emit_at
Date:   Sat, 14 Nov 2020 10:50:26 -0800
Message-Id: <0c90a90f466167f8c37de4b737553cf49c4a277f.1605376435.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1605376435.git.joe@perches.com>
References: <cover.1605376435.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the unbounded uses of sprintf to sysfs_emit.

A few conversions may now not end in a newline if the output buffer
is overflowed.

Signed-off-by: Joe Perches <joe@perches.com>
---

v2: Add back missing test for page in slabs_cpu_partial_show()

 mm/slub.c | 150 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 77 insertions(+), 73 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4148235ba554..f23bc1feb3d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4758,7 +4758,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 }
 
 static int list_locations(struct kmem_cache *s, char *buf,
-					enum track_item alloc)
+			  enum track_item alloc)
 {
 	int len = 0;
 	unsigned long i;
@@ -4768,7 +4768,7 @@ static int list_locations(struct kmem_cache *s, char *buf,
 
 	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
 			     GFP_KERNEL)) {
-		return sprintf(buf, "Out of memory\n");
+		return sysfs_emit(buf, "Out of memory\n");
 	}
 	/* Push back cpu slabs */
 	flush_all(s);
@@ -4791,50 +4791,45 @@ static int list_locations(struct kmem_cache *s, char *buf,
 	for (i = 0; i < t.count; i++) {
 		struct location *l = &t.loc[i];
 
-		if (len > PAGE_SIZE - KSYM_SYMBOL_LEN - 100)
-			break;
-		len += sprintf(buf + len, "%7ld ", l->count);
+		len += sysfs_emit_at(buf, len, "%7ld ", l->count);
 
 		if (l->addr)
-			len += sprintf(buf + len, "%pS", (void *)l->addr);
+			len += sysfs_emit_at(buf, len, "%pS", (void *)l->addr);
 		else
-			len += sprintf(buf + len, "<not-available>");
-
-		if (l->sum_time != l->min_time) {
-			len += sprintf(buf + len, " age=%ld/%ld/%ld",
-				l->min_time,
-				(long)div_u64(l->sum_time, l->count),
-				l->max_time);
-		} else
-			len += sprintf(buf + len, " age=%ld",
-				l->min_time);
+			len += sysfs_emit_at(buf, len, "<not-available>");
+
+		if (l->sum_time != l->min_time)
+			len += sysfs_emit_at(buf, len, " age=%ld/%ld/%ld",
+					     l->min_time,
+					     (long)div_u64(l->sum_time,
+							   l->count),
+					     l->max_time);
+		else
+			len += sysfs_emit_at(buf, len, " age=%ld", l->min_time);
 
 		if (l->min_pid != l->max_pid)
-			len += sprintf(buf + len, " pid=%ld-%ld",
-				l->min_pid, l->max_pid);
+			len += sysfs_emit_at(buf, len, " pid=%ld-%ld",
+					     l->min_pid, l->max_pid);
 		else
-			len += sprintf(buf + len, " pid=%ld",
-				l->min_pid);
+			len += sysfs_emit_at(buf, len, " pid=%ld",
+					     l->min_pid);
 
 		if (num_online_cpus() > 1 &&
-				!cpumask_empty(to_cpumask(l->cpus)) &&
-				len < PAGE_SIZE - 60)
-			len += scnprintf(buf + len, PAGE_SIZE - len - 50,
-					 " cpus=%*pbl",
-					 cpumask_pr_args(to_cpumask(l->cpus)));
-
-		if (nr_online_nodes > 1 && !nodes_empty(l->nodes) &&
-				len < PAGE_SIZE - 60)
-			len += scnprintf(buf + len, PAGE_SIZE - len - 50,
-					 " nodes=%*pbl",
-					 nodemask_pr_args(&l->nodes));
-
-		len += sprintf(buf + len, "\n");
+		    !cpumask_empty(to_cpumask(l->cpus)))
+			len += sysfs_emit_at(buf, len, " cpus=%*pbl",
+					     cpumask_pr_args(to_cpumask(l->cpus)));
+
+		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
+			len += sysfs_emit_at(buf, len, " nodes=%*pbl",
+					     nodemask_pr_args(&l->nodes));
+
+		len += sysfs_emit_at(buf, len, "\n");
 	}
 
 	free_loc_track(&t);
 	if (!t.count)
-		len += sprintf(buf, "No data\n");
+		len += sysfs_emit_at(buf, len, "No data\n");
+
 	return len;
 }
 #endif	/* CONFIG_SLUB_DEBUG */
@@ -4931,12 +4926,13 @@ __setup("slub_memcg_sysfs=", setup_slub_memcg_sysfs);
 #endif
 
 static ssize_t show_slab_objects(struct kmem_cache *s,
-			    char *buf, unsigned long flags)
+				 char *buf, unsigned long flags)
 {
 	unsigned long total = 0;
 	int node;
 	int x;
 	unsigned long *nodes;
+	int len = 0;
 
 	nodes = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
 	if (!nodes)
@@ -5025,15 +5021,19 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 			nodes[node] += x;
 		}
 	}
-	x = sprintf(buf, "%lu", total);
+
+	len += sysfs_emit_at(buf, len, "%lu", total);
 #ifdef CONFIG_NUMA
-	for (node = 0; node < nr_node_ids; node++)
+	for (node = 0; node < nr_node_ids; node++) {
 		if (nodes[node])
-			x += sprintf(buf + x, " N%d=%lu",
-					node, nodes[node]);
+			len += sysfs_emit_at(buf, len, " N%d=%lu",
+					     node, nodes[node]);
+	}
 #endif
+	len += sysfs_emit_at(buf, len, "\n");
 	kfree(nodes);
-	return x + sprintf(buf + x, "\n");
+
+	return len;
 }
 
 #define to_slab_attr(n) container_of(n, struct slab_attribute, attr)
@@ -5055,37 +5055,37 @@ struct slab_attribute {
 
 static ssize_t slab_size_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->size);
+	return sysfs_emit(buf, "%u\n", s->size);
 }
 SLAB_ATTR_RO(slab_size);
 
 static ssize_t align_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->align);
+	return sysfs_emit(buf, "%u\n", s->align);
 }
 SLAB_ATTR_RO(align);
 
 static ssize_t object_size_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->object_size);
+	return sysfs_emit(buf, "%u\n", s->object_size);
 }
 SLAB_ATTR_RO(object_size);
 
 static ssize_t objs_per_slab_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", oo_objects(s->oo));
+	return sysfs_emit(buf, "%u\n", oo_objects(s->oo));
 }
 SLAB_ATTR_RO(objs_per_slab);
 
 static ssize_t order_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", oo_order(s->oo));
+	return sysfs_emit(buf, "%u\n", oo_order(s->oo));
 }
 SLAB_ATTR_RO(order);
 
 static ssize_t min_partial_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%lu\n", s->min_partial);
+	return sysfs_emit(buf, "%lu\n", s->min_partial);
 }
 
 static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
@@ -5105,7 +5105,7 @@ SLAB_ATTR(min_partial);
 
 static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", slub_cpu_partial(s));
+	return sysfs_emit(buf, "%u\n", slub_cpu_partial(s));
 }
 
 static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
@@ -5130,13 +5130,13 @@ static ssize_t ctor_show(struct kmem_cache *s, char *buf)
 {
 	if (!s->ctor)
 		return 0;
-	return sprintf(buf, "%pS\n", s->ctor);
+	return sysfs_emit(buf, "%pS\n", s->ctor);
 }
 SLAB_ATTR_RO(ctor);
 
 static ssize_t aliases_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", s->refcount < 0 ? 0 : s->refcount - 1);
+	return sysfs_emit(buf, "%d\n", s->refcount < 0 ? 0 : s->refcount - 1);
 }
 SLAB_ATTR_RO(aliases);
 
@@ -5169,7 +5169,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 	int objects = 0;
 	int pages = 0;
 	int cpu;
-	int len;
+	int len = 0;
 
 	for_each_online_cpu(cpu) {
 		struct page *page;
@@ -5182,52 +5182,53 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 		}
 	}
 
-	len = sprintf(buf, "%d(%d)", objects, pages);
+	len += sysfs_emit_at(buf, len, "%d(%d)", objects, pages);
 
 #ifdef CONFIG_SMP
 	for_each_online_cpu(cpu) {
 		struct page *page;
 
 		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
-
-		if (page && len < PAGE_SIZE - 20)
-			len += sprintf(buf + len, " C%d=%d(%d)", cpu,
-				page->pobjects, page->pages);
+		if (page)
+			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
+					     cpu, page->pobjects, page->pages);
 	}
 #endif
-	return len + sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
 }
 SLAB_ATTR_RO(slabs_cpu_partial);
 
 static ssize_t reclaim_account_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_RECLAIM_ACCOUNT));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_RECLAIM_ACCOUNT));
 }
 SLAB_ATTR_RO(reclaim_account);
 
 static ssize_t hwcache_align_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_HWCACHE_ALIGN));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_HWCACHE_ALIGN));
 }
 SLAB_ATTR_RO(hwcache_align);
 
 #ifdef CONFIG_ZONE_DMA
 static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA));
 }
 SLAB_ATTR_RO(cache_dma);
 #endif
 
 static ssize_t usersize_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->usersize);
+	return sysfs_emit(buf, "%u\n", s->usersize);
 }
 SLAB_ATTR_RO(usersize);
 
 static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_TYPESAFE_BY_RCU));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_TYPESAFE_BY_RCU));
 }
 SLAB_ATTR_RO(destroy_by_rcu);
 
@@ -5246,33 +5247,33 @@ SLAB_ATTR_RO(total_objects);
 
 static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
 }
 SLAB_ATTR_RO(sanity_checks);
 
 static ssize_t trace_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_TRACE));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_TRACE));
 }
 SLAB_ATTR_RO(trace);
 
 static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
 }
 
 SLAB_ATTR_RO(red_zone);
 
 static ssize_t poison_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_POISON));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_POISON));
 }
 
 SLAB_ATTR_RO(poison);
 
 static ssize_t store_user_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
 }
 
 SLAB_ATTR_RO(store_user);
@@ -5316,7 +5317,7 @@ SLAB_ATTR_RO(free_calls);
 #ifdef CONFIG_FAILSLAB
 static ssize_t failslab_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
 }
 SLAB_ATTR_RO(failslab);
 #endif
@@ -5340,7 +5341,7 @@ SLAB_ATTR(shrink);
 #ifdef CONFIG_NUMA
 static ssize_t remote_node_defrag_ratio_show(struct kmem_cache *s, char *buf)
 {
-	return sprintf(buf, "%u\n", s->remote_node_defrag_ratio / 10);
+	return sysfs_emit(buf, "%u\n", s->remote_node_defrag_ratio / 10);
 }
 
 static ssize_t remote_node_defrag_ratio_store(struct kmem_cache *s,
@@ -5367,7 +5368,7 @@ static int show_stat(struct kmem_cache *s, char *buf, enum stat_item si)
 {
 	unsigned long sum  = 0;
 	int cpu;
-	int len;
+	int len = 0;
 	int *data = kmalloc_array(nr_cpu_ids, sizeof(int), GFP_KERNEL);
 
 	if (!data)
@@ -5380,16 +5381,19 @@ static int show_stat(struct kmem_cache *s, char *buf, enum stat_item si)
 		sum += x;
 	}
 
-	len = sprintf(buf, "%lu", sum);
+	len += sysfs_emit_at(buf, len, "%lu", sum);
 
 #ifdef CONFIG_SMP
 	for_each_online_cpu(cpu) {
-		if (data[cpu] && len < PAGE_SIZE - 20)
-			len += sprintf(buf + len, " C%d=%u", cpu, data[cpu]);
+		if (data[cpu])
+			len += sysfs_emit_at(buf, len, " C%d=%u",
+					     cpu, data[cpu]);
 	}
 #endif
 	kfree(data);
-	return len + sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
 }
 
 static void clear_stat(struct kmem_cache *s, enum stat_item si)
-- 
2.26.0

