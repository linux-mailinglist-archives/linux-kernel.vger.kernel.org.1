Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3859320598F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgFWRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:42:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387907AbgFWRlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:41:00 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHcW9e011259
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:40:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HICo7ZbXoMItRhpFtatHxTxJpoSIM5eIJzYCg1ONNwA=;
 b=Uqb41lujzwrhTnecvpEVYnsRH5piHYM2wFXjkRRqtCu11hiyJUB35B6/GV81yk292OFq
 aMK6mY2OGHC3o3QCpCzrO77GWhKXvXTMMjRV9FMbxE5Jpl5A+Kx0ZWHpZK13gcan4p34
 JRxd8gfEK9KtumWysv+HINT6FbL0ROBrs0s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk2095tj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:40:54 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 10:40:52 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id CF0B9273E5EA; Tue, 23 Jun 2020 10:40:41 -0700 (PDT)
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
Subject: [PATCH v7 12/19] mm: memcg/slab: use a single set of kmem_caches for all accounted allocations
Date:   Tue, 23 Jun 2020 10:40:30 -0700
Message-ID: <20200623174037.3951353-13-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623174037.3951353-1-guro@fb.com>
References: <20200623174037.3951353-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=2
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006120000 definitions=main-2006230124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is fairly big but mostly red patch, which makes all accounted slab
allocations use a single set of kmem_caches instead of creating a separat=
e
set for each memory cgroup.

Because the number of non-root kmem_caches is now capped by the number of
root kmem_caches, there is no need to shrink or destroy them prematurely.
They can be perfectly destroyed together with their root counterparts.
This allows to dramatically simplify the management of non-root
kmem_caches and delete a ton of code.

This patch performs the following changes:
1) introduces memcg_params.memcg_cache pointer to represent the
   kmem_cache which will be used for all non-root allocations
2) reuses the existing memcg kmem_cache creation mechanism
   to create memcg kmem_cache on the first allocation attempt
3) memcg kmem_caches are named <kmemcache_name>-memcg,
   e.g. dentry-memcg
4) simplifies memcg_kmem_get_cache() to just return memcg kmem_cache
   or schedule it's creation and return the root cache
5) removes almost all non-root kmem_cache management code
   (separate refcounter, reparenting, shrinking, etc)
6) makes slab debugfs to display root_mem_cgroup css id and never
   show :dead and :deact flags in the memcg_slabinfo attribute.

Following patches in the series will simplify the kmem_cache creation.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |   5 +-
 include/linux/slab.h       |   5 +-
 mm/memcontrol.c            | 167 +++------------
 mm/slab.c                  |  16 +-
 mm/slab.h                  | 146 ++++---------
 mm/slab_common.c           | 426 ++++---------------------------------
 mm/slub.c                  |  38 +---
 7 files changed, 129 insertions(+), 674 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 83e2858aecf2..11fd18b3d6c6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -317,7 +317,6 @@ struct mem_cgroup {
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
-	struct list_head kmem_caches;
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
 #endif
@@ -1404,9 +1403,7 @@ static inline void memcg_set_shrinker_bit(struct me=
m_cgroup *memcg,
 }
 #endif
=20
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
-					struct obj_cgroup **objcgp);
-void memcg_kmem_put_cache(struct kmem_cache *cachep);
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
=20
 #ifdef CONFIG_MEMCG_KMEM
 int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0884d82c55ee..8b1f91e320f9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -155,8 +155,7 @@ struct kmem_cache *kmem_cache_create_usercopy(const c=
har *name,
 void kmem_cache_destroy(struct kmem_cache *);
 int kmem_cache_shrink(struct kmem_cache *);
=20
-void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
-void memcg_deactivate_kmem_caches(struct mem_cgroup *, struct mem_cgroup=
 *);
+void memcg_create_kmem_cache(struct kmem_cache *cachep);
=20
 /*
  * Please use this macro to create slab caches. Simply specify the
@@ -580,8 +579,6 @@ static __always_inline void *kmalloc_node(size_t size=
, gfp_t flags, int node)
 	return __kmalloc_node(size, flags, node);
 }
=20
-int memcg_update_all_caches(int num_memcgs);
-
 /**
  * kmalloc_array - allocate memory for an array.
  * @n: number of elements.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ad1ff0f0107..417070fb0fd0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -350,7 +350,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *=
memcg,
 }
=20
 /*
- * This will be the memcg's index in each cache's ->memcg_params.memcg_c=
aches.
+ * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
  *  this works better in sparse environments, where we have a lot of mem=
cgs,
  *  but only a few kmem-limited. Or also, if we have, for instance, 200
@@ -569,20 +569,16 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino =3D 0;
=20
 	rcu_read_lock();
-	if (PageSlab(page) && !PageTail(page)) {
-		memcg =3D memcg_from_slab_page(page);
-	} else {
-		memcg =3D page->mem_cgroup;
+	memcg =3D page->mem_cgroup;
=20
-		/*
-		 * The lowest bit set means that memcg isn't a valid
-		 * memcg pointer, but a obj_cgroups pointer.
-		 * In this case the page is shared and doesn't belong
-		 * to any specific memory cgroup.
-		 */
-		if ((unsigned long) memcg & 0x1UL)
-			memcg =3D NULL;
-	}
+	/*
+	 * The lowest bit set means that memcg isn't a valid
+	 * memcg pointer, but a obj_cgroups pointer.
+	 * In this case the page is shared and doesn't belong
+	 * to any specific memory cgroup.
+	 */
+	if ((unsigned long) memcg & 0x1UL)
+		memcg =3D NULL;
=20
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
 		memcg =3D parent_mem_cgroup(memcg);
@@ -2822,12 +2818,18 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	page =3D virt_to_head_page(p);
=20
 	/*
-	 * Slab pages don't have page->mem_cgroup set because corresponding
-	 * kmem caches can be reparented during the lifetime. That's why
-	 * memcg_from_slab_page() should be used instead.
+	 * Slab objects are accounted individually, not per-page.
+	 * Memcg membership data for each individual object is saved in
+	 * the page->obj_cgroups.
 	 */
-	if (PageSlab(page))
-		return memcg_from_slab_page(page);
+	if (page_has_obj_cgroups(page)) {
+		struct obj_cgroup *objcg;
+		unsigned int off;
+
+		off =3D obj_to_index(page->slab_cache, page, p);
+		objcg =3D page_obj_cgroups(page)[off];
+		return obj_cgroup_memcg(objcg);
+	}
=20
 	/* All other pages use page->mem_cgroup */
 	return page->mem_cgroup;
