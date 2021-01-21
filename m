Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13B92FF1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbhAURXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:23:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:44280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731713AbhAURWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:22:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32597B8F8;
        Thu, 21 Jan 2021 17:22:05 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     vbabka@suse.cz
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de, cl@linux.com,
        guro@fb.com, hannes@cmpxchg.org, iamjoonsoo.kim@lge.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, minchan@kernel.org, penberg@kernel.org,
        rientjes@google.com, shakeelb@google.com, surenb@google.com,
        tglx@linutronix.de
Subject: [RFC 2/2] mm, slub: add shrinker to reclaim cached slabs
Date:   Thu, 21 Jan 2021 18:21:54 +0100
Message-Id: <20210121172154.27580-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121172154.27580-1-vbabka@suse.cz>
References: <aa02cf86-3a83-2e55-3bb6-3ec1c0f71b11@suse.cz>
 <20210121172154.27580-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For performance reasons, SLUB doesn't keep all slabs on shared lists and
doesn't always free slabs immediately after all objects are freed. Namely:

- for each cache and cpu, there might be a "CPU slab" page, partially or fully
  free
- with SLUB_CPU_PARTIAL enabled (default y), there might be a number of "percpu
  partial slabs" for each cache and cpu, also partially or fully free
- for each cache and numa node, there are caches on per-node partial list, up
  to 10 of those may be empty

As Jann reports [1], the number of percpu partial slabs should be limited by
number of free objects (up to 30), but due to imprecise accounting, this can
deterioriate so that there are up to 30 free slabs. He notes:

> Even on an old-ish Android phone (Pixel 2), with normal-ish usage, I
> see something like 1.5MiB of pages with zero inuse objects stuck in
> percpu lists.

My observations match Jann's, and we've seen e.g. cases with 10 free slabs per
cpu. We can also confirm Jann's theory that on kernels pre-kmemcg rewrite (in
v5.9), this issue is amplified as there are separate sets of kmem caches with
cpu caches, per-cpu partial and per-node partial lists for each memcg and cache
that deals with kmemcg-accounted objects.

The cached free slabs can therefore become a memory waste, making memory
pressure higher, causing more reclaim of actually used LRU pages, and even
cause OOM (global, or memcg on older kernels).

SLUB provides __kmem_cache_shrink() that can flush all the abovementioned
slabs, but is currently called only in rare situations, or from a sysfs
handler. The standard way to cooperate with reclaim is to provide a shrinker,
and so this patch adds such shrinker to call __kmem_cache_shrink()
systematically.

The shrinker design is however atypical. The usual design assumes that a
shrinker can easily count how many objects can be reclaimed, and then reclaim
given number of objects. For SLUB, determining the number of the various cached
slabs would be a lot of work, and controlling how many to shrink precisely
would be impractical. Instead, the shrinker is based on reclaim priority, and
on lowest priority shrinks a single kmem cache, while on highest it shrinks all
of them. To do that effectively, there's a new list caches_to_shrink where
caches are taken from its head and then moved to tail. Existing slab_caches
list is unaffected so that e.g. /proc/slabinfo order is not disrupted.

This approach should not cause excessive shrinking and IPI storms:

- If there are multiple reclaimers in parallel, only one can proceed, thanks to
  mutex_trylock(&slab_mutex). After unlocking, caches that were just shrinked
  are at the tail of the list.
- in flush_all(), we actually check if there's anything to flush by a CPU
  (has_cpu_slab()) before sending an IPI
- CPU slab deactivation became more efficient with "mm, slub: splice cpu and
  page freelists in deactivate_slab()

The result is that SLUB's per-cpu and per-node caches are trimmed of free
pages, and partially used pages have higher chance of being either reused of
freed. The trimming effort is controlled by reclaim activity and thus memory
pressure. Before an OOM, a reclaim attempt at highest priority ensures
shrinking all caches. Also being a proper slab shrinker, the shrinking is
now also called as part of the drop_caches sysctl operation.

