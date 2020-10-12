Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CE28B1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJLKJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:09:03 -0400
Received: from smtp.h3c.com ([60.191.123.50]:9658 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLKJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:09:02 -0400
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 09C8bpnN040015
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 16:37:51 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 09C8bNxa039088
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 16:37:23 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 16:37:25 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kuba@kernel.org>, <alexei.starovoitov@gmail.com>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] mm: Make allocator take care of memoryless numa node
Date:   Mon, 12 Oct 2020 16:27:39 +0800
Message-ID: <20201012082739.15661-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09C8bNxa039088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In architecture like powerpc, we can have cpus without any local memory
attached to it. In such cases the node does not have real memory.

In many places of current kernel code, it doesn't judge whether the node is
memoryless numa node before calling allocator interface.

This patch is to use local_memory_node(), which is guaranteed to have
memory, in allocator interface. local_memory_node() is a noop in other
architectures that don't support memoryless nodes.

As the call path:
	alloc_pages_node
	    __alloc_pages_node
	        __alloc_pages_nodemask
and __alloc_pages_node,__alloc_pages_nodemask may be called directly,
so only add local_memory_node() in __alloc_pages_nodemask.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 include/linux/slab.h |  3 +++
 mm/page_alloc.c      |  1 +
 mm/slab.c            |  6 +++++-
 mm/slob.c            |  1 +
 mm/slub.c            | 10 ++++++++--
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 24df2393e..527e811e0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -574,6 +574,7 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 						flags, node, size);
 	}
 #endif
+	node = local_memory_node(node);
 	return __kmalloc_node(size, flags, node);
 }
 
@@ -626,6 +627,8 @@ static inline void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node(bytes, flags, node);
+
+	node = local_memory_node(node);
 	return __kmalloc_node(bytes, flags, node);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6866533de..be63c62c2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4878,6 +4878,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 		return NULL;
 	}
 
+	preferred_nid = local_memory_node(preferred_nid);
 	gfp_mask &= gfp_allowed_mask;
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
diff --git a/mm/slab.c b/mm/slab.c
index f658e86ec..263c2f2e1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3575,7 +3575,10 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
  */
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
-	void *ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
+	void *ret;
+
+	nodeid = local_memory_node(nodeid);
+	ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    cachep->object_size, cachep->size,
@@ -3593,6 +3596,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 {
 	void *ret;
 
+	nodeid = local_memory_node(nodeid);
 	ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
diff --git a/mm/slob.c b/mm/slob.c
index 7cc9805c8..1f1c25e06 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -636,6 +636,7 @@ EXPORT_SYMBOL(__kmalloc_node);
 
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
 {
+	node = local_memory_node(node);
 	return slob_alloc_node(cachep, gfp, node);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
diff --git a/mm/slub.c b/mm/slub.c
index 6d3574013..6e5e12b04 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2921,7 +2921,10 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
+	void *ret;
+
+	node = local_memory_node(node);
+	ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    s->object_size, s->size, gfpflags, node);
@@ -2935,7 +2938,10 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 				    gfp_t gfpflags,
 				    int node, size_t size)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
+	void *ret;
+
+	node = local_memory_node(node);
+	ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
 
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
-- 
2.17.1

