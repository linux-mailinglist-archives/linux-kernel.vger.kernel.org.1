Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3F2A7390
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgKEADJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733032AbgKEADG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:06 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8AEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:05 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id t7so80044edt.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DKUUdpjKzvhCcD6WgylaP6PBqV8CAT8cUIeT7JoiXzA=;
        b=YYO+EYSiaJ4twGy9EpxxBHKXOuR9KlXFe4cIaNXWeybPoBnqdJf0ObepEkZt9/3nqr
         XorjNTapwBd1Hi0Ay4/6IxlLU/mNzbKNCTwpyPwb69amCwDDOBtsWiGqX1jcIzes780S
         jzKY/cMEj5TJIU9YcUgElw4N5D5SaC38/eUqKFQOJedrsFRN111a14pDJxVK1dz9LFlO
         mlrTgLBPjldgQRgCFwRpmCw9EPeM7p80jlopEISYUMtRTzmnW87B3W66/grcDzFuJPrI
         q2aY8dS+pQqTgUW4B8NSd/i6q8IzDIJh6H1Gs2CqOKok1WSVbLmq/TDrAIfb/tEn/uHq
         gA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DKUUdpjKzvhCcD6WgylaP6PBqV8CAT8cUIeT7JoiXzA=;
        b=oZYXEV7y+ImmgYTawi8Nkuc6X90C32FWsuAcOMiEaHeOYZf8j20yoVtRMgEBEJJ5iM
         V4hkSv/F/DWb48ugIprDFiQ+hXqRSd44J/lddtfC8rm5JQDR1Z39BB9C8ObwHm2aIy6s
         OKwRD/yxnC340tOTK6YeH0EB/WyUMm8ydg9KZe2pJXV8xbJpU4Yrp+yRh0NWA9QNKjiQ
         Au9qC9tovYqMFtetApFYkqBJSWpFx1HF7HUYUWBl5FUYIfjAExIUzCtxgGIJjnbiiCVo
         AVbq9qbHCtd+6OOPze3i0VJEGZkGoXS7Pa5a3ZvruS0r2DhAvNVZt4BNmqh3dyDEZfLn
         eFJw==
X-Gm-Message-State: AOAM530tuQUftaiugBBUg8V4aPqB3qwn95KrFNi9CNoukxauXlqbrtPk
        nzPUBf67bupW+TFu5xgjVJijRylgXGzLDjjL
X-Google-Smtp-Source: ABdhPJw9sKQRzZDY8K5Pn8mocA1Ivc0tkhgl0uN9rBcUneHik+B5q2nnAB7+jcQ+79C0iislPbJ5TmUzPcKEhMyu
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:14cf:: with SMTP id
 f15mr356123edx.18.1604534583946; Wed, 04 Nov 2020 16:03:03 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:22 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <f44efbb38afe1a1bc2bba2b4b6698e16cb216bbd.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 12/20] kasan, mm: check kasan_enabled in annotations
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the kasan_enabled static key in include/linux/kasan.h and in
include/linux/mm.h and check it in all kasan annotations. This allows to
avoid any slowdown caused by function calls when kasan_enabled is
disabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I2589451d3c96c97abbcbf714baabe6161c6f153e
---
 include/linux/kasan.h | 220 ++++++++++++++++++++++++++++++++----------
 include/linux/mm.h    |  22 +++--
 mm/kasan/common.c     |  60 ++++++------
 3 files changed, 216 insertions(+), 86 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 34236f134472..ae1046fc74e5 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_KASAN_H
 #define _LINUX_KASAN_H
 
+#include <linux/jump_label.h>
 #include <linux/types.h>
 
 struct kmem_cache;
@@ -72,56 +73,179 @@ static inline void kasan_disable_current(void) {}
 
 #ifdef CONFIG_KASAN
 
-void kasan_alloc_pages(struct page *page, unsigned int order);
-void kasan_free_pages(struct page *page, unsigned int order);
+struct kasan_cache {
+	int alloc_meta_offset;
+	int free_meta_offset;
+};
 
-void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
-			slab_flags_t *flags);
+#ifdef CONFIG_KASAN_HW_TAGS
+DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
+static inline kasan_enabled(void)
+{
+	return static_branch_likely(&kasan_flag_enabled);
+}
+#else
+static inline kasan_enabled(void)
+{
+	return true;
+}
+#endif
 
