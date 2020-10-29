Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F268B29ECAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgJ2NRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgJ2NRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:17:12 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:17:12 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id h8so1276584wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZBmbCevgd8bWbMbBJPZrjV9agh6awCGyrsWIFX9Y3FQ=;
        b=HINz8UJbPbP2MJZvE3ngvaX5JnZzMDSIdCNlEr9nKUsQvb+xi6Q0BrviBcr9iyjDu8
         nvi7MDYU/6dzkT18A6r7MOFhhwCp0vcuxPkIvXHT09NmFNTZOHfuld0VYizxf5n7c5nP
         dQUNuUtCP2cx460VXoSiAPUMXoZbnbgXwtbNLL7rERfcyT0l5aLDtbwVvK4qHks4gfCL
         XrA3wTszwqN5R81SbB60Qw9dTO22r1e32ypRYMZYDadIY0wDg99vgLYqaHPqAXx7M2+X
         zLv0nTlJJMtq50KfcCnv29NnttkCa9XqNAahfIkoLDdzjR6JCmGzC6ulp14/E2mbUJly
         ovvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZBmbCevgd8bWbMbBJPZrjV9agh6awCGyrsWIFX9Y3FQ=;
        b=E4Jy0ZOCfRkc5sPvdrAeSe8Jt5E1UsMP+iJm2HArjxsojzMZKpxlsD8e/Hjsu5Ieam
         uOsyBQTYflab+Uf8aHWC0EhHNNe//cFiDVEHM2CNXJsiYMgCXJhP2KwtH+b+Os6XtvKm
         3z/qf9V256e8w/OkAOQfqHKLzLk7lArof/iJftoB09pZP59EnqAsdQtsjSoWRGPI1KLg
         aA22n3n31VbyW/fg/JklJR370VXIUtbjcmLRFDcTAYRMu6GH4tU9+EnZZz8dFEPOZn/n
         aX5AKAhAZthZef+JCyUbTugd6MaQWK+dIlM8dy3gznEA0T56YqyrSGOPLaf0OADGmVMh
         h2RA==
X-Gm-Message-State: AOAM530EW5v6/y0QGUmfHkmwo9wIAlPXKPucYC1Tiyi59YcBayzqg7/Z
        TAR07MDdJkWhoYou9Yd1iS9c6rn/5A==
X-Google-Smtp-Source: ABdhPJy2abgjJH2GSqZCMs/P4MFaViFDIH1h+VcwqvrEv+aR7Sr+ikE1h6MleIgwhaaTTjFOpOrnt9hBhQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:b783:: with SMTP id h125mr2098392wmf.108.1603977430681;
 Thu, 29 Oct 2020 06:17:10 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:16:45 +0100
In-Reply-To: <20201029131649.182037-1-elver@google.com>
Message-Id: <20201029131649.182037-6-elver@google.com>
Mime-Version: 1.0
References: <20201029131649.182037-1-elver@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 5/9] mm, kfence: insert KFENCE hooks for SLUB
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, mark.rutland@arm.com, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Inserts KFENCE hooks into the SLUB allocator.

To pass the originally requested size to KFENCE, add an argument
'orig_size' to slab_alloc*(). The additional argument is required to
preserve the requested original size for kmalloc() allocations, which
uses size classes (e.g. an allocation of 272 bytes will return an object
of size 512). Therefore, kmem_cache::size does not represent the
kmalloc-caller's requested size, and we must introduce the argument
'orig_size' to propagate the originally requested size to KFENCE.

Without the originally requested size, we would not be able to detect
out-of-bounds accesses for objects placed at the end of a KFENCE object
page if that object is not equal to the kmalloc-size class it was
bucketed into.

When KFENCE is disabled, there is no additional overhead, since
slab_alloc*() functions are __always_inline.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
v5:
* Fix obj_to_index for kfence objects.

v3:
* Rewrite patch description to clarify need for 'orig_size'
  [reported by Christopher Lameter].
---
 include/linux/slub_def.h |  3 ++
 mm/slub.c                | 72 +++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 1be0ed5befa1..dcde82a4434c 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -7,6 +7,7 @@
  *
  * (C) 2007 SGI, Christoph Lameter
  */
+#include <linux/kfence.h>
 #include <linux/kobject.h>
 #include <linux/reciprocal_div.h>
 
@@ -185,6 +186,8 @@ static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
 					const struct page *page, void *obj)
 {
+	if (is_kfence_address(obj))
+		return 0;
 	return __obj_to_index(cache, page_address(page), obj);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index b30be2385d1c..95d9e2a45707 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -27,6 +27,7 @@
 #include <linux/ctype.h>
 #include <linux/debugobjects.h>
 #include <linux/kallsyms.h>
+#include <linux/kfence.h>
 #include <linux/memory.h>
 #include <linux/math64.h>
 #include <linux/fault-inject.h>
@@ -1553,6 +1554,11 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 	void *old_tail = *tail ? *tail : *head;
 	int rsize;
 
+	if (is_kfence_address(next)) {
+		slab_free_hook(s, next);
+		return true;
+	}
+
 	/* Head and tail of the reconstructed freelist */
 	*head = NULL;
 	*tail = NULL;
@@ -2658,7 +2664,8 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c,
+			  size_t orig_size)
 {
 	void *freelist;
 	struct page *page;
@@ -2763,7 +2770,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
  * cpu changes by refetching the per cpu area pointer.
  */
 static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c,
+			  size_t orig_size)
 {
 	void *p;
 	unsigned long flags;
@@ -2778,7 +2786,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c = this_cpu_ptr(s->cpu_slab);
 #endif
 
-	p = ___slab_alloc(s, gfpflags, node, addr, c);
+	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	local_irq_restore(flags);
 	return p;
 }
