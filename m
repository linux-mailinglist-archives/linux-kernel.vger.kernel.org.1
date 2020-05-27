Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA11E514C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 00:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgE0WeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 18:34:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9468 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgE0WeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:34:11 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RMFdjL014010
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=B4l3jobioik6iw5/Xu+fYDMXC/cQJ3oCxXHHmxFUTVE=;
 b=PjqYiTO3rKWGDOPF7KMU2Bqrq+63pHht2HO6tfJtX4Tafaw7U4KnE5Lzi2A/KoH/hS+0
 64AKQttRCUGFjYAas0KB6SnTEWSWTjyn9qsG6nnGiWScD+vU11elgF8PXY5GjUQEUNJf
 hCVJkPBU3G5pzzsJnpOykIn8etLljhSxh6k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 319yh5gy4y-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:10 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 15:34:09 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 952D8166901A; Wed, 27 May 2020 15:34:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1291.vll0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: vll0c01
Subject: [PATCH v5 03/19] mm: memcg: convert vmstat slab counters to bytes
Date:   Wed, 27 May 2020 15:33:48 -0700
Message-ID: <20200527223404.1008856-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527223404.1008856-1-guro@fb.com>
References: <20200527223404.1008856-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=2
 lowpriorityscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270170
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for per-object slab memory accounting, convert
NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat items to bytes.

To make it obvious, rename them to NR_SLAB_RECLAIMABLE_B and
NR_SLAB_UNRECLAIMABLE_B (similar to NR_KERNEL_STACK_KB).

Internally global and per-node counters are stored in pages,
however memcg and lruvec counters are stored in bytes.
This scheme may look weird, but only for now. As soon as slab
pages will be shared between multiple cgroups, global and
node counters will reflect the total number of slab pages.
However memcg and lruvec counters will be used for per-memcg
slab memory tracking, which will take separate kernel objects
in the account. Keeping global and node counters in pages helps
to avoid additional overhead.

The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
so it will fit into atomic_long_t we use for vmstats.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/base/node.c     |  4 ++--
 fs/proc/meminfo.c       |  4 ++--
 include/linux/mmzone.h  | 16 +++++++++++++---
 kernel/power/snapshot.c |  2 +-
 mm/memcontrol.c         | 11 ++++-------
 mm/oom_kill.c           |  2 +-
 mm/page_alloc.c         |  8 ++++----
 mm/slab.h               | 15 ++++++++-------
 mm/slab_common.c        |  4 ++--
 mm/slob.c               | 12 ++++++------
 mm/slub.c               |  8 ++++----
 mm/vmscan.c             |  3 ++-
 mm/workingset.c         |  6 ++++--
 13 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9f4aa0a1ddb8..8f438926b833 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -368,8 +368,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 	unsigned long sreclaimable, sunreclaimable;
=20
 	si_meminfo_node(&i, nid);