@@ -2882,9 +2884,7 @@ static int memcg_alloc_cache_id(void)
 	else if (size > MEMCG_CACHES_MAX_SIZE)
 		size =3D MEMCG_CACHES_MAX_SIZE;
=20
-	err =3D memcg_update_all_caches(size);
-	if (!err)
-		err =3D memcg_update_all_list_lrus(size);
+	err =3D memcg_update_all_list_lrus(size);
 	if (!err)
 		memcg_nr_cache_ids =3D size;
=20
@@ -2903,7 +2903,6 @@ static void memcg_free_cache_id(int id)
 }
=20
 struct memcg_kmem_cache_create_work {
-	struct mem_cgroup *memcg;
 	struct kmem_cache *cachep;
 	struct work_struct work;
 };
@@ -2912,33 +2911,24 @@ static void memcg_kmem_cache_create_func(struct w=
ork_struct *w)
 {
 	struct memcg_kmem_cache_create_work *cw =3D
 		container_of(w, struct memcg_kmem_cache_create_work, work);
-	struct mem_cgroup *memcg =3D cw->memcg;
 	struct kmem_cache *cachep =3D cw->cachep;
=20
-	memcg_create_kmem_cache(memcg, cachep);
+	memcg_create_kmem_cache(cachep);
=20
-	css_put(&memcg->css);
 	kfree(cw);
 }
=20
 /*
  * Enqueue the creation of a per-memcg kmem_cache.
  */
-static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
-					       struct kmem_cache *cachep)
+static void memcg_schedule_kmem_cache_create(struct kmem_cache *cachep)
 {
 	struct memcg_kmem_cache_create_work *cw;
=20
-	if (!css_tryget_online(&memcg->css))
-		return;
-
 	cw =3D kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
-	if (!cw) {
-		css_put(&memcg->css);
+	if (!cw)
 		return;
-	}
=20
-	cw->memcg =3D memcg;
 	cw->cachep =3D cachep;
 	INIT_WORK(&cw->work, memcg_kmem_cache_create_func);
=20
@@ -2946,102 +2936,26 @@ static void memcg_schedule_kmem_cache_create(str=
uct mem_cgroup *memcg,
 }
=20
 /**
- * memcg_kmem_get_cache: select the correct per-memcg cache for allocati=
on
+ * memcg_kmem_get_cache: select memcg or root cache for allocation
  * @cachep: the original global kmem cache
  *
  * Return the kmem_cache we're supposed to use for a slab allocation.
- * We try to use the current memcg's version of the cache.
  *
  * If the cache does not exist yet, if we are the first user of it, we
  * create it asynchronously in a workqueue and let the current allocatio=
n
  * go through with the original cache.
- *
- * This function takes a reference to the cache it returns to assure it
- * won't get destroyed while we are working with it. Once the caller is
- * done with it, memcg_kmem_put_cache() must be called to release the
- * reference.
  */
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
-					struct obj_cgroup **objcgp)
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 {
-	struct mem_cgroup *memcg;
 	struct kmem_cache *memcg_cachep;
-	struct memcg_cache_array *arr;
-	int kmemcg_id;
=20
-	VM_BUG_ON(!is_root_cache(cachep));
-
-	if (memcg_kmem_bypass())
+	memcg_cachep =3D READ_ONCE(cachep->memcg_params.memcg_cache);
+	if (unlikely(!memcg_cachep)) {
+		memcg_schedule_kmem_cache_create(cachep);
 		return cachep;
-
-	rcu_read_lock();
-
-	if (unlikely(current->active_memcg))
-		memcg =3D current->active_memcg;
-	else
-		memcg =3D mem_cgroup_from_task(current);
-
-	if (!memcg || memcg =3D=3D root_mem_cgroup)
-		goto out_unlock;
-
-	kmemcg_id =3D READ_ONCE(memcg->kmemcg_id);
-	if (kmemcg_id < 0)
-		goto out_unlock;
-
-	arr =3D rcu_dereference(cachep->memcg_params.memcg_caches);
-
-	/*
-	 * Make sure we will access the up-to-date value. The code updating
-	 * memcg_caches issues a write barrier to match the data dependency
-	 * barrier inside READ_ONCE() (see memcg_create_kmem_cache()).
-	 */
-	memcg_cachep =3D READ_ONCE(arr->entries[kmemcg_id]);
-
-	/*
-	 * If we are in a safe context (can wait, and not in interrupt
-	 * context), we could be be predictable and return right away.
-	 * This would guarantee that the allocation being performed
-	 * already belongs in the new cache.
-	 *
-	 * However, there are some clashes that can arrive from locking.
-	 * For instance, because we acquire the slab_mutex while doing
-	 * memcg_create_kmem_cache, this means no further allocation
-	 * could happen with the slab_mutex held. So it's better to
-	 * defer everything.
-	 *
-	 * If the memcg is dying or memcg_cache is about to be released,
-	 * don't bother creating new kmem_caches. Because memcg_cachep
-	 * is ZEROed as the fist step of kmem offlining, we don't need
-	 * percpu_ref_tryget_live() here. css_tryget_online() check in
-	 * memcg_schedule_kmem_cache_create() will prevent us from
-	 * creation of a new kmem_cache.
-	 */
-	if (unlikely(!memcg_cachep))
-		memcg_schedule_kmem_cache_create(memcg, cachep);
-	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt)) {
-		struct obj_cgroup *objcg =3D rcu_dereference(memcg->objcg);
-
-		if (!objcg || !obj_cgroup_tryget(objcg)) {
-			percpu_ref_put(&memcg_cachep->memcg_params.refcnt);
-			goto out_unlock;
-		}
-
-		*objcgp =3D objcg;
-		cachep =3D memcg_cachep;
 	}
-out_unlock:
-	rcu_read_unlock();
-	return cachep;
-}
=20
-/**
- * memcg_kmem_put_cache: drop reference taken by memcg_kmem_get_cache
- * @cachep: the cache returned by memcg_kmem_get_cache
- */
-void memcg_kmem_put_cache(struct kmem_cache *cachep)
-{
-	if (!is_root_cache(cachep))
-		percpu_ref_put(&cachep->memcg_params.refcnt);
+	return memcg_cachep;
 }
