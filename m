Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB31F3125
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 03:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgFIBGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 21:06:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727814AbgFHXHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:11 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 058N1EGh014989
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jun 2020 16:07:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0GRv7/FjIV45yckRWFT6XboefWHUkGSwTLpy6bwNA1o=;
 b=hBvrxI4RoqjYWiydZBE2ZTxHgMNI8/u/3zxqqkHg0jixg6VdBu7kMVlE53x8N2hTsbyO
 436YGTOJP4MdsrHur3pK4PL3ElTJbM+64LqGjX5ACT0JtRe2IE/Lu8BjDr4VwO2QOKC6
 WRfBYE6sDTK5bo7tu8mdPbIhhO2b7lF72u4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 31g6mx2f1e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:07:10 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 16:07:08 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 672BA1D8FE54; Mon,  8 Jun 2020 16:07:00 -0700 (PDT)
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
Subject: [PATCH v6 13/19] mm: memcg/slab: simplify memcg cache creation
Date:   Mon, 8 Jun 2020 16:06:48 -0700
Message-ID: <20200608230654.828134-14-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=2 impostorscore=0 adultscore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the number of non-root kmem_caches doesn't depend on the
number of memory cgroups anymore and is generally not very big,
there is no more need for a dedicated workqueue.

Also, as there is no more need to pass any arguments to the
memcg_create_kmem_cache() except the root kmem_cache, it's
possible to just embed the work structure into the kmem_cache
and avoid the dynamic allocation of the work structure.

This will also simplify the synchronization: for each root kmem_cache
there is only one work. So there will be no more concurrent attempts
to create a non-root kmem_cache for a root kmem_cache: the second and
all following attempts to queue the work will fail.

On the kmem_cache destruction path there is no more need to call the
expensive flush_workqueue() and wait for all pending works to be
finished. Instead, cancel_work_sync() can be used to cancel/wait for
only one work.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h |  1 -
 mm/memcontrol.c            | 48 +-------------------------------------
 mm/slab.h                  |  2 ++
 mm/slab_common.c           | 22 +++++++++--------
 4 files changed, 15 insertions(+), 58 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e2c4d54aa1f6..ed0d2ac6a5d2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1418,7 +1418,6 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp=
_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
=20
 extern struct static_key_false memcg_kmem_enabled_key;
-extern struct workqueue_struct *memcg_kmem_cache_wq;
=20
 extern int memcg_nr_cache_ids;
 void memcg_get_cache_ids(void);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 995204f65217..2695cdc15baa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -399,8 +399,6 @@ void memcg_put_cache_ids(void)
  */
 DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
 EXPORT_SYMBOL(memcg_kmem_enabled_key);
-
-struct workqueue_struct *memcg_kmem_cache_wq;
 #endif
=20
 static int memcg_shrinker_map_size;
