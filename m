Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9C2B2870
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKMWVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgKMWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:57 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C351C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:57 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id o19so4731288wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UzKiiLikh/yr7SuKd1LAVi3VD7zxpPGUKeQZkocVPmU=;
        b=Bjx95fLYPShRtv8g/ufbvIu9y//mZxxB+eubkSGsPC08JdIDeEUCheBPu3hL+KPpTG
         pv1uVOufhElpdQp8EIbun+S6MLB/YYShPW4iK0uFB0XVnctt21hRzuzQGc/wgAYjYVK0
         yy9JzsIzNljJeqjXjzfCXOygYIftGxSyreDSypZY5foV+7D5bJaeEZJnoVxp9dbG+xPV
         CcDkEN+13pZ+zloXnMldyy7kPHAPdLuLS2EqL14zMrIudCMsQ/QamfC0w6nX4cFyovwu
         wMmm6riErkXmTELkDVoIt0kxKChZ8oTi9pJHRVAIGbWPnpzGMbm4u+Q8ZKrRbFOcVzBB
         Mvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UzKiiLikh/yr7SuKd1LAVi3VD7zxpPGUKeQZkocVPmU=;
        b=av96FXq19KNYvzFRdo/RxQR7wp5+VgTr/g2UZkqiGeHREfAEwKCI8Ig+4Z8vgDDBWd
         IjJXj9s1QDshJi7R/ydESOcZli7qsHc3RaIIkxbiRo/bc3OrVb62RPVKRxR99U/N7cRt
         adLm5IF5VJYsdAH18bKIL8sZZU7gsW1+lBqUkDL2ErQROwzNjvHaI+CxS8BM4kZjZ0YM
         teyvyFMSjLUOUlcnrmAXu8GbuYs1o227ezJwjPbnvdoucGQJinx1da4ynaPTws5IhwOK
         iPLOMdO4+ja/5B01Fc7qUUPgwMO6urcpipSYHnoUGAe6fXBoU6MxUkYYx3wU6qLaNOag
         BGTA==
X-Gm-Message-State: AOAM533AqX4LE5dvno/we2JVHxFl0/ZMIhIOylrphSF+KqYy4sAbxzmp
        NqUOg5sSvDGAvJtqw2b8ibt0xXf4x3ZRG9Hc
X-Google-Smtp-Source: ABdhPJx46nAxIjBsn9TKraOEyyZoXB7EdQv6hzYJKw6QUWysK6zAJi+rlj4Q+xzSfZn7CD0jY3wUwIqBoQIbEwXS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:eacb:: with SMTP id
 o11mr6101808wrn.208.1605306056039; Fri, 13 Nov 2020 14:20:56 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:07 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <52518837b34d607abbf30855b3ac4cb1a9486946.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 17/19] kasan: clean up metadata allocation and usage
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN marks caches that are sanitized with the SLAB_KASAN cache flag.
Currently if the metadata that is appended after the object (stores e.g.
stack trace ids) doesn't fit into KMALLOC_MAX_SIZE (can only happen with
SLAB, see the comment in the patch), KASAN turns off sanitization
completely.

With this change sanitization of the object data is always enabled.
However the metadata is only stored when it fits. Instead of checking for
SLAB_KASAN flag accross the code to find out whether the metadata is
there, use cache->kasan_info.alloc/free_meta_offset. As 0 can be a valid
value for free_meta_offset, introduce KASAN_NO_FREE_META as an indicator
that the free metadata is missing.

Along the way rework __kasan_cache_create() and add claryfying comments.

Co-developed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Signed-off-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Icd947e2bea054cb5cfbdc6cf6652227d97032dcb
---
 mm/kasan/common.c         | 112 +++++++++++++++++++++++++-------------
 mm/kasan/generic.c        |  15 ++---
 mm/kasan/hw_tags.c        |   6 +-
 mm/kasan/kasan.h          |  13 ++++-
 mm/kasan/quarantine.c     |   8 +++
 mm/kasan/report.c         |  43 ++++++++-------
 mm/kasan/report_sw_tags.c |   9 ++-
 mm/kasan/sw_tags.c        |   4 ++
 8 files changed, 139 insertions(+), 71 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 42ba64fce8a3..cf874243efab 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -115,9 +115,6 @@ void __kasan_free_pages(struct page *page, unsigned int order)
  */
 static inline unsigned int optimal_redzone(unsigned int object_size)
 {
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC))
-		return 0;
-
 	return
 		object_size <= 64        - 16   ? 16 :
 		object_size <= 128       - 32   ? 32 :