=20
 /**
@@ -3730,7 +3644,6 @@ static int memcg_online_kmem(struct mem_cgroup *mem=
cg)
 	 */
 	memcg->kmemcg_id =3D memcg_id;
 	memcg->kmem_state =3D KMEM_ONLINE;
-	INIT_LIST_HEAD(&memcg->kmem_caches);
=20
 	return 0;
 }
@@ -3743,22 +3656,13 @@ static void memcg_offline_kmem(struct mem_cgroup =
*memcg)
=20
 	if (memcg->kmem_state !=3D KMEM_ONLINE)
 		return;
-	/*
-	 * Clear the online state before clearing memcg_caches array
-	 * entries. The slab_mutex in memcg_deactivate_kmem_caches()
-	 * guarantees that no cache will be created for this cgroup
-	 * after we are done (see memcg_create_kmem_cache()).
-	 */
+
 	memcg->kmem_state =3D KMEM_ALLOCATED;
=20
 	parent =3D parent_mem_cgroup(memcg);
 	if (!parent)
 		parent =3D root_mem_cgroup;
=20
-	/*
-	 * Deactivate and reparent kmem_caches and objcgs.
-	 */
-	memcg_deactivate_kmem_caches(memcg, parent);
 	memcg_reparent_objcgs(memcg, parent);
=20
 	kmemcg_id =3D memcg->kmemcg_id;
@@ -3793,10 +3697,8 @@ static void memcg_free_kmem(struct mem_cgroup *mem=
cg)
 	if (unlikely(memcg->kmem_state =3D=3D KMEM_ONLINE))
 		memcg_offline_kmem(memcg);
=20
-	if (memcg->kmem_state =3D=3D KMEM_ALLOCATED) {
-		WARN_ON(!list_empty(&memcg->kmem_caches));
+	if (memcg->kmem_state =3D=3D KMEM_ALLOCATED)
 		static_branch_dec(&memcg_kmem_enabled_key);
-	}
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -5388,9 +5290,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *pa=
rent_css)
=20
 	/* The following stuff does not apply to the root */
 	if (!parent) {
-#ifdef CONFIG_MEMCG_KMEM
-		INIT_LIST_HEAD(&memcg->kmem_caches);
-#endif
 		root_mem_cgroup =3D memcg;
 		return &memcg->css;
 	}
diff --git a/mm/slab.c b/mm/slab.c
index a7cc1336221f..84e218fd0bcf 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1239,7 +1239,7 @@ void __init kmem_cache_init(void)
 				  nr_node_ids * sizeof(struct kmem_cache_node *),
 				  SLAB_HWCACHE_ALIGN, 0, 0);
 	list_add(&kmem_cache->list, &slab_caches);
-	memcg_link_cache(kmem_cache, NULL);
+	memcg_link_cache(kmem_cache);
 	slab_state =3D PARTIAL;
=20
 	/*
@@ -2243,17 +2243,6 @@ int __kmem_cache_shrink(struct kmem_cache *cachep)
 	return (ret ? 1 : 0);
 }
=20
-#ifdef CONFIG_MEMCG
-void __kmemcg_cache_deactivate(struct kmem_cache *cachep)
-{
-	__kmem_cache_shrink(cachep);
-}
-
-void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
-{
-}
-#endif
-
 int __kmem_cache_shutdown(struct kmem_cache *cachep)
 {
 	return __kmem_cache_shrink(cachep);
@@ -3865,7 +3854,8 @@ static int do_tune_cpucache(struct kmem_cache *cach=
ep, int limit,
 		return ret;
=20
 	lockdep_assert_held(&slab_mutex);
-	for_each_memcg_cache(c, cachep) {
+	c =3D memcg_cache(cachep);
+	if (c) {
 		/* return value determined by the root cache only */
 		__do_tune_cpucache(c, limit, batchcount, shared, gfp);
 	}
