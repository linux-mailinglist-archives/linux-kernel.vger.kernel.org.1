Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16D2F4C24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbhAMNRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:17:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbhAMNR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:17:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6052B806;
        Wed, 13 Jan 2021 13:16:44 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/3] mm, slab, slub: stop taking memory hotplug lock
Date:   Wed, 13 Jan 2021 14:16:33 +0100
Message-Id: <20210113131634.3671-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113131634.3671-1-vbabka@suse.cz>
References: <20210113131634.3671-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 03afc0e25f7f ("slab: get_online_mems for
kmem_cache_{create,destroy,shrink}") we are taking memory hotplug lock for SLAB
and SLUB when creating, destroying or shrinking a cache. It is quite a heavy
lock and it's best to avoid it if possible, as we had several issues with
lockdep complaining about ordering in the past, see e.g. e4f8e513c3d3
("mm/slub: fix a deadlock in show_slab_objects()").

The problem scenario in 03afc0e25f7f (solved by the memory hotplug lock) can be
summarized as follows: while there's slab_mutex synchronizing new kmem cache
creation and SLUB's MEM_GOING_ONLINE callback slab_mem_going_online_callback(),
we may miss creation of kmem_cache_node for the hotplugged node in the new kmem
cache, because the hotplug callback doesn't yet see the new cache, and cache
creation in init_kmem_cache_nodes() only inits kmem_cache_node for nodes in the
N_NORMAL_MEMORY nodemask, which however may not yet include the new node, as
that happens only later after the MEM_GOING_ONLINE callback.

Instead of using get/put_online_mems(), the problem can be solved by SLUB
maintaining its own nodemask of nodes for which it has allocated the per-node
kmem_cache_node structures. This nodemask would generally mirror the
N_NORMAL_MEMORY nodemask, but would be updated only in under SLUB's control in
its memory hotplug callbacks under the slab_mutex. This patch adds such
nodemask and its handling.

Commit 03afc0e25f7f mentiones "issues like [the one above]", but there don't
appear to be further issues. All the paths (shared for SLAB and SLUB) taking
the memory hotplug locks are also taking the slab_mutex, except
kmem_cache_shrink() where 03afc0e25f7f replaced slab_mutex with
get/put_online_mems().

We however cannot simply restore slab_mutex in kmem_cache_shrink(), as SLUB can
enters the function from a write to sysfs 'shrink' file, thus holding kernfs
lock, and in kmem_cache_create() the kernfs lock is nested within slab_mutex.
But on closer inspection we don't actually need to protect kmem_cache_shrink()
from hotplug callbacks: While SLUB's __kmem_cache_shrink() does
for_each_kmem_cache_node(), missing a new node added in parallel hotplug is not
fatal, and parallel hotremove does not free kmem_cache_node's anymore after the
previous patch, so use-after free cannot happen. The per-node shrinking itself
is protected by n->list_lock. Same is true for SLAB, and SLOB is no-op.

SLAB also doesn't need the memory hotplug locking, which it only gained by
03afc0e25f7f through the shared paths in slab_common.c. Its memory hotplug
callbacks are also protected by slab_mutex against races with these paths. The
problem of SLUB relying on N_NORMAL_MEMORY doesn't apply to SLAB, as its
setup_kmem_cache_nodes relies on N_ONLINE, and the new node is already set
there during the MEM_GOING_ONLINE callback, so no special care is needed
for SLAB.

As such, this patch removes all get/put_online_mems() usage by the slab
subsystem.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c |  8 ++------
 mm/slub.c        | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d5986ebb84ea..e040b3820a75 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -311,7 +311,6 @@ kmem_cache_create_usercopy(const char *name,
 	int err;
 
 	get_online_cpus();
-	get_online_mems();
 
 	mutex_lock(&slab_mutex);
 
@@ -361,7 +360,6 @@ kmem_cache_create_usercopy(const char *name,
 out_unlock:
 	mutex_unlock(&slab_mutex);
 
-	put_online_mems();
 	put_online_cpus();
 
 	if (err) {
@@ -490,7 +488,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		return;
 
 	get_online_cpus();
-	get_online_mems();
 
 	mutex_lock(&slab_mutex);
 
@@ -507,7 +504,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 out_unlock:
 	mutex_unlock(&slab_mutex);
 
-	put_online_mems();
 	put_online_cpus();
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
@@ -526,10 +522,10 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 	int ret;
 
 	get_online_cpus();
-	get_online_mems();
+
 	kasan_cache_shrink(cachep);
 	ret = __kmem_cache_shrink(cachep);
-	put_online_mems();
+
 	put_online_cpus();
 	return ret;
 }
diff --git a/mm/slub.c b/mm/slub.c
index 0d01a893cb64..0d4bdf6783ee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -236,6 +236,14 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
 #endif
 }
 
+/*
+ * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
+ * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
+ * differ during memory hotplug/hotremove operations.
+ * Protected by slab_mutex.
+ */
+static nodemask_t slab_nodes;
+
 /********************************************************************
  * 			Core slab cache functions
  *******************************************************************/
@@ -2678,7 +2686,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 * ignore the node constraint
 		 */
 		if (unlikely(node != NUMA_NO_NODE &&
-			     !node_state(node, N_NORMAL_MEMORY)))
+			     !node_isset(node, slab_nodes)))
 			node = NUMA_NO_NODE;
 		goto new_slab;
 	}
@@ -2689,7 +2697,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 * same as above but node_match() being false already
 		 * implies node != NUMA_NO_NODE
 		 */
-		if (!node_state(node, N_NORMAL_MEMORY)) {
+		if (!node_isset(node, slab_nodes)) {
 			node = NUMA_NO_NODE;
 			goto redo;
 		} else {
@@ -3599,7 +3607,7 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 {
 	int node;
 
-	for_each_node_state(node, N_NORMAL_MEMORY) {
+	for_each_node_mask(node, slab_nodes) {
 		struct kmem_cache_node *n;
 
 		if (slab_state == DOWN) {
@@ -4299,6 +4307,7 @@ static void slab_mem_offline_callback(void *arg)
 		return;
 
 	mutex_lock(&slab_mutex);
+	node_clear(offline_node, slab_nodes);
 	/*
 	 * We no longer free kmem_cache_node structures here, as it would be
 	 * racy with all get_node() users, and infeasible to protect them with
@@ -4348,6 +4357,11 @@ static int slab_mem_going_online_callback(void *arg)
 		init_kmem_cache_node(n);
 		s->node[nid] = n;
 	}
+	/*
+	 * Any cache created after this point will also have kmem_cache_node
+	 * initialized for the new node.
+	 */
+	node_set(nid, slab_nodes);
 out:
 	mutex_unlock(&slab_mutex);
 	return ret;
@@ -4428,6 +4442,7 @@ void __init kmem_cache_init(void)
 {
 	static __initdata struct kmem_cache boot_kmem_cache,
 		boot_kmem_cache_node;
+	int node;
 
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
@@ -4435,6 +4450,13 @@ void __init kmem_cache_init(void)
 	kmem_cache_node = &boot_kmem_cache_node;
 	kmem_cache = &boot_kmem_cache;
 
+	/*
+	 * Initialize the nodemask for which we will allocate per node
+	 * structures. Here we don't need taking slab_mutex yet.
+	 */
+	for_each_node_state(node, N_NORMAL_MEMORY)
+		node_set(node, slab_nodes);
+
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
 		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
 
-- 
2.29.2

