Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278B62EC288
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbhAFRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:41:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:43858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbhAFRlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:41:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A436ADD6;
        Wed,  6 Jan 2021 17:40:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 3/3] mm, slub: stop freeing kmem_cache_node structures on node offline
Date:   Wed,  6 Jan 2021 18:40:29 +0100
Message-Id: <20210106174029.12654-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106174029.12654-1-vbabka@suse.cz>
References: <20210106174029.12654-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e4f8e513c3d3 ("mm/slub: fix a deadlock in show_slab_objects()") has
fixed a problematic locking order by removing the memory hotplug lock
get/put_online_mems() from show_slab_objects(). During the discussion, it was
argued [1] that this is OK, because existing slabs on the node would prevent
a hotremove to proceed.

That's true, but per-node kmem_cache_node structures are not necessarily
allocated on the same node and may exist even without actual slab pages
on the same node. Any path that uses get_node() directly or via
for_each_kmem_cache_node() (such as show_slab_objects()) can race with
freeing of kmem_cache_node even with the !NULL check, resulting in
use-after-free.

To that end, commit e4f8e513c3d3 argues in a comment that:

 * We don't really need mem_hotplug_lock (to hold off
 * slab_mem_going_offline_callback) here because slab's memory hot
 * unplug code doesn't destroy the kmem_cache->node[] data.

While it's true that slab_mem_going_offline_callback() doesn't free
the kmem_cache_node, the later callback slab_mem_offline_callback() actually
does, so the race and use-after-free exists. Not just for show_slab_objects()
after commit e4f8e513c3d3, but also many other places that are not under
slab_mutex. And adding slab_mutex locking or other synchronization to SLUB
paths such as get_any_partial() would be bad for performance and error-prone.

The easiest solution is therefore to make the abovementioned comment true and
stop freeing the kmem_cache_node structures, accepting some wasted memory in
the full memory node removal scenario. Analogically we also don't free
hotremoved pgdat as mentioned in [1], nor the similar per-node structures in
SLAB. Importantly this approach will not block the hotremove, as generally such
nodes should be movable in order to succeed hotremove in the first place, and
thus the GFP_KERNEL allocated kmem_cache_node will come from elsewhere.

[1] https://lore.kernel.org/linux-mm/20190924151147.GB23050@dhcp22.suse.cz/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2e2edd5c9cfc..d7c4f08dcf39 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4268,21 +4268,11 @@ static void slab_mem_offline_callback(void *arg)
 
 	mutex_lock(&slab_mutex);
 	node_clear(offline_node, slab_nodes);
-	list_for_each_entry(s, &slab_caches, list) {
-		n = get_node(s, offline_node);
-		if (n) {
-			/*
-			 * if n->nr_slabs > 0, slabs still exist on the node
-			 * that is going down. We were unable to free them,
-			 * and offline_pages() function shouldn't call this
-			 * callback. So, we must fail.
-			 */
-			BUG_ON(slabs_node(s, offline_node));
-
-			s->node[offline_node] = NULL;
-			kmem_cache_free(kmem_cache_node, n);
-		}
-	}
+	/*
+	 * We no longer free kmem_cache_node structures here, as it would be
+	 * racy with all get_node() users, and infeasible to protect them with
+	 * slab_mutex.
+	 */
 	mutex_unlock(&slab_mutex);
 }
 
@@ -4308,6 +4298,12 @@ static int slab_mem_going_online_callback(void *arg)
 	 */
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
+		/*
+		 * The structure may already exist if the node was previously
+		 * onlined and offlined.
+		 */
+		if (get_node(s, nid))
+			continue;
 		/*
 		 * XXX: kmem_cache_alloc_node will fallback to other nodes
 		 *      since memory is not yet available from the node that
-- 
2.29.2