diff --git a/mm/slab.h b/mm/slab.h
index b31ed02b6445..673448e5cfb3 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -32,66 +32,25 @@ struct kmem_cache {
=20
 #else /* !CONFIG_SLOB */
=20
-struct memcg_cache_array {
-	struct rcu_head rcu;
-	struct kmem_cache *entries[0];
-};
-
 /*
  * This is the main placeholder for memcg-related information in kmem ca=
ches.
- * Both the root cache and the child caches will have it. For the root c=
ache,
- * this will hold a dynamically allocated array large enough to hold
- * information about the currently limited memcgs in the system. To allo=
w the
- * array to be accessed without taking any locks, on relocation we free =
the old
- * version only after a grace period.
- *
- * Root and child caches hold different metadata.
+ * Both the root cache and the child cache will have it. Some fields are=
 used
+ * in both cases, other are specific to root caches.
  *
  * @root_cache:	Common to root and child caches.  NULL for root, pointer=
 to
  *		the root cache for children.
  *
  * The following fields are specific to root caches.
  *
- * @memcg_caches: kmemcg ID indexed table of child caches.  This table i=
s
- *		used to index child cachces during allocation and cleared
- *		early during shutdown.
- *
- * @root_caches_node: List node for slab_root_caches list.
- *
- * @children:	List of all child caches.  While the child caches are also
- *		reachable through @memcg_caches, a child cache remains on
- *		this list until it is actually destroyed.
- *
- * The following fields are specific to child caches.
- *
- * @memcg:	Pointer to the memcg this cache belongs to.
- *
- * @children_node: List node for @root_cache->children list.
- *
- * @kmem_caches_node: List node for @memcg->kmem_caches list.
+ * @memcg_cache: pointer to memcg kmem cache, used by all non-root memor=
y
+ *		cgroups.
+ * @root_caches_node: list node for slab_root_caches list.
  */
 struct memcg_cache_params {
 	struct kmem_cache *root_cache;
-	union {
-		struct {
-			struct memcg_cache_array __rcu *memcg_caches;
-			struct list_head __root_caches_node;
-			struct list_head children;
-			bool dying;
-		};
-		struct {
-			struct mem_cgroup *memcg;
-			struct list_head children_node;
-			struct list_head kmem_caches_node;
-			struct percpu_ref refcnt;
-
-			void (*work_fn)(struct kmem_cache *);
-			union {
-				struct rcu_head rcu_head;
-				struct work_struct work;
-			};
-		};
-	};
+
+	struct kmem_cache *memcg_cache;
+	struct list_head __root_caches_node;
 };
 #endif /* CONFIG_SLOB */
=20
@@ -235,8 +194,6 @@ bool __kmem_cache_empty(struct kmem_cache *);
 int __kmem_cache_shutdown(struct kmem_cache *);
 void __kmem_cache_release(struct kmem_cache *);
 int __kmem_cache_shrink(struct kmem_cache *);
-void __kmemcg_cache_deactivate(struct kmem_cache *s);
-void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
 void slab_kmem_cache_release(struct kmem_cache *);
 void kmem_cache_shrink_all(struct kmem_cache *s);
=20
@@ -310,14 +267,6 @@ static inline bool kmem_cache_debug_flags(struct kme=
m_cache *s, slab_flags_t fla
 extern struct list_head		slab_root_caches;
 #define root_caches_node	memcg_params.__root_caches_node
=20
-/*
- * Iterate over all memcg caches of the given root cache. The caller mus=
t hold
- * slab_mutex.
- */
-#define for_each_memcg_cache(iter, root) \
-	list_for_each_entry(iter, &(root)->memcg_params.children, \
-			    memcg_params.children_node)
-
 static inline bool is_root_cache(struct kmem_cache *s)
 {
 	return !s->memcg_params.root_cache;
@@ -348,6 +297,13 @@ static inline struct kmem_cache *memcg_root_cache(st=
ruct kmem_cache *s)
 	return s->memcg_params.root_cache;
 }
=20
+static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
+{
+	if (is_root_cache(s))
+		return s->memcg_params.memcg_cache;
+	return NULL;
+}
+
 static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
 {
 	/*
@@ -360,25 +316,9 @@ static inline struct obj_cgroup **page_obj_cgroups(s=
truct page *page)
 		((unsigned long)page->obj_cgroups & ~0x1UL);
 }
=20
-/*
- * Expects a pointer to a slab page. Please note, that PageSlab() check
- * isn't sufficient, as it returns true also for tail compound slab page=
s,
- * which do not have slab_cache pointer set.
- * So this function assumes that the page can pass PageSlab() && !PageTa=
il()
- * check.
- *
- * The kmem_cache can be reparented asynchronously. The caller must ensu=
re
- * the memcg lifetime, e.g. by taking rcu_read_lock() or cgroup_mutex.
- */
-static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
+static inline bool page_has_obj_cgroups(struct page *page)
 {
-	struct kmem_cache *s;
-
-	s =3D READ_ONCE(page->slab_cache);
-	if (s && !is_root_cache(s))
-		return READ_ONCE(s->memcg_params.memcg);
-
-	return NULL;
+	return ((unsigned long)page->obj_cgroups & 0x1UL);
 }
=20
 static inline int memcg_alloc_page_obj_cgroups(struct page *page,
@@ -417,17 +357,25 @@ static inline struct kmem_cache *memcg_slab_pre_all=
oc_hook(struct kmem_cache *s,
 						size_t objects, gfp_t flags)
 {
 	struct kmem_cache *cachep;
+	struct obj_cgroup *objcg;
+
+	if (memcg_kmem_bypass())
+		return s;
=20
-	cachep =3D memcg_kmem_get_cache(s, objcgp);
+	cachep =3D memcg_kmem_get_cache(s);
 	if (is_root_cache(cachep))
 		return s;
=20
-	if (obj_cgroup_charge(*objcgp, flags, objects * obj_full_size(s))) {
-		obj_cgroup_put(*objcgp);
-		memcg_kmem_put_cache(cachep);
+	objcg =3D get_obj_cgroup_from_current();
+	if (!objcg)
+		return s;
+
+	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
+		obj_cgroup_put(objcg);
 		cachep =3D NULL;
 	}
=20
+	*objcgp =3D objcg;
 	return cachep;
 }
=20
@@ -466,7 +414,6 @@ static inline void memcg_slab_post_alloc_hook(struct =
kmem_cache *s,
 		}
 	}
 	obj_cgroup_put(objcg);
-	memcg_kmem_put_cache(s);
 }
=20
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct pag=
e *page,
@@ -490,7 +437,7 @@ static inline void memcg_slab_free_hook(struct kmem_c=
ache *s, struct page *page,
 }
=20
 extern void slab_init_memcg_params(struct kmem_cache *);
-extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *me=
mcg);
+extern void memcg_link_cache(struct kmem_cache *s);
=20
 #else /* CONFIG_MEMCG_KMEM */
=20
@@ -498,9 +445,6 @@ extern void memcg_link_cache(struct kmem_cache *s, st=
ruct mem_cgroup *memcg);
 #define slab_root_caches	slab_caches
 #define root_caches_node	list
=20
-#define for_each_memcg_cache(iter, root) \
-	for ((void)(iter), (void)(root); 0; )
-
 static inline bool is_root_cache(struct kmem_cache *s)
 {
 	return true;
@@ -522,7 +466,17 @@ static inline struct kmem_cache *memcg_root_cache(st=
ruct kmem_cache *s)
 	return s;
 }
=20
-static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
+static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
+{
+	return NULL;
+}
+
+static inline bool page_has_obj_cgroups(struct page *page)
+{
+	return false;
+}
+
+static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
 	return NULL;
 }
@@ -559,8 +513,7 @@ static inline void slab_init_memcg_params(struct kmem=
_cache *s)
 {
 }
=20
-static inline void memcg_link_cache(struct kmem_cache *s,
-				    struct mem_cgroup *memcg)
+static inline void memcg_link_cache(struct kmem_cache *s)
 {
 }