[1] https://lore.kernel.org/linux-mm/CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com/

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h |  1 +
 mm/slub.c                | 76 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index dcde82a4434c..6c4eeb30764d 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -107,6 +107,7 @@ struct kmem_cache {
 	unsigned int red_left_pad;	/* Left redzone padding size */
 	const char *name;	/* Name (only for display!) */
 	struct list_head list;	/* List of slab caches */
+	struct list_head shrink_list;	/* List ordered for shrinking */
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;	/* For sysfs */
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index c3141aa962be..bba05bd9287a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -123,6 +123,8 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif
 
+static LIST_HEAD(caches_to_shrink);
+
 static inline bool kmem_cache_debug(struct kmem_cache *s)
 {
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
@@ -3933,6 +3935,8 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
+	list_del(&s->shrink_list);
+
 	flush_all(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
@@ -3985,6 +3989,69 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 }
 #endif
 
+static unsigned long count_shrinkable_caches(struct shrinker *shrink,
+					     struct shrink_control *sc)
+{
+	/*
+	 * Determining how much there is to shrink would be so complex, it's
+	 * better to just pretend there always is and scale the actual effort
+	 * based on sc->priority.
+	 */
+	return shrink->batch;
+}
+
+static unsigned long shrink_caches(struct shrinker *shrink,
+				   struct shrink_control *sc)
+{
+	struct kmem_cache *s;
+	int nr_to_shrink;
+	int ret = sc->nr_to_scan / 2;
+
+	nr_to_shrink = DEF_PRIORITY - sc->priority;
+	if (nr_to_shrink < 0)
+		nr_to_shrink = 0;
+
+	nr_to_shrink = 1 << nr_to_shrink;
+	if (sc->priority == 0) {
+		nr_to_shrink = INT_MAX;
+		ret = 0;
+	}
+
+	if (!mutex_trylock(&slab_mutex))
+		return SHRINK_STOP;
+
+	list_for_each_entry(s, &caches_to_shrink, shrink_list) {
+		__kmem_cache_shrink(s);
+		if (--nr_to_shrink == 0) {
+			list_bulk_move_tail(&caches_to_shrink,
+					    caches_to_shrink.next,
+					    &s->shrink_list);
+			break;
+		}
+	}
+
+	mutex_unlock(&slab_mutex);
+
+	/*
+	 * As long as we are not at the highest priority, pretend we freed
+	 * something as we might have not have processed all caches. This
+	 * should signal that it's worth retrying. Once we are at the highest
+	 * priority and shrink the whole list, pretend we didn't free anything,
+	 * because there's no point in trying again.
+	 *
+	 * Note the value is currently ultimately ignored in "normal" reclaim,
+	 * but drop_slab_node() which handles drop_caches sysctl works like this.
+	 */
+	return ret;
+}
+
+static struct shrinker slub_cache_shrinker = {
+	.count_objects = count_shrinkable_caches,
+	.scan_objects = shrink_caches,
+	.batch = 128,
+	.seeks = 0,
+};
+
 /********************************************************************
  *		Kmalloc subsystem
  *******************************************************************/
@@ -4424,6 +4491,8 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 #endif
 	}
 	list_add(&s->list, &slab_caches);
+	list_del(&static_cache->shrink_list);
+	list_add(&s->shrink_list, &caches_to_shrink);
 	return s;
 }
 
@@ -4480,6 +4549,8 @@ void __init kmem_cache_init(void)
 
 void __init kmem_cache_init_late(void)
 {
+	if (!register_shrinker(&slub_cache_shrinker))
+		pr_err("SLUB: failed to register shrinker\n");
 }
 
 struct kmem_cache *
@@ -4518,11 +4589,14 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 
 	/* Mutex is not taken during early boot */
 	if (slab_state <= UP)
-		return 0;
+		goto out;
 
 	err = sysfs_slab_add(s);
 	if (err)
 		__kmem_cache_release(s);
+out:
+	if (!err)
+		list_add(&s->shrink_list, &caches_to_shrink);
 
 	return err;
 }
-- 
2.30.0

