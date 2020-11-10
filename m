Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EAB2AE339
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbgKJWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbgKJWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:59 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BA1C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:58 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 14so1386523wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=o1/1nos0zFZPL9mIFzV6FCy+ZXGKjAVVVyDw35QavK4=;
        b=pkAAotdsfAMsRZfaOpyxx7Rz2i5IkNySqQ7JPwm6WoXvf8tTRT3Q89WWzscOmM4lDh
         1KGi706m82ncxB6mVp4FBO1UcMmWP8Gb0P8957QptILHOywu1qNMwfuKYw3HLwJ9BIMN
         WNTnXdEzAFWj/LpZ/WJjlmW5C8Hyetp98G3fl0GF/uO7ZxWVbMSnZNzJngYMewened/U
         8ELme7jBq1mJS2gzSdgGD8AqztiMTRgJDxQbGuOpP/ukvKwuWvZDTgQrTDnnTg0IZYvm
         0uC0bb03Tj4o97c1kQQIztRVIJcUsn4FyB+PpcD9AtSK1NOnzl4c5/8ycTVhjFz1ZQAz
         fHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o1/1nos0zFZPL9mIFzV6FCy+ZXGKjAVVVyDw35QavK4=;
        b=tW/khSucGt7VLcrOdse0RtVlWH9jyfToLmY7B/vPWUabo6ZV7IwLcHGgQlnHjHTaqA
         oDOxC02fG3BLxZaKVKRKC9edfaO9fq/t5d8e/e/fXBdEmgMq2NiWsfZizdvigLdNm0Yd
         Ds7lmCXCAWLBP6vPhdo0C2mDxKBI47QVZbgWcds7kiPVcXLZleOJrvkNvElFZBiTvbaB
         IoX9z3uTdP7vEVlfIY1hE6ax1yIF2YiFjMMiZNox718bZZRbS9XSBQHlqcmBWO1mo1xZ
         kItrfIAnu6/fF3lT+ToCPV1LqFDo6yUDLY6PraVtouY8lgDdFVRpkI9PaPVUbNBpLl7T
         uxng==
X-Gm-Message-State: AOAM5338bxABRgqsMCD7A4RE6Im9kWxdDQeA7LklNE0n8+POA40y0gXI
        6ky+2WDCijeCUab6wtVMsqnWf9P3grkZsfnX
X-Google-Smtp-Source: ABdhPJzmqSrplyUCQ4ds7REpp9Bb8+zoLNTCA47/0SwzZE9WT287XXOluXwd62ndMzbeEtx/MmT/5J+W8mDSzLx6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:10e:: with SMTP id
 o14mr26646190wrx.225.1605046857657; Tue, 10 Nov 2020 14:20:57 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:16 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <22c1a837d4d0c0b241a700c88f180f5e831a1953.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 12/20] kasan, mm: check kasan_enabled in annotations
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
index f1a5042ae4fc..779f8e703982 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_KASAN_H
 #define _LINUX_KASAN_H
 
+#include <linux/jump_label.h>
 #include <linux/types.h>
 
 struct kmem_cache;
@@ -74,56 +75,179 @@ static inline void kasan_disable_current(void) {}
 
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
@@ -134,36 +258,32 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
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
2.29.2.222.g5d2a92d10f8-goog