=20
@@ -581,17 +534,14 @@ static __always_inline int charge_slab_page(struct =
page *page,
 					    gfp_t gfp, int order,
 					    struct kmem_cache *s)
 {
-#ifdef CONFIG_MEMCG_KMEM
 	if (memcg_kmem_enabled() && !is_root_cache(s)) {
 		int ret;
=20
 		ret =3D memcg_alloc_page_obj_cgroups(page, s, gfp);
 		if (ret)
 			return ret;
-
-		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
 	}
-#endif
+
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
 	return 0;
@@ -600,12 +550,9 @@ static __always_inline int charge_slab_page(struct p=
age *page,
 static __always_inline void uncharge_slab_page(struct page *page, int or=
der,
 					       struct kmem_cache *s)
 {
-#ifdef CONFIG_MEMCG_KMEM
-	if (memcg_kmem_enabled() && !is_root_cache(s)) {
+	if (memcg_kmem_enabled() && !is_root_cache(s))
 		memcg_free_page_obj_cgroups(page);
-		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
-	}
-#endif
+
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
 }
@@ -748,9 +695,6 @@ static inline struct kmem_cache_node *get_node(struct=
 kmem_cache *s, int node)
 void *slab_start(struct seq_file *m, loff_t *pos);
 void *slab_next(struct seq_file *m, void *p, loff_t *pos);
 void slab_stop(struct seq_file *m, void *p);
-void *memcg_slab_start(struct seq_file *m, loff_t *pos);
-void *memcg_slab_next(struct seq_file *m, void *p, loff_t *pos);
-void memcg_slab_stop(struct seq_file *m, void *p);
 int memcg_slab_show(struct seq_file *m, void *p);
=20
 #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 42edfa46fee6..90c25c8db1a5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -131,141 +131,36 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, =
gfp_t flags, size_t nr,
 #ifdef CONFIG_MEMCG_KMEM
=20
 LIST_HEAD(slab_root_caches);
-static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
-
-static void kmemcg_cache_shutdown(struct percpu_ref *percpu_ref);
=20
 void slab_init_memcg_params(struct kmem_cache *s)
 {
 	s->memcg_params.root_cache =3D NULL;
-	RCU_INIT_POINTER(s->memcg_params.memcg_caches, NULL);
-	INIT_LIST_HEAD(&s->memcg_params.children);
-	s->memcg_params.dying =3D false;
+	s->memcg_params.memcg_cache =3D NULL;
 }
=20
-static int init_memcg_params(struct kmem_cache *s,
-			     struct kmem_cache *root_cache)
+static void init_memcg_params(struct kmem_cache *s,
+			      struct kmem_cache *root_cache)
 {
-	struct memcg_cache_array *arr;
-
-	if (root_cache) {
-		int ret =3D percpu_ref_init(&s->memcg_params.refcnt,
-					  kmemcg_cache_shutdown,
-					  0, GFP_KERNEL);
-		if (ret)
-			return ret;
-
+	if (root_cache)
 		s->memcg_params.root_cache =3D root_cache;
-		INIT_LIST_HEAD(&s->memcg_params.children_node);
-		INIT_LIST_HEAD(&s->memcg_params.kmem_caches_node);
-		return 0;
-	}
-
-	slab_init_memcg_params(s);
-
-	if (!memcg_nr_cache_ids)
-		return 0;
-
-	arr =3D kvzalloc(sizeof(struct memcg_cache_array) +
-		       memcg_nr_cache_ids * sizeof(void *),
-		       GFP_KERNEL);
-	if (!arr)
-		return -ENOMEM;
-
-	RCU_INIT_POINTER(s->memcg_params.memcg_caches, arr);
-	return 0;
-}
-
-static void destroy_memcg_params(struct kmem_cache *s)
-{
-	if (is_root_cache(s)) {
-		kvfree(rcu_access_pointer(s->memcg_params.memcg_caches));
-	} else {
-		mem_cgroup_put(s->memcg_params.memcg);
-		WRITE_ONCE(s->memcg_params.memcg, NULL);
-		percpu_ref_exit(&s->memcg_params.refcnt);
-	}
-}
-
-static void free_memcg_params(struct rcu_head *rcu)
-{
-	struct memcg_cache_array *old;
-
-	old =3D container_of(rcu, struct memcg_cache_array, rcu);
-	kvfree(old);
-}
-
-static int update_memcg_params(struct kmem_cache *s, int new_array_size)
-{
-	struct memcg_cache_array *old, *new;
-
-	new =3D kvzalloc(sizeof(struct memcg_cache_array) +
-		       new_array_size * sizeof(void *), GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	old =3D rcu_dereference_protected(s->memcg_params.memcg_caches,
-					lockdep_is_held(&slab_mutex));
-	if (old)
-		memcpy(new->entries, old->entries,
-		       memcg_nr_cache_ids * sizeof(void *));
-
-	rcu_assign_pointer(s->memcg_params.memcg_caches, new);
-	if (old)
-		call_rcu(&old->rcu, free_memcg_params);
-	return 0;
-}
-
-int memcg_update_all_caches(int num_memcgs)
-{
-	struct kmem_cache *s;
-	int ret =3D 0;
-
-	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
-		ret =3D update_memcg_params(s, num_memcgs);
-		/*
-		 * Instead of freeing the memory, we'll just leave the caches
-		 * up to this point in an updated state.
-		 */
-		if (ret)
-			break;
-	}
-	mutex_unlock(&slab_mutex);
-	return ret;
+	else
+		slab_init_memcg_params(s);
 }
=20
-void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg)
+void memcg_link_cache(struct kmem_cache *s)
 {
-	if (is_root_cache(s)) {
+	if (is_root_cache(s))
 		list_add(&s->root_caches_node, &slab_root_caches);
-	} else {
-		css_get(&memcg->css);
-		s->memcg_params.memcg =3D memcg;
-		list_add(&s->memcg_params.children_node,
-			 &s->memcg_params.root_cache->memcg_params.children);
-		list_add(&s->memcg_params.kmem_caches_node,
-			 &s->memcg_params.memcg->kmem_caches);
-	}
 }
=20
 static void memcg_unlink_cache(struct kmem_cache *s)
 {
-	if (is_root_cache(s)) {
+	if (is_root_cache(s))
 		list_del(&s->root_caches_node);
-	} else {
-		list_del(&s->memcg_params.children_node);
-		list_del(&s->memcg_params.kmem_caches_node);
-	}
 }
 #else
-static inline int init_memcg_params(struct kmem_cache *s,
-				    struct kmem_cache *root_cache)
-{
-	return 0;
-}
-
-static inline void destroy_memcg_params(struct kmem_cache *s)
+static inline void init_memcg_params(struct kmem_cache *s,
+				     struct kmem_cache *root_cache)
 {
 }
=20
@@ -380,7 +275,7 @@ static struct kmem_cache *create_cache(const char *na=
me,
 		unsigned int object_size, unsigned int align,
 		slab_flags_t flags, unsigned int useroffset,
 		unsigned int usersize, void (*ctor)(void *),
-		struct mem_cgroup *memcg, struct kmem_cache *root_cache)
+		struct kmem_cache *root_cache)
 {
 	struct kmem_cache *s;
 	int err;
@@ -400,24 +295,20 @@ static struct kmem_cache *create_cache(const char *=
name,
 	s->useroffset =3D useroffset;
 	s->usersize =3D usersize;
=20
-	err =3D init_memcg_params(s, root_cache);
-	if (err)
-		goto out_free_cache;
-
+	init_memcg_params(s, root_cache);
 	err =3D __kmem_cache_create(s, flags);
 	if (err)
 		goto out_free_cache;
=20
 	s->refcount =3D 1;
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s, memcg);
+	memcg_link_cache(s);
 out:
 	if (err)
 		return ERR_PTR(err);
 	return s;
=20
 out_free_cache:
-	destroy_memcg_params(s);
 	kmem_cache_free(kmem_cache, s);
 	goto out;
 }