@@ -131,47 +128,77 @@ static inline unsigned int optimal_redzone(unsigned int object_size)
 void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			  slab_flags_t *flags)
 {
-	unsigned int orig_size = *size;
-	unsigned int redzone_size;
-	int redzone_adjust;
+	unsigned int ok_size;
+	unsigned int optimal_size;
+
+	/*
+	 * SLAB_KASAN is used to mark caches as ones that are sanitized by
+	 * KASAN. Currently this is used in two places:
+	 * 1. In slab_ksize() when calculating the size of the accessible
+	 *    memory within the object.
+	 * 2. In slab_common.c to prevent merging of sanitized caches.
+	 */
+	*flags |= SLAB_KASAN;
 
-	if (!kasan_stack_collection_enabled()) {
-		*flags |= SLAB_KASAN;
+	if (!kasan_stack_collection_enabled())
 		return;
-	}
 
-	/* Add alloc meta. */
+	ok_size = *size;
+
+	/* Add alloc meta into redzone. */
 	cache->kasan_info.alloc_meta_offset = *size;
 	*size += sizeof(struct kasan_alloc_meta);
 
-	/* Add free meta. */
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
-	    (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
-	     cache->object_size < sizeof(struct kasan_free_meta))) {
-		cache->kasan_info.free_meta_offset = *size;
-		*size += sizeof(struct kasan_free_meta);
+	/*
+	 * If alloc meta doesn't fit, don't add it.
+	 * This can only happen with SLAB, as it has KMALLOC_MAX_SIZE equal
+	 * to KMALLOC_MAX_CACHE_SIZE and doesn't fall back to page_alloc for
+	 * larger sizes.
+	 */
+	if (*size > KMALLOC_MAX_SIZE) {
+		cache->kasan_info.alloc_meta_offset = 0;
+		*size = ok_size;
+		/* Continue, since free meta might still fit. */
 	}
 
-	redzone_size = optimal_redzone(cache->object_size);
-	redzone_adjust = redzone_size -	(*size - cache->object_size);
-	if (redzone_adjust > 0)
-		*size += redzone_adjust;
-
-	*size = min_t(unsigned int, KMALLOC_MAX_SIZE,
-			max(*size, cache->object_size + redzone_size));
+	/* Only the generic mode uses free meta or flexible redzones. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
+		return;
+	}
 
 	/*
-	 * If the metadata doesn't fit, don't enable KASAN at all.
+	 * Add free meta into redzone when it's not possible to store
+	 * it in the object. This is the case when:
+	 * 1. Object is SLAB_TYPESAFE_BY_RCU, which means that it can
+	 *    be touched after it was freed, or
+	 * 2. Object has a constructor, which means it's expected to
+	 *    retain its content until the next allocation, or
+	 * 3. Object is too small.
+	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
 	 */
-	if (*size <= cache->kasan_info.alloc_meta_offset ||
-			*size <= cache->kasan_info.free_meta_offset) {
-		cache->kasan_info.alloc_meta_offset = 0;
-		cache->kasan_info.free_meta_offset = 0;
-		*size = orig_size;
-		return;
+	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
+	    cache->object_size < sizeof(struct kasan_free_meta)) {
+		ok_size = *size;
+
+		cache->kasan_info.free_meta_offset = *size;
+		*size += sizeof(struct kasan_free_meta);
+
+		/* If free meta doesn't fit, don't add it. */
+		if (*size > KMALLOC_MAX_SIZE) {
+			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
+			*size = ok_size;
+		}
 	}
 
-	*flags |= SLAB_KASAN;
+	/* Calculate size with optimal redzone. */
+	optimal_size = cache->object_size + optimal_redzone(cache->object_size);
+	/* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */
+	if (optimal_size > KMALLOC_MAX_SIZE)
+		optimal_size = KMALLOC_MAX_SIZE;
+	/* Use optimal size if the size with added metas is not large enough. */
+	if (*size < optimal_size)
+		*size = optimal_size;
 }
 
 size_t __kasan_metadata_size(struct kmem_cache *cache)
