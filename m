Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1531FD9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 01:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgFQXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 19:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgFQXfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:35:31 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66BF21534;
        Wed, 17 Jun 2020 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592436929;
        bh=btEuyFdpr56zSB5FTpkzKTw6kNMcqIhbcIrTibcl0DE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vnazAEsjYHya0UKxjbHeClmBcVe0wDdT9euc+A4LJJp3zSGDnZKY/PzK4odhhHJIa
         oayQ4bwkZDteL+NUXeIq44VXfWiZTPEsrWFIbJhNOOuzKhdAOIsKVyDK6o/FGRAQHy
         qI8GQegOgf3Swz4ngfnomGFdzg/Bs6/5xRXNNcCw=
Date:   Wed, 17 Jun 2020 16:35:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of
 kmem_caches for all allocations
Message-Id: <20200617163528.a4477749b172c387e01c3996@linux-foundation.org>
In-Reply-To: <20200608230654.828134-18-guro@fb.com>
References: <20200608230654.828134-1-guro@fb.com>
        <20200608230654.828134-18-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 16:06:52 -0700 Roman Gushchin <guro@fb.com> wrote:

> Instead of having two sets of kmem_caches: one for system-wide and
> non-accounted allocations and the second one shared by all accounted
> allocations, we can use just one.
> 
> The idea is simple: space for obj_cgroup metadata can be allocated
> on demand and filled only for accounted allocations.
> 
> It allows to remove a bunch of code which is required to handle
> kmem_cache clones for accounted allocations. There is no more need
> to create them, accumulate statistics, propagate attributes, etc.
> It's a quite significant simplification.
> 
> Also, because the total number of slab_caches is reduced almost twice
> (not all kmem_caches have a memcg clone), some additional memory
> savings are expected. On my devvm it additionally saves about 3.5%
> of slab memory.
> 