@@ -504,7 +395,7 @@ kmem_cache_create_usercopy(const char *name,
=20
 	s =3D create_cache(cache_name, size,
 			 calculate_alignment(flags, align, size),
-			 flags, useroffset, usersize, ctor, NULL, NULL);
+			 flags, useroffset, usersize, ctor, NULL);
 	if (IS_ERR(s)) {
 		err =3D PTR_ERR(s);
 		kfree_const(cache_name);
@@ -629,51 +520,27 @@ static int shutdown_cache(struct kmem_cache *s)
=20
 #ifdef CONFIG_MEMCG_KMEM
 /*
- * memcg_create_kmem_cache - Create a cache for a memory cgroup.
- * @memcg: The memory cgroup the new cache is for.
+ * memcg_create_kmem_cache - Create a cache for non-root memory cgroups.
  * @root_cache: The parent of the new cache.
  *
  * This function attempts to create a kmem cache that will serve allocat=
ion
- * requests going from @memcg to @root_cache. The new cache inherits pro=
perties
- * from its parent.
+ * requests going all non-root memory cgroups to @root_cache. The new ca=
che
+ * inherits properties from its parent.
  */
-void memcg_create_kmem_cache(struct mem_cgroup *memcg,
-			     struct kmem_cache *root_cache)
+void memcg_create_kmem_cache(struct kmem_cache *root_cache)
 {
-	static char memcg_name_buf[NAME_MAX + 1]; /* protected by slab_mutex */
-	struct cgroup_subsys_state *css =3D &memcg->css;
-	struct memcg_cache_array *arr;
 	struct kmem_cache *s =3D NULL;
 	char *cache_name;
-	int idx;
=20
 	get_online_cpus();
 	get_online_mems();
=20
 	mutex_lock(&slab_mutex);
=20
-	/*
-	 * The memory cgroup could have been offlined while the cache
-	 * creation work was pending.
-	 */
-	if (memcg->kmem_state !=3D KMEM_ONLINE)
+	if (root_cache->memcg_params.memcg_cache)
 		goto out_unlock;
=20
-	idx =3D memcg_cache_id(memcg);
-	arr =3D rcu_dereference_protected(root_cache->memcg_params.memcg_caches=
,
-					lockdep_is_held(&slab_mutex));
-
-	/*
-	 * Since per-memcg caches are created asynchronously on first
-	 * allocation (see memcg_kmem_get_cache()), several threads can try to
-	 * create the same cache, but only one of them may succeed.
-	 */
-	if (arr->entries[idx])
-		goto out_unlock;
-
-	cgroup_name(css->cgroup, memcg_name_buf, sizeof(memcg_name_buf));
-	cache_name =3D kasprintf(GFP_KERNEL, "%s(%llu:%s)", root_cache->name,
-			       css->serial_nr, memcg_name_buf);
+	cache_name =3D kasprintf(GFP_KERNEL, "%s-memcg", root_cache->name);
 	if (!cache_name)
 		goto out_unlock;
=20
@@ -681,7 +548,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg=
,
 			 root_cache->align,
 			 root_cache->flags & CACHE_CREATE_MASK,
 			 root_cache->useroffset, root_cache->usersize,
-			 root_cache->ctor, memcg, root_cache);
+			 root_cache->ctor, root_cache);
 	/*
 	 * If we could not create a memcg cache, do not complain, because
 	 * that's not critical at all as we can always proceed with the root
@@ -698,7 +565,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg=
,
 	 * initialized.
 	 */
 	smp_wmb();
-	arr->entries[idx] =3D s;
+	root_cache->memcg_params.memcg_cache =3D s;
=20
 out_unlock:
 	mutex_unlock(&slab_mutex);
@@ -707,197 +574,18 @@ void memcg_create_kmem_cache(struct mem_cgroup *me=
mcg,
 	put_online_cpus();
 }