@@ -187,15 +214,21 @@ size_t __kasan_metadata_size(struct kmem_cache *cache)
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 					      const void *object)
 {
+	if (!cache->kasan_info.alloc_meta_offset)
+		return NULL;
 	return kasan_reset_tag(object) + cache->kasan_info.alloc_meta_offset;
 }
 
+#ifdef CONFIG_KASAN_GENERIC
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 					    const void *object)
 {
 	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
+	if (cache->kasan_info.free_meta_offset == KASAN_NO_FREE_META)
+		return NULL;
 	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
 }
+#endif
 
 void __kasan_poison_slab(struct page *page)
 {
@@ -272,11 +305,9 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	struct kasan_alloc_meta *alloc_meta;
 
 	if (kasan_stack_collection_enabled()) {
-		if (!(cache->flags & SLAB_KASAN))
-			return (void *)object;
-
 		alloc_meta = kasan_get_alloc_meta(cache, object);
-		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+		if (alloc_meta)
+			__memset(alloc_meta, 0, sizeof(*alloc_meta));
 	}
 
 	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
@@ -318,8 +349,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (!kasan_stack_collection_enabled())
 		return false;
 
-	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
-			unlikely(!(cache->flags & SLAB_KASAN)))
+	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
 		return false;
 
 	kasan_set_free_info(cache, object, tag);
@@ -359,7 +389,11 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 
 static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
-	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (alloc_meta)
+		kasan_set_track(&alloc_meta->alloc_track, flags);
 }
 
 static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
@@ -389,7 +423,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	poison_range((void *)redzone_start, redzone_end - redzone_start,
 		     KASAN_KMALLOC_REDZONE);
 
-	if (kasan_stack_collection_enabled() && (cache->flags & SLAB_KASAN))
+	if (kasan_stack_collection_enabled())
 		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 9c6b77f8c4a4..157df6c762a4 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -338,10 +338,10 @@ void kasan_record_aux_stack(void *addr)
 	cache = page->slab_cache;
 	object = nearest_obj(cache, page, addr);
 	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return;
 
-	/*
-	 * record the last two call_rcu() call stacks.
-	 */
+	/* Record the last two call_rcu() call stacks. */
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
 	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
 }
@@ -352,11 +352,11 @@ void kasan_set_free_info(struct kmem_cache *cache,
 	struct kasan_free_meta *free_meta;
 
 	free_meta = kasan_get_free_meta(cache, object);
-	kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
+	if (!free_meta)
+		return;
 
-	/*
-	 *  the object was freed and has free track set
-	 */
+	kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
+	/* The object was freed and has free track set. */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREETRACK;
 }
 
@@ -365,5 +365,6 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 {
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_KMALLOC_FREETRACK)
 		return NULL;
+	/* Free meta must be present with KASAN_KMALLOC_FREETRACK. */
 	return &kasan_get_free_meta(cache, object)->free_track;
 }
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 30ce88935e9d..c91f2c06ecb5 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -187,7 +187,8 @@ void kasan_set_free_info(struct kmem_cache *cache,
 	struct kasan_alloc_meta *alloc_meta;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
-	kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
+	if (alloc_meta)
+		kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
 }
 
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
@@ -196,5 +197,8 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 	struct kasan_alloc_meta *alloc_meta;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return NULL;
+
 	return &alloc_meta->free_track[0];
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d01a5ac34f70..88a6e5bee156 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -156,20 +156,31 @@ struct kasan_alloc_meta {
 struct qlist_node {
 	struct qlist_node *next;
 };
+
+/*
+ * Generic mode either stores free meta in the object itself or in the redzone
+ * after the object. In the former case free meta offset is 0, in the latter
+ * case it has some sane value smaller than INT_MAX. Use INT_MAX as free meta
+ * offset when free meta isn't present.
+ */
+#define KASAN_NO_FREE_META INT_MAX
+
 struct kasan_free_meta {
+#ifdef CONFIG_KASAN_GENERIC
 	/* This field is used while the object is in the quarantine.
 	 * Otherwise it might be used for the allocator freelist.
 	 */
 	struct qlist_node quarantine_link;
-#ifdef CONFIG_KASAN_GENERIC
 	struct kasan_track free_track;
 #endif
 };
 
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 						const void *object);
+#ifdef CONFIG_KASAN_GENERIC
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
+#endif
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 0da3d37e1589..23f6bfb1e73f 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -135,7 +135,12 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	if (IS_ENABLED(CONFIG_SLAB))
 		local_irq_save(flags);
 