-	sreclaimable =3D node_page_state(pgdat, NR_SLAB_RECLAIMABLE);
-	sunreclaimable =3D node_page_state(pgdat, NR_SLAB_UNRECLAIMABLE);
+	sreclaimable =3D node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
+	sunreclaimable =3D node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B=
);
 	n =3D sprintf(buf,
 		       "Node %d MemTotal:       %8lu kB\n"
 		       "Node %d MemFree:        %8lu kB\n"
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index e3d14ee8588d..5e3f2656fee6 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -52,8 +52,8 @@ static int meminfo_proc_show(struct seq_file *m, void *=
v)
 		pages[lru] =3D global_node_page_state(NR_LRU_BASE + lru);
=20
 	available =3D si_mem_available();
-	sreclaimable =3D global_node_page_state(NR_SLAB_RECLAIMABLE);
-	sunreclaim =3D global_node_page_state(NR_SLAB_UNRECLAIMABLE);
+	sreclaimable =3D global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
+	sunreclaim =3D global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
=20
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ef2dd8b3bc09..e5dfc2c13b9a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -174,8 +174,8 @@ enum node_stat_item {
 	NR_INACTIVE_FILE,	/*  "     "     "   "       "         */
 	NR_ACTIVE_FILE,		/*  "     "     "   "       "         */
 	NR_UNEVICTABLE,		/*  "     "     "   "       "         */
-	NR_SLAB_RECLAIMABLE,
-	NR_SLAB_UNRECLAIMABLE,
+	NR_SLAB_RECLAIMABLE_B,
+	NR_SLAB_UNRECLAIMABLE_B,
 	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
 	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
 	WORKINGSET_NODES,
@@ -214,7 +214,17 @@ enum node_stat_item {
  */
 static __always_inline bool vmstat_item_in_bytes(enum node_stat_item ite=
m)
 {
-	return false;
+	/*
+	 * Global and per-node slab counters track slab pages.
+	 * It's expected that changes are multiples of PAGE_SIZE.
+	 * Internally values are stored in pages.
+	 *
+	 * Per-memcg and per-lruvec counters track memory, consumed
+	 * by individual slab objects. These counters are actually
+	 * byte-precise.
+	 */
+	return (item =3D=3D NR_SLAB_RECLAIMABLE_B ||
+		item =3D=3D NR_SLAB_UNRECLAIMABLE_B);
 }
=20
 /*
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 881128b9351e..eefc907e5324 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1663,7 +1663,7 @@ static unsigned long minimum_image_size(unsigned lo=
ng saveable)
 {
 	unsigned long size;
=20
-	size =3D global_node_page_state(NR_SLAB_RECLAIMABLE)
+	size =3D global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B)
 		+ global_node_page_state(NR_ACTIVE_ANON)
 		+ global_node_page_state(NR_INACTIVE_ANON)
 		+ global_node_page_state(NR_ACTIVE_FILE)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c814373af501..b53dee2bb395 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1391,9 +1391,8 @@ static char *memory_stat_format(struct mem_cgroup *=
memcg)
 		       (u64)memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) *
 		       1024);
 	seq_buf_printf(&s, "slab %llu\n",
-		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) +
-			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE)) *
-		       PAGE_SIZE);
+		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
+			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B)));
 	seq_buf_printf(&s, "sock %llu\n",
 		       (u64)memcg_page_state(memcg, MEMCG_SOCK) *
 		       PAGE_SIZE);
@@ -1423,11 +1422,9 @@ static char *memory_stat_format(struct mem_cgroup =
*memcg)
 			       PAGE_SIZE);
=20
 	seq_buf_printf(&s, "slab_reclaimable %llu\n",
-		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) *
-		       PAGE_SIZE);
+		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B));
 	seq_buf_printf(&s, "slab_unreclaimable %llu\n",
-		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE) *
-		       PAGE_SIZE);
+		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B));
=20
 	/* Accumulated memory events */
=20
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 6e94962893ee..d30ce75f23fb 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -184,7 +184,7 @@ static bool is_dump_unreclaim_slabs(void)
 		 global_node_page_state(NR_ISOLATED_FILE) +
 		 global_node_page_state(NR_UNEVICTABLE);
=20
-	return (global_node_page_state(NR_SLAB_UNRECLAIMABLE) > nr_lru);
+	return (global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) > nr_lru)=
;
 }
=20
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 940cdce96864..4a6ad5ec4325 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5248,8 +5248,8 @@ long si_mem_available(void)
 	 * items that are in use, and cannot be freed. Cap this estimate at the
 	 * low watermark.
 	 */
-	reclaimable =3D global_node_page_state(NR_SLAB_RECLAIMABLE) +
-			global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
+	reclaimable =3D global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
+		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
 	available +=3D reclaimable - min(reclaimable / 2, wmark_low);
=20
 	if (available < 0)
@@ -5393,8 +5393,8 @@ void show_free_areas(unsigned int filter, nodemask_=
t *nodemask)
 		global_node_page_state(NR_FILE_DIRTY),
 		global_node_page_state(NR_WRITEBACK),
 		global_node_page_state(NR_UNSTABLE_NFS),
-		global_node_page_state(NR_SLAB_RECLAIMABLE),
-		global_node_page_state(NR_SLAB_UNRECLAIMABLE),
+		global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
+		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
 		global_node_page_state(NR_FILE_MAPPED),
 		global_node_page_state(NR_SHMEM),
 		global_zone_page_state(NR_PAGETABLE),
diff --git a/mm/slab.h b/mm/slab.h
index 815e4e9a94cd..633eedb6bad1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -272,7 +272,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *, gfp_=
t, size_t, void **);
 static inline int cache_vmstat_idx(struct kmem_cache *s)
 {
 	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
+		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
@@ -361,7 +361,7 @@ static __always_inline int memcg_charge_slab(struct p=
age *page,
=20
 	if (unlikely(!memcg || mem_cgroup_is_root(memcg))) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    nr_pages);
+				    nr_pages << PAGE_SHIFT);
 		percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
 		return 0;
 	}