=20
-static void kmemcg_workfn(struct work_struct *work)
-{
-	struct kmem_cache *s =3D container_of(work, struct kmem_cache,
-					    memcg_params.work);
-
-	get_online_cpus();
-	get_online_mems();
-
-	mutex_lock(&slab_mutex);
-	s->memcg_params.work_fn(s);
-	mutex_unlock(&slab_mutex);
-
-	put_online_mems();
-	put_online_cpus();
-}
-
-static void kmemcg_rcufn(struct rcu_head *head)
-{
-	struct kmem_cache *s =3D container_of(head, struct kmem_cache,
-					    memcg_params.rcu_head);
-
-	/*
-	 * We need to grab blocking locks.  Bounce to ->work.  The
-	 * work item shares the space with the RCU head and can't be
-	 * initialized earlier.
-	 */
-	INIT_WORK(&s->memcg_params.work, kmemcg_workfn);
-	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
-}
-
-static void kmemcg_cache_shutdown_fn(struct kmem_cache *s)
-{
-	WARN_ON(shutdown_cache(s));
-}
-
-static void kmemcg_cache_shutdown(struct percpu_ref *percpu_ref)
-{
-	struct kmem_cache *s =3D container_of(percpu_ref, struct kmem_cache,
-					    memcg_params.refcnt);
-	unsigned long flags;
-
-	spin_lock_irqsave(&memcg_kmem_wq_lock, flags);
-	if (s->memcg_params.root_cache->memcg_params.dying)
-		goto unlock;
-
-	s->memcg_params.work_fn =3D kmemcg_cache_shutdown_fn;
-	INIT_WORK(&s->memcg_params.work, kmemcg_workfn);
-	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
-
-unlock:
-	spin_unlock_irqrestore(&memcg_kmem_wq_lock, flags);
-}
-
-static void kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
-{
-	__kmemcg_cache_deactivate_after_rcu(s);
-	percpu_ref_kill(&s->memcg_params.refcnt);
-}
-
-static void kmemcg_cache_deactivate(struct kmem_cache *s)
-{
-	if (WARN_ON_ONCE(is_root_cache(s)))
-		return;
-
-	__kmemcg_cache_deactivate(s);
-	s->flags |=3D SLAB_DEACTIVATED;
-
-	/*
-	 * memcg_kmem_wq_lock is used to synchronize memcg_params.dying
-	 * flag and make sure that no new kmem_cache deactivation tasks
-	 * are queued (see flush_memcg_workqueue() ).
-	 */
-	spin_lock_irq(&memcg_kmem_wq_lock);
-	if (s->memcg_params.root_cache->memcg_params.dying)
-		goto unlock;
-
-	s->memcg_params.work_fn =3D kmemcg_cache_deactivate_after_rcu;
-	call_rcu(&s->memcg_params.rcu_head, kmemcg_rcufn);
-unlock:
-	spin_unlock_irq(&memcg_kmem_wq_lock);
-}
-
-void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg,
-				  struct mem_cgroup *parent)
-{
-	int idx;
-	struct memcg_cache_array *arr;
-	struct kmem_cache *s, *c;
-	unsigned int nr_reparented;
-
-	idx =3D memcg_cache_id(memcg);
-
-	get_online_cpus();
-	get_online_mems();
-
-	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
-		arr =3D rcu_dereference_protected(s->memcg_params.memcg_caches,
-						lockdep_is_held(&slab_mutex));
-		c =3D arr->entries[idx];
-		if (!c)
-			continue;
-
-		kmemcg_cache_deactivate(c);
-		arr->entries[idx] =3D NULL;
-	}
-	nr_reparented =3D 0;
-	list_for_each_entry(s, &memcg->kmem_caches,
-			    memcg_params.kmem_caches_node) {
-		WRITE_ONCE(s->memcg_params.memcg, parent);
-		css_put(&memcg->css);
-		nr_reparented++;
-	}
-	if (nr_reparented) {
-		list_splice_init(&memcg->kmem_caches,
-				 &parent->kmem_caches);
-		css_get_many(&parent->css, nr_reparented);
-	}
-	mutex_unlock(&slab_mutex);
-
-	put_online_mems();
-	put_online_cpus();
-}
-
 static int shutdown_memcg_caches(struct kmem_cache *s)
 {
-	struct memcg_cache_array *arr;
-	struct kmem_cache *c, *c2;
-	LIST_HEAD(busy);
-	int i;
-
 	BUG_ON(!is_root_cache(s));
=20
-	/*
-	 * First, shutdown active caches, i.e. caches that belong to online
-	 * memory cgroups.
-	 */
-	arr =3D rcu_dereference_protected(s->memcg_params.memcg_caches,
-					lockdep_is_held(&slab_mutex));
-	for_each_memcg_cache_index(i) {
-		c =3D arr->entries[i];
-		if (!c)
-			continue;
-		if (shutdown_cache(c))
-			/*
-			 * The cache still has objects. Move it to a temporary
-			 * list so as not to try to destroy it for a second
-			 * time while iterating over inactive caches below.
-			 */
-			list_move(&c->memcg_params.children_node, &busy);
-		else
-			/*
-			 * The cache is empty and will be destroyed soon. Clear
-			 * the pointer to it in the memcg_caches array so that
-			 * it will never be accessed even if the root cache
-			 * stays alive.
-			 */
-			arr->entries[i] =3D NULL;
-	}
-
-	/*
-	 * Second, shutdown all caches left from memory cgroups that are now
-	 * offline.
-	 */
-	list_for_each_entry_safe(c, c2, &s->memcg_params.children,
-				 memcg_params.children_node)
-		shutdown_cache(c);
-
-	list_splice(&busy, &s->memcg_params.children);
+	if (s->memcg_params.memcg_cache)
+		WARN_ON(shutdown_cache(s->memcg_params.memcg_cache));
=20
-	/*
-	 * A cache being destroyed must be empty. In particular, this means
-	 * that all per memcg caches attached to it must be empty too.
-	 */
-	if (!list_empty(&s->memcg_params.children))
-		return -EBUSY;
 	return 0;
 }
=20
 static void flush_memcg_workqueue(struct kmem_cache *s)
 {
-	spin_lock_irq(&memcg_kmem_wq_lock);
-	s->memcg_params.dying =3D true;
-	spin_unlock_irq(&memcg_kmem_wq_lock);
-
-	/*
-	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
-	 * sure all registered rcu callbacks have been invoked.
-	 */
-	rcu_barrier();
-
 	/*
 	 * SLAB and SLUB create memcg kmem_caches through workqueue and SLUB
 	 * deactivates the memcg kmem_caches through workqueue. Make sure all
@@ -905,18 +593,6 @@ static void flush_memcg_workqueue(struct kmem_cache =
*s)
 	 */
 	if (likely(memcg_kmem_cache_wq))
 		flush_workqueue(memcg_kmem_cache_wq);
-
-	/*
-	 * If we're racing with children kmem_cache deactivation, it might
-	 * take another rcu grace period to complete their destruction.
-	 * At this moment the corresponding percpu_ref_kill() call should be
-	 * done, but it might take another rcu grace period to complete
-	 * switching to the atomic mode.
-	 * Please, note that we check without grabbing the slab_mutex. It's saf=
e
-	 * because at this moment the children list can't grow.
-	 */
-	if (!list_empty(&s->memcg_params.children))
-		rcu_barrier();
 }
 #else
 static inline int shutdown_memcg_caches(struct kmem_cache *s)
@@ -932,7 +608,6 @@ static inline void flush_memcg_workqueue(struct kmem_=
cache *s)
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
-	destroy_memcg_params(s);
 	kfree_const(s->name);
 	kmem_cache_free(kmem_cache, s);
 }
@@ -996,7 +671,7 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 EXPORT_SYMBOL(kmem_cache_shrink);
=20
 /**
- * kmem_cache_shrink_all - shrink a cache and all memcg caches for root =
cache
+ * kmem_cache_shrink_all - shrink root and memcg caches
  * @s: The cache pointer
  */
 void kmem_cache_shrink_all(struct kmem_cache *s)
@@ -1013,21 +688,11 @@ void kmem_cache_shrink_all(struct kmem_cache *s)
 	kasan_cache_shrink(s);
 	__kmem_cache_shrink(s);