+	/*
+	 * As the object now gets freed from the quaratine, assume that its
+	 * free track is now longer valid.
+	 */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREE;
+
 	___cache_free(cache, object, _THIS_IP_);
 
 	if (IS_ENABLED(CONFIG_SLAB))
@@ -168,6 +173,9 @@ void quarantine_put(struct kmem_cache *cache, void *object)
 	struct qlist_head temp = QLIST_INIT;
 	struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
 
+	if (!meta)
+		return;
+
 	/*
 	 * Note: irq must be disabled until after we move the batch to the
 	 * global quarantine. Otherwise quarantine_remove_cache() can miss
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ffa6076b1710..8b6656d47983 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -168,32 +168,35 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 static void describe_object_stacks(struct kmem_cache *cache, void *object,
 					const void *addr, u8 tag)
 {
-	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
-
-	if (cache->flags & SLAB_KASAN) {
-		struct kasan_track *free_track;
+	struct kasan_alloc_meta *alloc_meta;
+	struct kasan_track *free_track;
 
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (alloc_meta) {
 		print_track(&alloc_meta->alloc_track, "Allocated");
 		pr_err("\n");
-		free_track = kasan_get_free_track(cache, object, tag);
-		if (free_track) {
-			print_track(free_track, "Freed");
-			pr_err("\n");
-		}
+	}
+
+	free_track = kasan_get_free_track(cache, object, tag);
+	if (free_track) {
+		print_track(free_track, "Freed");
+		pr_err("\n");
+	}
 
 #ifdef CONFIG_KASAN_GENERIC
-		if (alloc_meta->aux_stack[0]) {
-			pr_err("Last call_rcu():\n");
-			print_stack(alloc_meta->aux_stack[0]);
-			pr_err("\n");
-		}
-		if (alloc_meta->aux_stack[1]) {
-			pr_err("Second to last call_rcu():\n");
-			print_stack(alloc_meta->aux_stack[1]);
-			pr_err("\n");
-		}
-#endif
+	if (!alloc_meta)
+		return;
+	if (alloc_meta->aux_stack[0]) {
+		pr_err("Last call_rcu():\n");
+		print_stack(alloc_meta->aux_stack[0]);
+		pr_err("\n");
 	}
+	if (alloc_meta->aux_stack[1]) {
+		pr_err("Second to last call_rcu():\n");
+		print_stack(alloc_meta->aux_stack[1]);
+		pr_err("\n");
+	}
+#endif
 }
 
 static void describe_object(struct kmem_cache *cache, void *object,
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index 7604b46239d4..1b026793ad57 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -48,9 +48,12 @@ const char *get_bug_type(struct kasan_access_info *info)
 		object = nearest_obj(cache, page, (void *)addr);
 		alloc_meta = kasan_get_alloc_meta(cache, object);
 
-		for (i = 0; i < KASAN_NR_FREE_STACKS; i++)
-			if (alloc_meta->free_pointer_tag[i] == tag)
-				return "use-after-free";
+		if (alloc_meta) {
+			for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
+				if (alloc_meta->free_pointer_tag[i] == tag)
+					return "use-after-free";
+			}
+		}
 		return "out-of-bounds";
 	}
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index e17de2619bbf..5dcd830805b2 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -170,6 +170,8 @@ void kasan_set_free_info(struct kmem_cache *cache,
 	u8 idx = 0;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return;
 
 #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
 	idx = alloc_meta->free_track_idx;
@@ -187,6 +189,8 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 	int i = 0;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return NULL;
 
 #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
 	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
-- 
2.29.2.299.gdc1121823c-goog