@@ -371,7 +371,7 @@ static __always_inline int memcg_charge_slab(struct p=
age *page,
 		goto out;
=20
 	lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
-	mod_lruvec_state(lruvec, cache_vmstat_idx(s), nr_pages);
+	mod_lruvec_state(lruvec, cache_vmstat_idx(s), nr_pages << PAGE_SHIFT);
=20
 	/* transer try_charge() page references to kmem_cache */
 	percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
@@ -396,11 +396,12 @@ static __always_inline void memcg_uncharge_slab(str=
uct page *page, int order,
 	memcg =3D READ_ONCE(s->memcg_params.memcg);
 	if (likely(!mem_cgroup_is_root(memcg))) {
 		lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
-		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
+		mod_lruvec_state(lruvec, cache_vmstat_idx(s),
+				 -(nr_pages << PAGE_SHIFT));
 		memcg_kmem_uncharge(memcg, nr_pages);
 	} else {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -nr_pages);
+				    -(nr_pages << PAGE_SHIFT));
 	}
 	rcu_read_unlock();
=20
@@ -484,7 +485,7 @@ static __always_inline int charge_slab_page(struct pa=
ge *page,
 {
 	if (is_root_cache(s)) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    1 << order);
+				    PAGE_SIZE << order);
 		return 0;
 	}
=20
@@ -496,7 +497,7 @@ static __always_inline void uncharge_slab_page(struct=
 page *page, int order,
 {
 	if (is_root_cache(s)) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(1 << order));
+				    -(PAGE_SIZE << order));
 		return;
 	}
=20
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9e72ba224175..b578ae29c743 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1325,8 +1325,8 @@ void *kmalloc_order(size_t size, gfp_t flags, unsig=
ned int order)
 	page =3D alloc_pages(flags, order);
 	if (likely(page)) {
 		ret =3D page_address(page);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-				    1 << order);
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+				    PAGE_SIZE << order);
 	}
 	ret =3D kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
diff --git a/mm/slob.c b/mm/slob.c
index ac2aecfbc7a8..7cc9805c8091 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -202,8 +202,8 @@ static void *slob_new_pages(gfp_t gfp, int order, int=
 node)
 	if (!page)
 		return NULL;
=20
-	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-			    1 << order);
+	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+			    PAGE_SIZE << order);
 	return page_address(page);
 }
=20
@@ -214,8 +214,8 @@ static void slob_free_pages(void *b, int order)
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab +=3D 1 << order;
=20
-	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
-			    -(1 << order));
+	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
+			    -(PAGE_SIZE << order));
 	__free_pages(sp, order);
 }
=20
@@ -552,8 +552,8 @@ void kfree(const void *block)
 		slob_free(m, *m + align);
 	} else {
 		unsigned int order =3D compound_order(sp);
-		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
-				    -(1 << order));
+		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
+				    -(PAGE_SIZE << order));
 		__free_pages(sp, order);
=20
 	}
diff --git a/mm/slub.c b/mm/slub.c
index 03e063cd979f..dbed2cfd2776 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3923,8 +3923,8 @@ static void *kmalloc_large_node(size_t size, gfp_t =
flags, int node)
 	page =3D alloc_pages_node(node, flags, order);
 	if (page) {
 		ptr =3D page_address(page);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-				    1 << order);
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+				    PAGE_SIZE << order);
 	}
=20
 	return kmalloc_large_node_hook(ptr, size, flags);
@@ -4055,8 +4055,8 @@ void kfree(const void *x)
=20
 		BUG_ON(!PageCompound(page));
 		kfree_hook(object);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-				    -(1 << order));
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+				    -(PAGE_SIZE << order));
 		__free_pages(page, order);
 		return;
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3a482b22fe4e..56a600c7c9d7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4219,7 +4219,8 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t g=
fp_mask, unsigned int order)
 	 * unmapped file backed pages.
 	 */
 	if (node_pagecache_reclaimable(pgdat) <=3D pgdat->min_unmapped_pages &&
-	    node_page_state(pgdat, NR_SLAB_RECLAIMABLE) <=3D pgdat->min_slab_pa=
ges)
+	    node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) <=3D
+	    pgdat->min_slab_pages)
 		return NODE_RECLAIM_FULL;
=20
 	/*
diff --git a/mm/workingset.c b/mm/workingset.c
index d481ea452eeb..9bf12523e3f0 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -478,8 +478,10 @@ static unsigned long count_shadow_nodes(struct shrin=
ker *shrinker,
 		for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
 			pages +=3D lruvec_page_state_local(lruvec,
 							 NR_LRU_BASE + i);
-		pages +=3D lruvec_page_state_local(lruvec, NR_SLAB_RECLAIMABLE);
-		pages +=3D lruvec_page_state_local(lruvec, NR_SLAB_UNRECLAIMABLE);
+		pages +=3D lruvec_page_state_local(
+			lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
+		pages +=3D lruvec_page_state_local(
+			lruvec, NR_SLAB_UNRECLAIMABLE_B) >> PAGE_SHIFT;
 	} else
 #endif
 		pages =3D node_present_pages(sc->nid);
--=20
2.25.4