=20
-	/*
-	 * We have to take the slab_mutex to protect from the memcg list
-	 * modification.
-	 */
-	mutex_lock(&slab_mutex);
-	for_each_memcg_cache(c, s) {
-		/*
-		 * Don't need to shrink deactivated memcg caches.
-		 */
-		if (s->flags & SLAB_DEACTIVATED)
-			continue;
+	c =3D memcg_cache(s);
+	if (c) {
 		kasan_cache_shrink(c);
 		__kmem_cache_shrink(c);
 	}
-	mutex_unlock(&slab_mutex);
 	put_online_mems();
 	put_online_cpus();
 }
@@ -1082,7 +747,7 @@ struct kmem_cache *__init create_kmalloc_cache(const=
 char *name,
=20
 	create_boot_cache(s, name, size, flags, useroffset, usersize);
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s, NULL);
+	memcg_link_cache(s);
 	s->refcount =3D 1;
 	return s;
 }
@@ -1445,7 +1110,8 @@ memcg_accumulate_slabinfo(struct kmem_cache *s, str=
uct slabinfo *info)
 	if (!is_root_cache(s))
 		return;
=20
-	for_each_memcg_cache(c, s) {
+	c =3D memcg_cache(s);
+	if (c) {
 		memset(&sinfo, 0, sizeof(sinfo));
 		get_slabinfo(c, &sinfo);
=20
@@ -1576,7 +1242,7 @@ module_init(slab_proc_init);
=20
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_MEMCG_KMEM)
 /*
- * Display information about kmem caches that have child memcg caches.
+ * Display information about kmem caches that have memcg cache.
  */
 static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 {
@@ -1588,9 +1254,9 @@ static int memcg_slabinfo_show(struct seq_file *m, =
void *unused)
 	seq_puts(m, " <active_slabs> <num_slabs>\n");
 	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
 		/*
-		 * Skip kmem caches that don't have any memcg children.
+		 * Skip kmem caches that don't have the memcg cache.
 		 */
-		if (list_empty(&s->memcg_params.children))
+		if (!s->memcg_params.memcg_cache)
 			continue;
=20
 		memset(&sinfo, 0, sizeof(sinfo));
@@ -1599,23 +1265,13 @@ static int memcg_slabinfo_show(struct seq_file *m=
, void *unused)
 			   cache_name(s), sinfo.active_objs, sinfo.num_objs,
 			   sinfo.active_slabs, sinfo.num_slabs);
=20
-		for_each_memcg_cache(c, s) {
-			struct cgroup_subsys_state *css;
-			char *status =3D "";
-
-			css =3D &c->memcg_params.memcg->css;
-			if (!(css->flags & CSS_ONLINE))
-				status =3D ":dead";
-			else if (c->flags & SLAB_DEACTIVATED)
-				status =3D ":deact";
-
-			memset(&sinfo, 0, sizeof(sinfo));
-			get_slabinfo(c, &sinfo);
-			seq_printf(m, "%-17s %4d%-6s %6lu %6lu %6lu %6lu\n",
-				   cache_name(c), css->id, status,
-				   sinfo.active_objs, sinfo.num_objs,
-				   sinfo.active_slabs, sinfo.num_slabs);
-		}
+		c =3D s->memcg_params.memcg_cache;
+		memset(&sinfo, 0, sizeof(sinfo));
+		get_slabinfo(c, &sinfo);
+		seq_printf(m, "%-17s %4d %6lu %6lu %6lu %6lu\n",
+			   cache_name(c), root_mem_cgroup->css.id,
+			   sinfo.active_objs, sinfo.num_objs,
+			   sinfo.active_slabs, sinfo.num_slabs);
 	}
 	mutex_unlock(&slab_mutex);
 	return 0;
diff --git a/mm/slub.c b/mm/slub.c
index 25810980a26c..91a1dce932e9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4208,36 +4208,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	return ret;
 }
=20
-#ifdef CONFIG_MEMCG
-void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
-{
-	/*
-	 * Called with all the locks held after a sched RCU grace period.
-	 * Even if @s becomes empty after shrinking, we can't know that @s
-	 * doesn't have allocations already in-flight and thus can't
-	 * destroy @s until the associated memcg is released.
-	 *
-	 * However, let's remove the sysfs files for empty caches here.
-	 * Each cache has a lot of interface files which aren't
-	 * particularly useful for empty draining caches; otherwise, we can
-	 * easily end up with millions of unnecessary sysfs files on
-	 * systems which have a lot of memory and transient cgroups.
-	 */
-	if (!__kmem_cache_shrink(s))
-		sysfs_slab_remove(s);
-}
-
-void __kmemcg_cache_deactivate(struct kmem_cache *s)
-{
-	/*
-	 * Disable empty slabs caching. Used to avoid pinning offline
-	 * memory cgroups by kmem pages that can be freed.
-	 */
-	slub_set_cpu_partial(s, 0);
-	s->min_partial =3D 0;
-}
-#endif	/* CONFIG_MEMCG */
-
 static int slab_mem_going_offline_callback(void *arg)
 {
 	struct kmem_cache *s;
@@ -4394,7 +4364,7 @@ static struct kmem_cache * __init bootstrap(struct =
kmem_cache *static_cache)
 	}
 	slab_init_memcg_params(s);
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s, NULL);
+	memcg_link_cache(s);
 	return s;
 }
=20
@@ -4462,7 +4432,8 @@ __kmem_cache_alias(const char *name, unsigned int s=
ize, unsigned int align,
 		s->object_size =3D max(s->object_size, size);
 		s->inuse =3D max(s->inuse, ALIGN(size, sizeof(void *)));
=20
-		for_each_memcg_cache(c, s) {
+		c =3D memcg_cache(s);
+		if (c) {
 			c->object_size =3D s->object_size;
 			c->inuse =3D max(c->inuse, ALIGN(size, sizeof(void *)));
 		}
@@ -5595,7 +5566,8 @@ static ssize_t slab_attr_store(struct kobject *kobj=
,
 		 * directly either failed or succeeded, in which case we loop
 		 * through the descendants with best-effort propagation.
 		 */
-		for_each_memcg_cache(c, s)
+		c =3D memcg_cache(s);
+		if (c)
 			attribute->store(c, buf, len);
 		mutex_unlock(&slab_mutex);
 	}
--=20
2.26.2