-void kasan_unpoison_data(const void *address, size_t size);
-void kasan_unpoison_slab(const void *ptr);
+void __kasan_alloc_pages(struct page *page, unsigned int order);
+static inline void kasan_alloc_pages(struct page *page, unsigned int order)
+{
+	if (kasan_enabled())
+		__kasan_alloc_pages(page, order);
+}
 
-void kasan_poison_slab(struct page *page);
-void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
-void kasan_poison_object_data(struct kmem_cache *cache, void *object);
-void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
-					const void *object);
+void __kasan_free_pages(struct page *page, unsigned int order);
+static inline void kasan_free_pages(struct page *page, unsigned int order)
+{
+	if (kasan_enabled())
+		__kasan_free_pages(page, order);
+}
 
-void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
-						gfp_t flags);
-void kasan_kfree_large(void *ptr, unsigned long ip);
-void kasan_poison_kfree(void *ptr, unsigned long ip);
-void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
-					size_t size, gfp_t flags);
-void * __must_check kasan_krealloc(const void *object, size_t new_size,
-					gfp_t flags);
+void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
+				slab_flags_t *flags);
+static inline void kasan_cache_create(struct kmem_cache *cache,
+			unsigned int *size, slab_flags_t *flags)
+{
+	if (kasan_enabled())
+		__kasan_cache_create(cache, size, flags);
+}
 
-void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
-					gfp_t flags);
-bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
+size_t __kasan_metadata_size(struct kmem_cache *cache);
+static inline size_t kasan_metadata_size(struct kmem_cache *cache)
+{
+	if (kasan_enabled())
+		return __kasan_metadata_size(cache);
+	return 0;
+}
 
-struct kasan_cache {
-	int alloc_meta_offset;
-	int free_meta_offset;
-};
+void __kasan_unpoison_data(const void *addr, size_t size);
+static inline void kasan_unpoison_data(const void *addr, size_t size)
+{
+	if (kasan_enabled())
+		__kasan_unpoison_data(addr, size);
+}
+
+void __kasan_unpoison_slab(const void *ptr);
+static inline void kasan_unpoison_slab(const void *ptr)
+{
+	if (kasan_enabled())
+		__kasan_unpoison_slab(ptr);
+}
+
+void __kasan_poison_slab(struct page *page);
+static inline void kasan_poison_slab(struct page *page)
+{
+	if (kasan_enabled())
+		return __kasan_poison_slab(page);
+}
+
+void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
+static inline void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
+{
+	if (kasan_enabled())
+		return __kasan_unpoison_object_data(cache, object);
+}
+
+void __kasan_poison_object_data(struct kmem_cache *cache, void *object);
+static inline void kasan_poison_object_data(struct kmem_cache *cache, void *object)
+{
+	if (kasan_enabled())
+		__kasan_poison_object_data(cache, object);
+}
+
+void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
+					  const void *object);
+static inline void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
+						      const void *object)
+{
+	if (kasan_enabled())
+		return __kasan_init_slab_obj(cache, object);
+	return (void *)object;
+}
+
+bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
+static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip)
+{
+	if (kasan_enabled())
+		return __kasan_slab_free(s, object, ip);
+	return false;
+}
+
+void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
+				       void *object, gfp_t flags);
+static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
+						   void *object, gfp_t flags)
+{
+	if (kasan_enabled())
+		return __kasan_slab_alloc(s, object, flags);
+	return object;
+}
 