This ran afoul of Vlastimil's "mm, slab/slub: move and improve
cache_from_obj()"
(http://lkml.kernel.org/r/20200610163135.17364-10-vbabka@suse.cz).  I
resolved things as below.  Not too sure about slab.c's
cache_from_obj()...


From: Roman Gushchin <guro@fb.com>
Subject: mm: memcg/slab: use a single set of kmem_caches for all allocations

Instead of having two sets of kmem_caches: one for system-wide and
non-accounted allocations and the second one shared by all accounted
allocations, we can use just one.

The idea is simple: space for obj_cgroup metadata can be allocated
on demand and filled only for accounted allocations.

It allows to remove a bunch of code which is required to handle
kmem_cache clones for accounted allocations. There is no more need
to create them, accumulate statistics, propagate attributes, etc.
It's a quite significant simplification.

Also, because the total number of slab_caches is reduced almost twice
(not all kmem_caches have a memcg clone), some additional memory
savings are expected. On my devvm it additionally saves about 3.5%
of slab memory.

Link: http://lkml.kernel.org/r/20200608230654.828134-18-guro@fb.com
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/slab.h     |    2 
 include/linux/slab_def.h |    3 
 include/linux/slub_def.h |   10 -
 mm/memcontrol.c          |    5 
 mm/slab.c                |   46 -------
 mm/slab.h                |  176 ++++++----------------------
 mm/slab_common.c         |  230 -------------------------------------
 mm/slub.c                |  166 --------------------------
 8 files changed, 58 insertions(+), 580 deletions(-)

--- a/include/linux/slab_def.h~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/include/linux/slab_def.h
@@ -72,9 +72,6 @@ struct kmem_cache {
 	int obj_offset;
 #endif /* CONFIG_DEBUG_SLAB */
 
-#ifdef CONFIG_MEMCG
-	struct memcg_cache_params memcg_params;
-#endif
 #ifdef CONFIG_KASAN
 	struct kasan_cache kasan_info;
 #endif
--- a/include/linux/slab.h~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/include/linux/slab.h
@@ -155,8 +155,6 @@ struct kmem_cache *kmem_cache_create_use
 void kmem_cache_destroy(struct kmem_cache *);
 int kmem_cache_shrink(struct kmem_cache *);
 
-void memcg_create_kmem_cache(struct kmem_cache *cachep);
-
 /*
  * Please use this macro to create slab caches. Simply specify the
  * name of the structure and maybe some flags that are listed above.
--- a/include/linux/slub_def.h~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/include/linux/slub_def.h
@@ -108,17 +108,7 @@ struct kmem_cache {
 	struct list_head list;	/* List of slab caches */
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;	/* For sysfs */
-	struct work_struct kobj_remove_work;
 #endif
-#ifdef CONFIG_MEMCG
-	struct memcg_cache_params memcg_params;
-	/* For propagation, maximum size of a stored attr */
-	unsigned int max_attr_size;
-#ifdef CONFIG_SYSFS
-	struct kset *memcg_kset;
-#endif
-#endif
-
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	unsigned long random;
 #endif
--- a/mm/memcontrol.c~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/mm/memcontrol.c
@@ -2826,7 +2826,10 @@ struct mem_cgroup *mem_cgroup_from_obj(v
 
 		off = obj_to_index(page->slab_cache, page, p);
 		objcg = page_obj_cgroups(page)[off];
-		return obj_cgroup_memcg(objcg);
+		if (objcg)
+			return obj_cgroup_memcg(objcg);
+
+		return NULL;
 	}
 
 	/* All other pages use page->mem_cgroup */
--- a/mm/slab.c~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/mm/slab.c
@@ -1369,11 +1369,7 @@ static struct page *kmem_getpages(struct
 		return NULL;
 	}
 
-	if (charge_slab_page(page, flags, cachep->gfporder, cachep)) {
-		__free_pages(page, cachep->gfporder);
-		return NULL;
-	}
-
+	charge_slab_page(page, flags, cachep->gfporder, cachep);
 	__SetPageSlab(page);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
@@ -3670,10 +3666,7 @@ EXPORT_SYMBOL(__kmalloc_track_caller);
 
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 {
-	if (memcg_kmem_enabled())
-		return virt_to_cache(x);
-	else
-		return s;
+	return virt_to_cache(x);
 }
 
 /**
@@ -3800,8 +3793,8 @@ fail:
 }
 
 /* Always called with the slab_mutex held */
-static int __do_tune_cpucache(struct kmem_cache *cachep, int limit,
-				int batchcount, int shared, gfp_t gfp)
+static int do_tune_cpucache(struct kmem_cache *cachep, int limit,
+			    int batchcount, int shared, gfp_t gfp)
 {
 	struct array_cache __percpu *cpu_cache, *prev;
 	int cpu;
@@ -3846,30 +3839,6 @@ setup_node:
 	return setup_kmem_cache_nodes(cachep, gfp);
 }
 
-static int do_tune_cpucache(struct kmem_cache *cachep, int limit,
-				int batchcount, int shared, gfp_t gfp)
-{
-	int ret;
-	struct kmem_cache *c;
-
-	ret = __do_tune_cpucache(cachep, limit, batchcount, shared, gfp);
-
-	if (slab_state < FULL)
-		return ret;
-
-	if ((ret < 0) || !is_root_cache(cachep))
-		return ret;
-
-	lockdep_assert_held(&slab_mutex);
-	c = memcg_cache(cachep);
-	if (c) {
-		/* return value determined by the root cache only */
-		__do_tune_cpucache(c, limit, batchcount, shared, gfp);
-	}
-
-	return ret;
-}
-
 /* Called with slab_mutex held always */
 static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp)
 {
@@ -3882,13 +3851,6 @@ static int enable_cpucache(struct kmem_c
 	if (err)
 		goto end;
 
-	if (!is_root_cache(cachep)) {
-		struct kmem_cache *root = memcg_root_cache(cachep);
-		limit = root->limit;
-		shared = root->shared;
-		batchcount = root->batchcount;
-	}
-
 	if (limit && shared && batchcount)
 		goto skip_setup;
 	/*
--- a/mm/slab_common.c~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/mm/slab_common.c
@@ -128,36 +128,6 @@ int __kmem_cache_alloc_bulk(struct kmem_
 	return i;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
-static void memcg_kmem_cache_create_func(struct work_struct *work)
-{
-	struct kmem_cache *cachep = container_of(work, struct kmem_cache,
-						 memcg_params.work);
-	memcg_create_kmem_cache(cachep);
-}
-
-void slab_init_memcg_params(struct kmem_cache *s)
-{
-	s->memcg_params.root_cache = NULL;
-	s->memcg_params.memcg_cache = NULL;
-	INIT_WORK(&s->memcg_params.work, memcg_kmem_cache_create_func);
-}
-
-static void init_memcg_params(struct kmem_cache *s,
-			      struct kmem_cache *root_cache)
-{
-	if (root_cache)
-		s->memcg_params.root_cache = root_cache;
-	else
-		slab_init_memcg_params(s);
-}
-#else
-static inline void init_memcg_params(struct kmem_cache *s,
-				     struct kmem_cache *root_cache)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
-
 /*
  * Figure out what the alignment of the objects will be given a set of
  * flags, a user specified alignment and the size of the objects.
@@ -195,9 +165,6 @@ int slab_unmergeable(struct kmem_cache *
 	if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
 		return 1;
 
-	if (!is_root_cache(s))
-		return 1;
-
 	if (s->ctor)
 		return 1;
 
@@ -284,7 +251,6 @@ static struct kmem_cache *create_cache(c
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 
-	init_memcg_params(s, root_cache);
 	err = __kmem_cache_create(s, flags);
 	if (err)
 		goto out_free_cache;
@@ -342,7 +308,6 @@ kmem_cache_create_usercopy(const char *n
 
 	get_online_cpus();
 	get_online_mems();
-	memcg_get_cache_ids();
 
 	mutex_lock(&slab_mutex);
 
@@ -392,7 +357,6 @@ kmem_cache_create_usercopy(const char *n
 out_unlock:
 	mutex_unlock(&slab_mutex);
 
-	memcg_put_cache_ids();
 	put_online_mems();
 	put_online_cpus();
 
@@ -505,87 +469,6 @@ static int shutdown_cache(struct kmem_ca
 	return 0;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
-/*
- * memcg_create_kmem_cache - Create a cache for non-root memory cgroups.
- * @root_cache: The parent of the new cache.
- *
- * This function attempts to create a kmem cache that will serve allocation
- * requests going all non-root memory cgroups to @root_cache. The new cache
- * inherits properties from its parent.
- */
-void memcg_create_kmem_cache(struct kmem_cache *root_cache)
-{
-	struct kmem_cache *s = NULL;
-	char *cache_name;
-
-	get_online_cpus();
-	get_online_mems();
-
-	mutex_lock(&slab_mutex);
-
-	if (root_cache->memcg_params.memcg_cache)
-		goto out_unlock;
-
-	cache_name = kasprintf(GFP_KERNEL, "%s-memcg", root_cache->name);
-	if (!cache_name)
-		goto out_unlock;
-
-	s = create_cache(cache_name, root_cache->object_size,
-			 root_cache->align,
-			 root_cache->flags & CACHE_CREATE_MASK,
-			 root_cache->useroffset, root_cache->usersize,
-			 root_cache->ctor, root_cache);
-	/*
-	 * If we could not create a memcg cache, do not complain, because
-	 * that's not critical at all as we can always proceed with the root
-	 * cache.
-	 */
-	if (IS_ERR(s)) {
-		kfree(cache_name);
-		goto out_unlock;
-	}
-
-	/*
-	 * Since readers won't lock (see memcg_slab_pre_alloc_hook()), we need a
-	 * barrier here to ensure nobody will see the kmem_cache partially
-	 * initialized.
-	 */
-	smp_wmb();
-	root_cache->memcg_params.memcg_cache = s;
-
-out_unlock:
-	mutex_unlock(&slab_mutex);
-
-	put_online_mems();
-	put_online_cpus();
-}
-
-static int shutdown_memcg_caches(struct kmem_cache *s)
-{
-	BUG_ON(!is_root_cache(s));
-
-	if (s->memcg_params.memcg_cache)
-		WARN_ON(shutdown_cache(s->memcg_params.memcg_cache));
-
-	return 0;
-}
-
-static void cancel_memcg_cache_creation(struct kmem_cache *s)
-{
-	cancel_work_sync(&s->memcg_params.work);
-}
-#else
-static inline int shutdown_memcg_caches(struct kmem_cache *s)
-{
-	return 0;
-}
-
-static inline void cancel_memcg_cache_creation(struct kmem_cache *s)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
-
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
@@ -600,8 +483,6 @@ void kmem_cache_destroy(struct kmem_cach
 	if (unlikely(!s))
 		return;
 
-	cancel_memcg_cache_creation(s);
-
 	get_online_cpus();
 	get_online_mems();
 
@@ -611,10 +492,7 @@ void kmem_cache_destroy(struct kmem_cach
 	if (s->refcount)
 		goto out_unlock;
 
-	err = shutdown_memcg_caches(s);
-	if (!err)
-		err = shutdown_cache(s);
-
+	err = shutdown_cache(s);
 	if (err) {
 		pr_err("kmem_cache_destroy %s: Slab cache still has objects\n",
 		       s->name);
@@ -651,33 +529,6 @@ int kmem_cache_shrink(struct kmem_cache
 }
 EXPORT_SYMBOL(kmem_cache_shrink);
 
-/**
- * kmem_cache_shrink_all - shrink root and memcg caches
- * @s: The cache pointer
- */
-void kmem_cache_shrink_all(struct kmem_cache *s)
-{
-	struct kmem_cache *c;
-
-	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || !is_root_cache(s)) {
-		kmem_cache_shrink(s);
-		return;
-	}
-
-	get_online_cpus();
-	get_online_mems();
-	kasan_cache_shrink(s);
-	__kmem_cache_shrink(s);
-
-	c = memcg_cache(s);
-	if (c) {
-		kasan_cache_shrink(c);
-		__kmem_cache_shrink(c);
-	}
-	put_online_mems();
-	put_online_cpus();
-}
-
 bool slab_is_available(void)
 {
 	return slab_state >= UP;
@@ -706,8 +557,6 @@ void __init create_boot_cache(struct kme
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 
-	slab_init_memcg_params(s);
-
 	err = __kmem_cache_create(s, flags);
 
 	if (err)
@@ -1081,25 +930,6 @@ void slab_stop(struct seq_file *m, void
 	mutex_unlock(&slab_mutex);
 }
 
-static void
-memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
-{
-	struct kmem_cache *c;
-	struct slabinfo sinfo;
-
-	c = memcg_cache(s);
-	if (c) {
-		memset(&sinfo, 0, sizeof(sinfo));
-		get_slabinfo(c, &sinfo);
-
-		info->active_slabs += sinfo.active_slabs;
-		info->num_slabs += sinfo.num_slabs;
-		info->shared_avail += sinfo.shared_avail;
-		info->active_objs += sinfo.active_objs;
-		info->num_objs += sinfo.num_objs;
-	}
-}
-
 static void cache_show(struct kmem_cache *s, struct seq_file *m)
 {
 	struct slabinfo sinfo;
@@ -1107,10 +937,8 @@ static void cache_show(struct kmem_cache
 	memset(&sinfo, 0, sizeof(sinfo));
 	get_slabinfo(s, &sinfo);
 
-	memcg_accumulate_slabinfo(s, &sinfo);
-
 	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
-		   cache_name(s), sinfo.active_objs, sinfo.num_objs, s->size,
+		   s->name, sinfo.active_objs, sinfo.num_objs, s->size,
 		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
 
 	seq_printf(m, " : tunables %4u %4u %4u",
@@ -1127,8 +955,7 @@ static int slab_show(struct seq_file *m,
 
 	if (p == slab_caches.next)
 		print_slabinfo_header(m);
-	if (is_root_cache(s))
-		cache_show(s, m);
+	cache_show(s, m);
 	return 0;
 }
 
@@ -1153,13 +980,13 @@ void dump_unreclaimable_slab(void)
 	pr_info("Name                      Used          Total\n");
 
 	list_for_each_entry_safe(s, s2, &slab_caches, list) {
-		if (!is_root_cache(s) || (s->flags & SLAB_RECLAIM_ACCOUNT))
+		if (s->flags & SLAB_RECLAIM_ACCOUNT)
 			continue;
 
 		get_slabinfo(s, &sinfo);
 
 		if (sinfo.num_objs > 0)
-			pr_info("%-17s %10luKB %10luKB\n", cache_name(s),
+			pr_info("%-17s %10luKB %10luKB\n", s->name,
 				(sinfo.active_objs * s->size) / 1024,
 				(sinfo.num_objs * s->size) / 1024);
 	}
@@ -1218,53 +1045,6 @@ static int __init slab_proc_init(void)
 }
 module_init(slab_proc_init);
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_MEMCG_KMEM)
-/*
- * Display information about kmem caches that have memcg cache.
- */
-static int memcg_slabinfo_show(struct seq_file *m, void *unused)
-{
-	struct kmem_cache *s, *c;
-	struct slabinfo sinfo;
-
-	mutex_lock(&slab_mutex);
-	seq_puts(m, "# <name> <css_id[:dead|deact]> <active_objs> <num_objs>");
-	seq_puts(m, " <active_slabs> <num_slabs>\n");
-	list_for_each_entry(s, &slab_caches, list) {
-		/*
-		 * Skip kmem caches that don't have the memcg cache.
-		 */
-		if (!s->memcg_params.memcg_cache)
-			continue;
-
-		memset(&sinfo, 0, sizeof(sinfo));
-		get_slabinfo(s, &sinfo);
-		seq_printf(m, "%-17s root       %6lu %6lu %6lu %6lu\n",
-			   cache_name(s), sinfo.active_objs, sinfo.num_objs,
-			   sinfo.active_slabs, sinfo.num_slabs);
-
-		c = s->memcg_params.memcg_cache;
-		memset(&sinfo, 0, sizeof(sinfo));
-		get_slabinfo(c, &sinfo);
-		seq_printf(m, "%-17s %4d %6lu %6lu %6lu %6lu\n",
-			   cache_name(c), root_mem_cgroup->css.id,
-			   sinfo.active_objs, sinfo.num_objs,
-			   sinfo.active_slabs, sinfo.num_slabs);
-	}
-	mutex_unlock(&slab_mutex);
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(memcg_slabinfo);
-
-static int __init memcg_slabinfo_init(void)
-{
-	debugfs_create_file("memcg_slabinfo", S_IFREG | S_IRUGO,
-			    NULL, NULL, &memcg_slabinfo_fops);
-	return 0;
-}
-
-late_initcall(memcg_slabinfo_init);
-#endif /* CONFIG_DEBUG_FS && CONFIG_MEMCG_KMEM */
 #endif /* CONFIG_SLAB || CONFIG_SLUB_DEBUG */
 
 static __always_inline void *__do_krealloc(const void *p, size_t new_size,
--- a/mm/slab.h~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/mm/slab.h
@@ -30,28 +30,6 @@ struct kmem_cache {
 	struct list_head list;	/* List of all slab caches on the system */
 };
 
-#else /* !CONFIG_SLOB */
-
-/*
- * This is the main placeholder for memcg-related information in kmem caches.
- * Both the root cache and the child cache will have it. Some fields are used
- * in both cases, other are specific to root caches.
- *
- * @root_cache:	Common to root and child caches.  NULL for root, pointer to
- *		the root cache for children.
- *
- * The following fields are specific to root caches.
- *
- * @memcg_cache: pointer to memcg kmem cache, used by all non-root memory
- *		cgroups.
- * @work: work struct used to create the non-root cache.
- */
-struct memcg_cache_params {
-	struct kmem_cache *root_cache;
-
-	struct kmem_cache *memcg_cache;
-	struct work_struct work;
-};
 #endif /* CONFIG_SLOB */
 
 #ifdef CONFIG_SLAB
@@ -194,7 +172,6 @@ int __kmem_cache_shutdown(struct kmem_ca
 void __kmem_cache_release(struct kmem_cache *);
 int __kmem_cache_shrink(struct kmem_cache *);
 void slab_kmem_cache_release(struct kmem_cache *);
-void kmem_cache_shrink_all(struct kmem_cache *s);
 
 struct seq_file;
 struct file;
@@ -233,43 +210,6 @@ static inline int cache_vmstat_idx(struc
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static inline bool is_root_cache(struct kmem_cache *s)
-{
-	return !s->memcg_params.root_cache;
-}
-
-static inline bool slab_equal_or_root(struct kmem_cache *s,
-				      struct kmem_cache *p)
-{
-	return p == s || p == s->memcg_params.root_cache;
-}
-
-/*
- * We use suffixes to the name in memcg because we can't have caches
- * created in the system with the same name. But when we print them
- * locally, better refer to them with the base name
- */
-static inline const char *cache_name(struct kmem_cache *s)
-{
-	if (!is_root_cache(s))
-		s = s->memcg_params.root_cache;
-	return s->name;
-}
-
-static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
-{
-	if (is_root_cache(s))
-		return s;
-	return s->memcg_params.root_cache;
-}
-
-static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
-{
-	if (is_root_cache(s))
-		return s->memcg_params.memcg_cache;
-	return NULL;
-}
-
 static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
 {
 	/*
@@ -316,38 +256,25 @@ static inline size_t obj_full_size(struc
 	return s->size + sizeof(struct obj_cgroup *);
 }
 
-static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-						struct obj_cgroup **objcgp,
-						size_t objects, gfp_t flags)
+static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+							   size_t objects,
+							   gfp_t flags)
 {
-	struct kmem_cache *cachep;
 	struct obj_cgroup *objcg;
 
 	if (memcg_kmem_bypass())
-		return s;
-
-	cachep = READ_ONCE(s->memcg_params.memcg_cache);
-	if (unlikely(!cachep)) {
-		/*
-		 * If memcg cache does not exist yet, we schedule it's
-		 * asynchronous creation and let the current allocation
-		 * go through with the root cache.
-		 */
-		queue_work(system_wq, &s->memcg_params.work);
-		return s;
-	}
+		return NULL;
 
 	objcg = get_obj_cgroup_from_current();
 	if (!objcg)
-		return s;
+		return NULL;
 
 	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
 		obj_cgroup_put(objcg);
-		cachep = NULL;
+		return NULL;
 	}
 
-	*objcgp = objcg;
-	return cachep;
+	return objcg;
 }
 
 static inline void mod_objcg_state(struct obj_cgroup *objcg,
@@ -366,15 +293,27 @@ static inline void mod_objcg_state(struc
 
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
-					      size_t size, void **p)
+					      gfp_t flags, size_t size,
+					      void **p)
 {
 	struct page *page;
 	unsigned long off;
 	size_t i;
 
+	if (!objcg)
+		return;
+
+	flags &= ~__GFP_ACCOUNT;
 	for (i = 0; i < size; i++) {
 		if (likely(p[i])) {
 			page = virt_to_head_page(p[i]);
+
+			if (!page_has_obj_cgroups(page) &&
+			    memcg_alloc_page_obj_cgroups(page, s, flags)) {
+				obj_cgroup_uncharge(objcg, obj_full_size(s));
+				continue;
+			}
+
 			off = obj_to_index(s, page, p[i]);
 			obj_cgroup_get(objcg);
 			page_obj_cgroups(page)[off] = objcg;
@@ -393,13 +332,19 @@ static inline void memcg_slab_free_hook(
 	struct obj_cgroup *objcg;
 	unsigned int off;
 
-	if (!memcg_kmem_enabled() || is_root_cache(s))
+	if (!memcg_kmem_enabled())
+		return;
+
+	if (!page_has_obj_cgroups(page))
 		return;
 
 	off = obj_to_index(s, page, p);
 	objcg = page_obj_cgroups(page)[off];
 	page_obj_cgroups(page)[off] = NULL;
 
+	if (!objcg)
+		return;
+
 	obj_cgroup_uncharge(objcg, obj_full_size(s));
 	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
 			-obj_full_size(s));
@@ -407,35 +352,7 @@ static inline void memcg_slab_free_hook(
 	obj_cgroup_put(objcg);
 }
 
-extern void slab_init_memcg_params(struct kmem_cache *);
-
 #else /* CONFIG_MEMCG_KMEM */
-static inline bool is_root_cache(struct kmem_cache *s)
-{
-	return true;
-}
-
-static inline bool slab_equal_or_root(struct kmem_cache *s,
-				      struct kmem_cache *p)
-{
-	return s == p;
-}
-
-static inline const char *cache_name(struct kmem_cache *s)
-{
-	return s->name;
-}
-
-static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
-{
-	return s;
-}
-
-static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
-{
-	return NULL;
-}
-
 static inline bool page_has_obj_cgroups(struct page *page)
 {
 	return false;
@@ -456,16 +373,17 @@ static inline void memcg_free_page_obj_c
 {
 }
 
-static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-						struct obj_cgroup **objcgp,
-						size_t objects, gfp_t flags)
+static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+							   size_t objects,
+							   gfp_t flags)
 {
 	return NULL;
 }
 
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
-					      size_t size, void **p)
+					      gfp_t flags, size_t size,
+					      void **p)
 {
 }
 
@@ -473,11 +391,6 @@ static inline void memcg_slab_free_hook(
 					void *p)
 {
 }
-
-static inline void slab_init_memcg_params(struct kmem_cache *s)
-{
-}
-
 #endif /* CONFIG_MEMCG_KMEM */
 
 static inline struct kmem_cache *virt_to_cache(const void *obj)
@@ -491,27 +404,18 @@ static inline struct kmem_cache *virt_to
 	return page->slab_cache;
 }
 
-static __always_inline int charge_slab_page(struct page *page,
-					    gfp_t gfp, int order,
-					    struct kmem_cache *s)
-{
-	if (memcg_kmem_enabled() && !is_root_cache(s)) {
-		int ret;
-
-		ret = memcg_alloc_page_obj_cgroups(page, s, gfp);
-		if (ret)
-			return ret;
-	}
-
+static __always_inline void charge_slab_page(struct page *page,
+					     gfp_t gfp, int order,
+					     struct kmem_cache *s)
+{
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
-	return 0;
 }
 
 static __always_inline void uncharge_slab_page(struct page *page, int order,
 					       struct kmem_cache *s)
 {
-	if (memcg_kmem_enabled() && !is_root_cache(s))
+	if (memcg_kmem_enabled())
 		memcg_free_page_obj_cgroups(page);
 
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
@@ -564,7 +468,7 @@ static inline struct kmem_cache *slab_pr
 
 	if (memcg_kmem_enabled() &&
 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
-		return memcg_slab_pre_alloc_hook(s, objcgp, size, flags);
+		*objcgp = memcg_slab_pre_alloc_hook(s, size, flags);
 
 	return s;
 }
@@ -583,8 +487,8 @@ static inline void slab_post_alloc_hook(
 					 s->flags, flags);
 	}
 
-	if (memcg_kmem_enabled() && !is_root_cache(s))
-		memcg_slab_post_alloc_hook(s, objcg, size, p);
+	if (memcg_kmem_enabled())
+		memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
 }
 
 #ifndef CONFIG_SLOB
--- a/mm/slub.c~mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations
+++ a/mm/slub.c
@@ -232,14 +232,10 @@ enum track_item { TRACK_ALLOC, TRACK_FRE
 #ifdef CONFIG_SYSFS
 static int sysfs_slab_add(struct kmem_cache *);
 static int sysfs_slab_alias(struct kmem_cache *, const char *);
-static void memcg_propagate_slab_attrs(struct kmem_cache *s);
-static void sysfs_slab_remove(struct kmem_cache *s);
 #else
 static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
 static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
 							{ return 0; }
-static inline void memcg_propagate_slab_attrs(struct kmem_cache *s) { }
-static inline void sysfs_slab_remove(struct kmem_cache *s) { }
 #endif
 
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
@@ -1643,10 +1639,8 @@ static inline struct page *alloc_slab_pa
 	else
 		page = __alloc_pages_node(node, flags, order);
 
-	if (page && charge_slab_page(page, flags, order, s)) {
-		__free_pages(page, order);
-		page = NULL;
-	}
+	if (page)
+		charge_slab_page(page, flags, order, s);
 
 	return page;
 }
@@ -3185,12 +3179,11 @@ static inline struct kmem_cache *cache_f
 	struct kmem_cache *cachep;
 
 	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
-	    !memcg_kmem_enabled() &&
 	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
 		return s;
 
 	cachep = virt_to_cache(x);
-	if (WARN(cachep && !slab_equal_or_root(cachep, s),
+	if (WARN(cachep && cachep != s,
 		  "%s: Wrong slab cache. %s but object is from %s\n",
 		  __func__, s->name, cachep->name))
 		print_tracking(cachep, x);
@@ -3972,7 +3965,6 @@ int __kmem_cache_shutdown(struct kmem_ca
 		if (n->nr_partial || slabs_node(s, node))
 			return 1;
 	}
-	sysfs_slab_remove(s);
 	return 0;
 }
 
@@ -4410,7 +4402,6 @@ static struct kmem_cache * __init bootst
 			p->slab_cache = s;
 #endif
 	}
-	slab_init_memcg_params(s);
 	list_add(&s->list, &slab_caches);
 	return s;
 }
@@ -4466,7 +4457,7 @@ struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 		   slab_flags_t flags, void (*ctor)(void *))
 {
-	struct kmem_cache *s, *c;
+	struct kmem_cache *s;
 
 	s = find_mergeable(size, align, flags, name, ctor);
 	if (s) {
@@ -4479,12 +4470,6 @@ __kmem_cache_alias(const char *name, uns
 		s->object_size = max(s->object_size, size);
 		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
 
-		c = memcg_cache(s);
-		if (c) {
-			c->object_size = s->object_size;
-			c->inuse = max(c->inuse, ALIGN(size, sizeof(void *)));
-		}
-
 		if (sysfs_slab_alias(s, name)) {
 			s->refcount--;
 			s = NULL;
@@ -4506,7 +4491,6 @@ int __kmem_cache_create(struct kmem_cach
 	if (slab_state <= UP)
 		return 0;
 
-	memcg_propagate_slab_attrs(s);
 	err = sysfs_slab_add(s);
 	if (err)
 		__kmem_cache_release(s);
@@ -5364,7 +5348,7 @@ static ssize_t shrink_store(struct kmem_
 			const char *buf, size_t length)
 {
 	if (buf[0] == '1')
-		kmem_cache_shrink_all(s);
+		kmem_cache_shrink(s);
 	else
 		return -EINVAL;
 	return length;
@@ -5588,99 +5572,9 @@ static ssize_t slab_attr_store(struct ko
 		return -EIO;
 
 	err = attribute->store(s, buf, len);
-#ifdef CONFIG_MEMCG
-	if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
-		struct kmem_cache *c;
-
-		mutex_lock(&slab_mutex);
-		if (s->max_attr_size < len)
-			s->max_attr_size = len;
-
-		/*
-		 * This is a best effort propagation, so this function's return
-		 * value will be determined by the parent cache only. This is
-		 * basically because not all attributes will have a well
-		 * defined semantics for rollbacks - most of the actions will
-		 * have permanent effects.
-		 *
-		 * Returning the error value of any of the children that fail
-		 * is not 100 % defined, in the sense that users seeing the
-		 * error code won't be able to know anything about the state of
-		 * the cache.
-		 *
-		 * Only returning the error code for the parent cache at least
-		 * has well defined semantics. The cache being written to
-		 * directly either failed or succeeded, in which case we loop
-		 * through the descendants with best-effort propagation.
-		 */
-		c = memcg_cache(s);
-		if (c)
-			attribute->store(c, buf, len);
-		mutex_unlock(&slab_mutex);
-	}
-#endif
 	return err;
 }
 
-static void memcg_propagate_slab_attrs(struct kmem_cache *s)
-{
-#ifdef CONFIG_MEMCG
-	int i;
-	char *buffer = NULL;
-	struct kmem_cache *root_cache;
-
-	if (is_root_cache(s))
-		return;
-
-	root_cache = s->memcg_params.root_cache;
-
-	/*
-	 * This mean this cache had no attribute written. Therefore, no point
-	 * in copying default values around
-	 */
-	if (!root_cache->max_attr_size)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(slab_attrs); i++) {
-		char mbuf[64];
-		char *buf;
-		struct slab_attribute *attr = to_slab_attr(slab_attrs[i]);
-		ssize_t len;
-
-		if (!attr || !attr->store || !attr->show)
-			continue;
-
-		/*
-		 * It is really bad that we have to allocate here, so we will
-		 * do it only as a fallback. If we actually allocate, though,
-		 * we can just use the allocated buffer until the end.
-		 *
-		 * Most of the slub attributes will tend to be very small in
-		 * size, but sysfs allows buffers up to a page, so they can
-		 * theoretically happen.
-		 */
-		if (buffer)
-			buf = buffer;
-		else if (root_cache->max_attr_size < ARRAY_SIZE(mbuf) &&
-			 !IS_ENABLED(CONFIG_SLUB_STATS))
-			buf = mbuf;
-		else {
-			buffer = (char *) get_zeroed_page(GFP_KERNEL);
-			if (WARN_ON(!buffer))
-				continue;
-			buf = buffer;
-		}
-
-		len = attr->show(root_cache, buf);
-		if (len > 0)
-			attr->store(s, buf, len);
-	}
-
-	if (buffer)
-		free_page((unsigned long)buffer);
-#endif	/* CONFIG_MEMCG */
-}
-
 static void kmem_cache_release(struct kobject *k)
 {
 	slab_kmem_cache_release(to_slab(k));
@@ -5700,10 +5594,6 @@ static struct kset *slab_kset;
 
 static inline struct kset *cache_kset(struct kmem_cache *s)
 {
-#ifdef CONFIG_MEMCG
-	if (!is_root_cache(s))
-		return s->memcg_params.root_cache->memcg_kset;
-#endif
 	return slab_kset;
 }
 
@@ -5746,27 +5636,6 @@ static char *create_unique_id(struct kme
 	return name;
 }
 
-static void sysfs_slab_remove_workfn(struct work_struct *work)
-{
-	struct kmem_cache *s =
-		container_of(work, struct kmem_cache, kobj_remove_work);
-
-	if (!s->kobj.state_in_sysfs)
-		/*
-		 * For a memcg cache, this may be called during
-		 * deactivation and again on shutdown.  Remove only once.
-		 * A cache is never shut down before deactivation is
-		 * complete, so no need to worry about synchronization.
-		 */
-		goto out;
-
-#ifdef CONFIG_MEMCG
-	kset_unregister(s->memcg_kset);
-#endif
-out:
-	kobject_put(&s->kobj);
-}
-
 static int sysfs_slab_add(struct kmem_cache *s)
 {
 	int err;
@@ -5774,8 +5643,6 @@ static int sysfs_slab_add(struct kmem_ca
 	struct kset *kset = cache_kset(s);
 	int unmergeable = slab_unmergeable(s);
 
-	INIT_WORK(&s->kobj_remove_work, sysfs_slab_remove_workfn);
-
 	if (!kset) {
 		kobject_init(&s->kobj, &slab_ktype);
 		return 0;
@@ -5812,16 +5679,6 @@ static int sysfs_slab_add(struct kmem_ca
 	if (err)
 		goto out_del_kobj;
 
-#ifdef CONFIG_MEMCG
-	if (is_root_cache(s) && memcg_sysfs_enabled) {
-		s->memcg_kset = kset_create_and_add("cgroup", NULL, &s->kobj);
-		if (!s->memcg_kset) {
-			err = -ENOMEM;
-			goto out_del_kobj;
-		}
-	}
-#endif
-
 	if (!unmergeable) {
 		/* Setup first alias */
 		sysfs_slab_alias(s, s->name);
@@ -5835,19 +5692,6 @@ out_del_kobj:
 	goto out;
 }
 
-static void sysfs_slab_remove(struct kmem_cache *s)
-{
-	if (slab_state < FULL)
-		/*
-		 * Sysfs has not been setup yet so no need to remove the
-		 * cache from sysfs.
-		 */
-		return;
-
-	kobject_get(&s->kobj);
-	schedule_work(&s->kobj_remove_work);
-}
-
 void sysfs_slab_unlink(struct kmem_cache *s)
 {
 	if (slab_state >= FULL)
_