@@ -2805,7 +2813,7 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
  * Otherwise we can simply pick the next object from the lockless free list.
  */
 static __always_inline void *slab_alloc_node(struct kmem_cache *s,
-		gfp_t gfpflags, int node, unsigned long addr)
+		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
 	struct kmem_cache_cpu *c;
@@ -2816,6 +2824,11 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	s = slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
 	if (!s)
 		return NULL;
+
+	object = kfence_alloc(s, orig_size, gfpflags);
+	if (unlikely(object))
+		goto out;
+
 redo:
 	/*
 	 * Must read kmem_cache cpu data via this cpu ptr. Preemption is
@@ -2853,7 +2866,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	object = c->freelist;
 	page = c->page;
 	if (unlikely(!object || !node_match(page, node))) {
-		object = __slab_alloc(s, gfpflags, node, addr, c);
+		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
@@ -2888,20 +2901,21 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
 		memset(object, 0, s->object_size);
 
+out:
 	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
 
 	return object;
 }
 
 static __always_inline void *slab_alloc(struct kmem_cache *s,
-		gfp_t gfpflags, unsigned long addr)
+		gfp_t gfpflags, unsigned long addr, size_t orig_size)
 {
-	return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr);
+	return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
 void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
 {
-	void *ret = slab_alloc(s, gfpflags, _RET_IP_);
+	void *ret = slab_alloc(s, gfpflags, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
 				s->size, gfpflags);
@@ -2913,7 +2927,7 @@ EXPORT_SYMBOL(kmem_cache_alloc);
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
-	void *ret = slab_alloc(s, gfpflags, _RET_IP_);
+	void *ret = slab_alloc(s, gfpflags, _RET_IP_, size);
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -2924,7 +2938,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
+	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    s->object_size, s->size, gfpflags, node);
@@ -2938,7 +2952,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 				    gfp_t gfpflags,
 				    int node, size_t size)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_);
+	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
@@ -2972,6 +2986,9 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 
 	stat(s, FREE_SLOWPATH);
 
+	if (kfence_free(head))
+		return;
+
 	if (kmem_cache_debug(s) &&
 	    !free_debug_processing(s, page, head, tail, cnt, addr))
 		return;
@@ -3216,6 +3233,13 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 		df->s = cache_from_obj(s, object); /* Support for memcg */
 	}
 
+	if (is_kfence_address(object)) {
+		slab_free_hook(df->s, object);
+		WARN_ON(!kfence_free(object));
+		p[size] = NULL; /* mark object processed */
+		return size;
+	}
+
 	/* Start new detached freelist */
 	df->page = page;
 	set_freepointer(df->s, object, NULL);
@@ -3291,8 +3315,14 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	c = this_cpu_ptr(s->cpu_slab);
 
 	for (i = 0; i < size; i++) {
-		void *object = c->freelist;
+		void *object = kfence_alloc(s, s->object_size, flags);
 
+		if (unlikely(object)) {
+			p[i] = object;
+			continue;
+		}
+
+		object = c->freelist;
 		if (unlikely(!object)) {
 			/*
 			 * We may have removed an object from c->freelist using
@@ -3308,7 +3338,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * of re-populating per CPU c->freelist
 			 */
 			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c);
+					    _RET_IP_, c, size);
 			if (unlikely(!p[i]))
 				goto error;
 
@@ -3963,7 +3993,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, flags, _RET_IP_);
+	ret = slab_alloc(s, flags, _RET_IP_, size);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
 
@@ -4011,7 +4041,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, flags, node, _RET_IP_);
+	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
 
@@ -4037,6 +4067,7 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 	struct kmem_cache *s;
 	unsigned int offset;
 	size_t object_size;
+	bool is_kfence = is_kfence_address(ptr);
 
 	ptr = kasan_reset_tag(ptr);
 
@@ -4049,10 +4080,13 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 			       to_user, 0, n);
 
 	/* Find offset within object. */
-	offset = (ptr - page_address(page)) % s->size;
+	if (is_kfence)
+		offset = ptr - kfence_object_start(ptr);
+	else
+		offset = (ptr - page_address(page)) % s->size;
 
 	/* Adjust for redzone and reject if within the redzone. */
-	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE)) {
+	if (!is_kfence && kmem_cache_debug_flags(s, SLAB_RED_ZONE)) {
 		if (offset < s->red_left_pad)
 			usercopy_abort("SLUB object in left red zone",
 				       s->name, to_user, offset, n);
@@ -4461,7 +4495,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, gfpflags, caller);
+	ret = slab_alloc(s, gfpflags, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc(caller, ret, size, s->size, gfpflags);
@@ -4492,7 +4526,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, gfpflags, node, caller);
+	ret = slab_alloc_node(s, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
-- 
2.29.1.341.ge80a0c044ae-goog