-size_t kasan_metadata_size(struct kmem_cache *cache);
+void * __must_check __kasan_kmalloc(struct kmem_cache *s, const void *object,
+				    size_t size, gfp_t flags);
+static inline void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
+						size_t size, gfp_t flags)
+{
+	if (kasan_enabled())
+		return __kasan_kmalloc(s, object, size, flags);
+	return (void *)object;
+}
+
+void * __must_check __kasan_kmalloc_large(const void *ptr,
+					  size_t size, gfp_t flags);
+static inline void * __must_check kasan_kmalloc_large(const void *ptr,
+						      size_t size, gfp_t flags)
+{
+	if (kasan_enabled())
+		return __kasan_kmalloc_large(ptr, size, flags);
+	return (void *)ptr;
+}
+
+void * __must_check __kasan_krealloc(const void *object,
+				     size_t new_size, gfp_t flags);
+static inline void * __must_check kasan_krealloc(const void *object,
+						 size_t new_size, gfp_t flags)
+{
+	if (kasan_enabled())
+		return __kasan_krealloc(object, new_size, flags);
+	return (void *)object;
+}
+
+void __kasan_poison_kfree(void *ptr, unsigned long ip);
+static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
+{
+	if (kasan_enabled())
+		__kasan_poison_kfree(ptr, ip);
+}
+
+void __kasan_kfree_large(void *ptr, unsigned long ip);
+static inline void kasan_kfree_large(void *ptr, unsigned long ip)
+{
+	if (kasan_enabled())
+		__kasan_kfree_large(ptr, ip);
+}
 
 bool kasan_save_enable_multi_shot(void);
 void kasan_restore_multi_shot(bool enabled);
 
 #else /* CONFIG_KASAN */
 
+static inline kasan_enabled(void)
+{
+	return false;
+}
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
-
 static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
-
-static inline void kasan_unpoison_data(const void *address, size_t size) { }
-static inline void kasan_unpoison_slab(const void *ptr) { }
-
+static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
+static inline void kasan_unpoison_data(const void *address, size_t size) {}
+static inline void kasan_unpoison_slab(const void *ptr) {}
 static inline void kasan_poison_slab(struct page *page) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
@@ -132,36 +256,32 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
 {
 	return (void *)object;
 }
-
-static inline void *kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags)
+static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
+				   unsigned long ip)
 {
-	return ptr;
+	return false;
+}
+static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
+				   gfp_t flags)
+{
+	return object;
 }
-static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
-static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
 static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
 				size_t size, gfp_t flags)
 {
 	return (void *)object;
 }
+static inline void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+{
+	return (void *)ptr;
+}
 static inline void *kasan_krealloc(const void *object, size_t new_size,
 				 gfp_t flags)
 {
 	return (void *)object;
 }
-
-static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
-				   gfp_t flags)
-{
-	return object;
-}
-static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
-				   unsigned long ip)
-{
-	return false;
-}
-
-static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
+static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
+static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
 
 #endif /* CONFIG_KASAN */
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0793d03a4183..8d84a6b2fa3c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
+#include <linux/kasan.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -1414,22 +1415,30 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 #endif /* CONFIG_NUMA_BALANCING */
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+
 static inline u8 page_kasan_tag(const struct page *page)
 {
-	return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
+	if (kasan_enabled())
+		return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
+	return 0xff;
 }
 
 static inline void page_kasan_tag_set(struct page *page, u8 tag)
 {
-	page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
-	page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+	if (kasan_enabled()) {
+		page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
+		page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+	}
 }
 
 static inline void page_kasan_tag_reset(struct page *page)
 {
-	page_kasan_tag_set(page, 0xff);
+	if (kasan_enabled())
+		page_kasan_tag_set(page, 0xff);
 }
-#else
+
+#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
 static inline u8 page_kasan_tag(const struct page *page)
 {
 	return 0xff;
@@ -1437,7 +1446,8 @@ static inline u8 page_kasan_tag(const struct page *page)
 
 static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
 static inline void page_kasan_tag_reset(struct page *page) { }
-#endif
+
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
 
 static inline struct zone *page_zone(const struct page *page)
 {
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index efad5ed6a3bd..385863eaec2c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -81,7 +81,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 }
 #endif /* CONFIG_KASAN_STACK */
 
-void kasan_alloc_pages(struct page *page, unsigned int order)
+void __kasan_alloc_pages(struct page *page, unsigned int order)
 {
 	u8 tag;
 	unsigned long i;
@@ -95,7 +95,7 @@ void kasan_alloc_pages(struct page *page, unsigned int order)
 	kasan_unpoison_memory(page_address(page), PAGE_SIZE << order);
 }
 
-void kasan_free_pages(struct page *page, unsigned int order)
+void __kasan_free_pages(struct page *page, unsigned int order)
 {
 	if (likely(!PageHighMem(page)))
 		kasan_poison_memory(page_address(page),
@@ -122,8 +122,8 @@ static inline unsigned int optimal_redzone(unsigned int object_size)
 		object_size <= (1 << 16) - 1024 ? 1024 : 2048;
 }
 
-void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
-			slab_flags_t *flags)
+void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
+			  slab_flags_t *flags)
 {
 	unsigned int orig_size = *size;
 	unsigned int redzone_size;
@@ -168,7 +168,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	*flags |= SLAB_KASAN;
 }
 