@@ -2902,39 +2900,6 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
=20
-struct memcg_kmem_cache_create_work {
-	struct kmem_cache *cachep;
-	struct work_struct work;
-};
-
-static void memcg_kmem_cache_create_func(struct work_struct *w)
-{
-	struct memcg_kmem_cache_create_work *cw =3D
-		container_of(w, struct memcg_kmem_cache_create_work, work);
-	struct kmem_cache *cachep =3D cw->cachep;
-
-	memcg_create_kmem_cache(cachep);
-
-	kfree(cw);
-}
-
-/*
- * Enqueue the creation of a per-memcg kmem_cache.
- */
-static void memcg_schedule_kmem_cache_create(struct kmem_cache *cachep)
-{
-	struct memcg_kmem_cache_create_work *cw;
-
-	cw =3D kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
-	if (!cw)
-		return;
-
-	cw->cachep =3D cachep;
-	INIT_WORK(&cw->work, memcg_kmem_cache_create_func);
-
-	queue_work(memcg_kmem_cache_wq, &cw->work);
-}
-
 /**
  * memcg_kmem_get_cache: select memcg or root cache for allocation
  * @cachep: the original global kmem cache
@@ -2951,7 +2916,7 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem=
_cache *cachep)
=20
 	memcg_cachep =3D READ_ONCE(cachep->memcg_params.memcg_cache);
 	if (unlikely(!memcg_cachep)) {
-		memcg_schedule_kmem_cache_create(cachep);
+		queue_work(system_wq, &cachep->memcg_params.work);
 		return cachep;
 	}
=20
@@ -7062,17 +7027,6 @@ static int __init mem_cgroup_init(void)
 {
 	int cpu, node;
=20
-#ifdef CONFIG_MEMCG_KMEM
-	/*
-	 * Kmem cache creation is mostly done with the slab_mutex held,
-	 * so use a workqueue with limited concurrency to avoid stalling
-	 * all worker threads in case lots of cgroups are created and
-	 * destroyed simultaneously.
-	 */
-	memcg_kmem_cache_wq =3D alloc_workqueue("memcg_kmem_cache", 0, 1);
-	BUG_ON(!memcg_kmem_cache_wq);
-#endif
-
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
=20
diff --git a/mm/slab.h b/mm/slab.h
index 8f8552df5675..c6c7987dfd85 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -45,12 +45,14 @@ struct kmem_cache {
  * @memcg_cache: pointer to memcg kmem cache, used by all non-root memor=
y
  *		cgroups.
  * @root_caches_node: list node for slab_root_caches list.
+ * @work: work struct used to create the non-root cache.
  */
 struct memcg_cache_params {
 	struct kmem_cache *root_cache;
=20
 	struct kmem_cache *memcg_cache;
 	struct list_head __root_caches_node;
+	struct work_struct work;
 };
 #endif /* CONFIG_SLOB */
=20
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e9deaafddbb6..10aa2acb84ca 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -132,10 +132,18 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t nr,
=20
 LIST_HEAD(slab_root_caches);
=20
+static void memcg_kmem_cache_create_func(struct work_struct *work)
+{
+	struct kmem_cache *cachep =3D container_of(work, struct kmem_cache,
+						 memcg_params.work);
+	memcg_create_kmem_cache(cachep);
+}
+
 void slab_init_memcg_params(struct kmem_cache *s)
 {
 	s->memcg_params.root_cache =3D NULL;
 	s->memcg_params.memcg_cache =3D NULL;
+	INIT_WORK(&s->memcg_params.work, memcg_kmem_cache_create_func);
 }
=20
 static void init_memcg_params(struct kmem_cache *s,
@@ -584,15 +592,9 @@ static int shutdown_memcg_caches(struct kmem_cache *=
s)
 	return 0;
 }
=20
-static void flush_memcg_workqueue(struct kmem_cache *s)
+static void cancel_memcg_cache_creation(struct kmem_cache *s)
 {
-	/*
-	 * SLAB and SLUB create memcg kmem_caches through workqueue and SLUB
-	 * deactivates the memcg kmem_caches through workqueue. Make sure all
-	 * previous workitems on workqueue are processed.
-	 */
-	if (likely(memcg_kmem_cache_wq))
-		flush_workqueue(memcg_kmem_cache_wq);
+	cancel_work_sync(&s->memcg_params.work);
 }
 #else
 static inline int shutdown_memcg_caches(struct kmem_cache *s)
@@ -600,7 +602,7 @@ static inline int shutdown_memcg_caches(struct kmem_c=
ache *s)
 	return 0;
 }
=20
-static inline void flush_memcg_workqueue(struct kmem_cache *s)
+static inline void cancel_memcg_cache_creation(struct kmem_cache *s)
 {
 }
 #endif /* CONFIG_MEMCG_KMEM */
@@ -619,7 +621,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
=20
-	flush_memcg_workqueue(s);
+	cancel_memcg_cache_creation(s);
=20
 	get_online_cpus();
 	get_online_mems();
--=20
2.25.4