-size_t kasan_metadata_size(struct kmem_cache *cache)
+size_t __kasan_metadata_size(struct kmem_cache *cache)
 {
 	if (!kasan_stack_collection_enabled())
 		return 0;
@@ -191,17 +191,17 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
 }
 
-void kasan_unpoison_data(const void *address, size_t size)
+void __kasan_unpoison_data(const void *addr, size_t size)
 {
-	kasan_unpoison_memory(address, size);
+	kasan_unpoison_memory(addr, size);
 }
 
-void kasan_unpoison_slab(const void *ptr)
+void __kasan_unpoison_slab(const void *ptr)
 {
 	kasan_unpoison_memory(ptr, __ksize(ptr));
 }
 
-void kasan_poison_slab(struct page *page)
+void __kasan_poison_slab(struct page *page)
 {
 	unsigned long i;
 
@@ -211,12 +211,12 @@ void kasan_poison_slab(struct page *page)
 			KASAN_KMALLOC_REDZONE);
 }
 
-void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
+void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 {
 	kasan_unpoison_memory(object, cache->object_size);
 }
 
-void kasan_poison_object_data(struct kmem_cache *cache, void *object)
+void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
 	kasan_poison_memory(object,
 			round_up(cache->object_size, KASAN_GRANULE_SIZE),
@@ -269,7 +269,7 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object,
 #endif
 }
 
-void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
+void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 						const void *object)
 {
 	struct kasan_alloc_meta *alloc_meta;
@@ -288,7 +288,7 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
+static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 			      unsigned long ip, bool quarantine)
 {
 	u8 tag;
@@ -331,9 +331,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	return IS_ENABLED(CONFIG_KASAN_GENERIC);
 }
 
-bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
+bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 {
-	return __kasan_slab_free(cache, object, ip, true);
+	return ____kasan_slab_free(cache, object, ip, true);
 }
 
 static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
@@ -341,7 +341,7 @@ static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
 }
 
-static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
+static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				size_t size, gfp_t flags, bool keep_tag)
 {
 	unsigned long redzone_start;
@@ -373,20 +373,20 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	return set_tag(object, tag);
 }
 
-void * __must_check kasan_slab_alloc(struct kmem_cache *cache, void *object,
-					gfp_t flags)
+void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
+					void *object, gfp_t flags)
 {
-	return __kasan_kmalloc(cache, object, cache->object_size, flags, false);
+	return ____kasan_kmalloc(cache, object, cache->object_size, flags, false);
 }
 
-void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
-				size_t size, gfp_t flags)
+void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object,
+					size_t size, gfp_t flags)
 {
-	return __kasan_kmalloc(cache, object, size, flags, true);
+	return ____kasan_kmalloc(cache, object, size, flags, true);
 }
-EXPORT_SYMBOL(kasan_kmalloc);
+EXPORT_SYMBOL(__kasan_kmalloc);
 
-void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
+void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 						gfp_t flags)
 {
 	struct page *page;
@@ -411,7 +411,7 @@ void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
 	return (void *)ptr;
 }
 
-void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
+void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flags)
 {
 	struct page *page;
 
@@ -421,13 +421,13 @@ void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
 	page = virt_to_head_page(object);
 
 	if (unlikely(!PageSlab(page)))
-		return kasan_kmalloc_large(object, size, flags);
+		return __kasan_kmalloc_large(object, size, flags);
 	else
-		return __kasan_kmalloc(page->slab_cache, object, size,
+		return ____kasan_kmalloc(page->slab_cache, object, size,
 						flags, true);
 }
 
-void kasan_poison_kfree(void *ptr, unsigned long ip)
+void __kasan_poison_kfree(void *ptr, unsigned long ip)
 {
 	struct page *page;
 
@@ -440,11 +440,11 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 		}
 		kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE);
 	} else {
-		__kasan_slab_free(page->slab_cache, ptr, ip, false);
+		____kasan_slab_free(page->slab_cache, ptr, ip, false);
 	}
 }
 
-void kasan_kfree_large(void *ptr, unsigned long ip)
+void __kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
-- 
2.29.1.341.ge80a0c044ae-goog

